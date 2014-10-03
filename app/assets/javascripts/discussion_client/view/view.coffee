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

    #window.onbeforeunload = () -> leave_discussion()

  draw: () =>
    @draw_arguments()
    @update_question(@discussion.questions[..].pop())
    @draw_toolbox()

  draw_arguments: () =>
    $.each(@discussion.arguments, (index, argument) =>
      @draw_argument(argument)
    )

  draw_argument: (argument) =>
    if argument.type == 'proband'
      argument.dom_element = @proband_chat.append(argument.dom_element).children().last()
      @draw_voting(argument)

    if argument.type == 'moderator'
      argument.dom_element = @moderator_chat.append(argument.dom_element).children().last()

    @scroll_down($('#moderator_chat'))
    @scroll_down($('#discussion_chat'))

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
            <div class="panel-heading"><h3 class="panel-title">Teilnehmer</h3></div>

            <ul class="list-group probands_list">

            </ul>
          </div>
        </div>
      """

    $(".toolbox").find(".tab-content").append(template)

    $(".toolbox").find(".nav-tabs").append(
      """
        <li class="active"><a href="#users" role="tab" data-toggle="tab">Teilnehmer</a></li>
      """)


  update_question: (question) =>
    $("#question").text(question.topic)