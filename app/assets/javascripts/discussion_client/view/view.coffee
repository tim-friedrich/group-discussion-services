#= require discussion_client/helpers

class @View

  constructor: (@discussion) ->
    @register_events()
    @is_question = false
    @chat = $("#arguments")
    @argument_input = $('#new_argument_content')

  scroll_down: (div) =>
    div.stop().animate({
      scrollTop: div[0].scrollHeight}, 800)

  #event registration
  register_events: () =>
    $("#new_question_button").click( (event) =>
      event.preventDefault
      $.ajax({
        type: 'POST',
        url: '/questions/',
        data:
          question:
            topic: @argument_input.text()
            discussion_id:  @discussion.id
      })
      $('#new_argument_content').text("")
    )

    $("#new_argument_button").click( (event) =>
      event.preventDefault()
      @submit_argument(@discussion.current_user.role)
      return false;
    )

    $("#new_observer_argument_button").click( (event) =>
      event.preventDefault()
      @submit_argument('observer')
      return false
    )

    $('#new_argument_content').keydown( (event) =>
      content_div = $('#new_argument_content')
      if(event.keyCode == 13)
        @submit_argument(@discussion.current_user.role)
        return false

      if(event.keyCode == 32)
        caret = content_div.caret('pos')
        content_div.html($.emoticons.replace($("#new_argument_content").text()))
        content_div.find('.emoticon').attr("contenteditable", "false")
        window.set_caret(document.getElementById("new_argument_content"), caret)
    )
    $('#new_argument').submit((event)=>
      return false
    )

    $('.emoticon_picker').on("mouseenter", (event) =>
      $('.emoticon_prev').show()
    )

    $('.emoticon_prev').on("mouseleave", (event) =>
      $('.emoticon_prev').hide()
    )

    $('.emoticon_prev').on('click', 'input', (event) =>
      $argument = $('#new_argument_content')
      caret = $argument.caret('pos')
      post = $argument.text()
      post = post.substr(0, caret)+""+$(event.target).attr('data-type')+post.substr(caret, post.length)
      $argument.html($.emoticons.replace(post))
      $('#new_argument_content .emoticon').attr("contenteditable", "false")
      window.set_caret(document.getElementById("new_argument_content"), caret+$(event.target).attr('data-type').length)
    )

    $(window).resize(() =>
      @resize()
    )

  submit_argument: (type) =>
    if not type?
      type = @discussion.current_user.role

    $.ajax({
      type: 'POST',
      url: '/arguments/',
      data:
        argument:
          content: @argument_input.text()
          discussion_id:  @discussion.id
          type: type
    })
    @argument_input.text("")

  draw: () =>
    $('header').hide()
    @init_emoticons()
    @draw_arguments()
    @scroll_down(@chat)
    @update_question(@discussion.questions[..].pop())
    @draw_toolbox()
    @draw_emoticon_prev()
    @resize()


  draw_arguments: () =>
    $.each(@discussion.arguments, (index, argument) =>
      @draw_argument(argument)
    )

  draw_argument: (argument) =>
    argument.generate_dom()

    if @scrolled_down(@chat)
      scroll = true

    argument.dom_element = @chat.append(argument.dom_element).children().last()

    if argument.type == 'proband'
      @draw_voting(argument)

    if scroll
      @scroll_down(@chat)

    argument.dom_element.find('.argument_content').click( () =>
      @add_user_reference_to_input(argument.user)
    )
    argument.dom_element.find('.user').click( () =>
      @add_user_reference_to_input(argument.user)
    )

  add_user_reference_to_input: (user) =>
    @argument_input.text(@argument_input.text()+"@"+user.name+": ")
    @argument_input.focus()
    window.set_caret(document.getElementById("new_argument_content"), @argument_input.text().length)


  draw_voting: (argument) =>

  draw_emoticon_prev: ()=>
    prev = $('.emoticon_prev')
    $.each(@emoticons, (key, value) =>

      emoticon = $.emoticons.replace(value.codes[0])
      prev.append('<input type="button" class="'+$(emoticon).attr("class")+'" data-type="'+value.codes[0]+'">')
    )

  draw_toolbox:() =>
    @draw_probands_toolbox()
    $('.nav-tabs a').click((e) =>
      e.preventDefault()
      $(this).tab('show')
    )

  draw_probands_list: () =>
    $.each(@discussion.users, (index, user) =>
      @draw_proband(user)
    )

  draw_proband: (user) =>
    if user.role == 'proband'
      proband_list = $("#probands-list")
      proband_list.append(
          """
            <li id="#{ user.id }" class="offline">
              <div class="proband-name">#{ user.name }</div>
              <div class="proband-color" style=" background-color: #{ user.color }"></div>
            </li>

          """
      )
      if user.is_present
        @change_user_status(true, user)

      proband_list.children().last().click( (event) =>
        @add_user_reference_to_input(user)
      )

  update_question: (question) =>
    $("#question").text(question.topic)


  change_user_status: (online=true, user) =>
    proband = $("#probands-list").find("##{ user.id }")

    if online
      proband.removeClass("offline")
    else
      proband.addClass("offline")

  scrolled_down: (elem) =>
    return ( elem.outerHeight() + 5 > elem[0].scrollHeight - elem.scrollTop() > elem.outerHeight() - 5)

  resize: () =>
    if $('#visual_aid_container').length
      chat_height = $(window).height()-($('#new_argument').height()+30)-($('#visual_aid_container').height());
    else
      chat_height = $(window).height()-($('.moderator').height()+50)-($('#new_argument').height()+30)-60;
    if chat_height < 130
      chat_height = 130
    

    if chat_height < 130
      chat_height = 130

    $('#chat').css('height', chat_height+'px')
    @scroll_down(@chat)

  init_emoticons: () =>
    @emoticons =
      "smile":
        "title": "Smile",
        "codes": [":)", ":=)", ":-)"]

      "sad-smile":
        "title": "Sad Smile",
        "codes": [":(", ":=(", ":-("]

      "big-smile":
        "title": "Big Smile",
        "codes": [":D", ":=D", ":-D", ":d", ":=d", ":-d"]

      "cool":
        "title": "cool",
        "codes": ["8)", "8=)", "8-)", "B)", "B=)", "B-)", "(cool)"]

      "wink":
        "title": "Wink",
        "codes": [":o", ":=o", ":-o", ":O", ":=O", ":-O", ";)", ";-)"]

      "crying":
        "title": "Crying",
        "codes": [";(", ";-(", ";=("]

      "sweating":
        "title": "Sweating",
        "codes": ["(sweat)", "(:|"]

      "speechless":
        "title": "Speechless",
        "codes": [":|", ":=|", ":-|"]

      "kiss":
        "title": "Kiss",
        "codes": [":*", ":=*", ":-*"]

      "tongue-out":
        "title": "Tongue Out",
        "codes": [":P", ":=P", ":-P", ":p", ":=p", ":-p"]

      "blush":
        "title": "Blush",
        "codes": ["(blush)", ":$", ":-$", ":=$", ":\">"]

      "wondering":
        "title": "Wondering",
        "codes": [":^)"]

      "sleepy":
        "title": "Sleepy",
        "codes": ["|-)", "I-)", "I=)", "(snooze)"]

      "dull":
        "title": "Dull",
        "codes": ["|(", "|-(", "|=("]

      "in-love":
        "title": "In love",
        "codes": ["(inlove)"]

      "evil-grin":
        "title": "Evil grin",
        "codes": ["]:)", ">:)", "(grin)"]

      "talking":
        "title": "Talking",
        "codes": ["(talk)"]

      "yawn":
        "title": "Yawn",
        "codes": ["(yawn)", "|-()"]

      "angry":
        "title": "Angry",
        "codes": [":@", ":-@", ":=@", "x(", "x-(", "x=(", "X(", "X-(", "X=("]

      "it-wasnt-me":
        "title": "It wasn't me",
        "codes": ["(wasntme)"]

      "kiss":
        "title": "Kiss",
        "codes": [":*", ":=*", ":-*"]

      "tongue-out":
        "title": "Tongue Out",
        "codes": [":P", ":=P", ":-P", ":p", ":=p", ":-p"]

      "worried":
        "title": "Worried",
        "codes": [":S", ":-S", ":=S", ":s", ":-s", ":=s"]


    $.emoticons.define(@emoticons);

