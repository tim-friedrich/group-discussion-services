class @View

  constructor: (@discussion) ->
    @register_events()
    $('body').attr("data-no-turbolink", "true")
    @is_question = false
    @proband_chat = $("#discussion_chat")
    @moderator_chat = $("#moderator_chat")

  submit_argument: () =>
    $("#new_argument_button").submit()
    $('#argument_content').val('')

  scroll_down: (div) =>
    div.stop().animate({
      scrollTop: div[0].scrollHeight}, 800)

  #event registration
  register_events: () =>

    $("#new_question_button").click( (event) =>
      is_question = true
      $.ajax({
        type: 'POST',
        url: '/questions/',
        data:
          question:
            topic: $('#argument_content').val()
            discussion_id:  @discussion.id
      })
      $('#argument_content').val('')
    )

    $("#new_argument").submit( (event) =>
      if (@is_question)
        @is_question = false
        return false

      @is_question = false
      return true
    )

    $("#new_argument_button").click( (event) =>
      @submit_argument()
    )

    $('#argument_content').keydown( (event) =>
      if(event.keyCode == 13)
        @submit_argument()
        return false
    )

  draw: () =>
    @draw_arguments()
    @scroll_down(@moderator_chat)
    @scroll_down(@proband_chat)
    @update_question(@discussion.questions[..].pop())
    @draw_toolbox()

  draw_arguments: () =>
    $.each(@discussion.arguments, (index, argument) =>
      @draw_argument(argument)
    )

  draw_argument: (argument) =>

    if argument.type == 'proband'
      chat = @proband_chat

    if argument.type == 'moderator'
      chat = @moderator_chat

    if @scrolled_down(chat)
      scroll = true

    argument.dom_element = chat.append(argument.dom_element).children().last()

    if argument.type == 'proband'
      @draw_voting(argument)

    if scroll
      @scroll_down(chat)

  draw_voting: (argument) =>

  draw_toolbox:() =>
    @draw_probands_toolbox()
    $('.nav-tabs a').click((e) =>
      e.preventDefault()
      $(this).tab('show')
    )

  draw_probands_toolbox: () =>
    template =
      """
        <div class="tab-pane active" id="users">
          <div class="panel panel-default probands">

            <ul class="list-group proband-list">

            </ul>
          </div>
        </div>
      """

    $(".toolbox").find(".tab-content").append(template)

    $(".toolbox").find(".nav-tabs").append(
      """
        <li class="active"><a href="#users" role="tab" data-toggle="tab">Teilnehmer</a></li>
      """)

    $.each(@discussion.users, (index, user) =>
      $(".proband-list").append(
        """
          <li class="list-group-item">
            <div style="width: 5px; height: 20px; background-color: #{ user.color }; float: left"></div>
            #{ user.name }
            <div class="proband-status"><img src="#{ image_path("offline.jpg") }"></img></div>
          </li>
        """
      )
      if user.is_present
        @change_user_status(true, user)
    )

  update_question: (question) =>
    $("#question").text(question.topic)


  change_user_status: (online=true, user) =>
    images = $(".proband-list").children()
    img = $((image for image in images when image.textContent.trim() == user.name)).find("img")

    if online
      img.attr("src", image_path("online.jpg"))
    else
      img.attr("src", image_path("offline.jpg"))

  scrolled_down: (elem) =>
    return ( elem.outerHeight() + 5 > elem[0].scrollHeight - elem.scrollTop() > elem.outerHeight() - 5)