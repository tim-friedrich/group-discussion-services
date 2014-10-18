#= require discussion_client/view/moderator_view
#= require discussion_client/view/proband_view

class @Discussion
  constructor: () ->
    @arguments = []
    @users = []
    @load_discussion()

  new_argument: (json) =>
    argument = new Argument(
      id = json.id,
      content = json.content,
      user = @users.filter((user) => user.id == json.user_id)[0],
      timestamp = new Date(json.created_at),
      discussion = @,
      type = json.argument_type,
      is_voted = json.is_voted,
      votes = json.votes
    )
    @arguments.push(argument)
    return argument

  bind_new_argument: () =>
    PrivatePub.subscribe("/discussion/"+@id+"/arguments/new", (data) =>
      argument = @new_argument(data)
      @view.draw_argument(argument)
    )

  bind_new_question: () =>
    PrivatePub.subscribe("/discussion/"+@id+"/questions/new", (data) ->
      $("#question").text("Frage: "+data.topic)
    )

  load_discussion: () =>
    $.getJSON(
      ""
      (json) =>
        @id = json.discussion.id
        @topic = json.discussion.topic
        #@conversation.set_question(discussion.questions[discussion.questions.length])
        $.each(json.discussion.users, (index, user) =>
          new_user = new User(
            id = user.id,
            name = user.name,
            color = user.color,
            is_present = user.is_present
            @
          )
          @users.push(new_user)
        )
        $.each(json.discussion.arguments, (index, argument) =>
          @new_argument(argument)
        )
        @current_user = @users.filter((user) => user.id == json.current_user_id)[0]
        @moderator = @users.filter((user) => user.id == json.discussion.moderator_id)[0]
        @questions = json.discussion.questions
        @init_discussion()
    )

  init_discussion: () =>
    if @current_user == @moderator
      @view = new ModeratorView(@)
    else
      @view = new ProbandView(@)
    @view.draw()

    @bind_new_argument()
    @bind_new_question()
    @bind_new_vote()
    @bind_user_entered()
    @bind_user_leaved()
    window.onbeforeunload = () => @current_user.leave()


  bind_user_leaved: () =>
    PrivatePub.subscribe("/discussion/"+@id+"/users/leave", (data) =>
      $.each(@users, (index, user) =>
        if data.user_id == user.id
          user.leaved()
      )
    )

  bind_user_entered: () =>
    PrivatePub.subscribe("/discussion/"+@id+"/users/enter", (data) =>
      $.each(@users, (index, user) =>
        if data.user_id == user.id
          user.enter()
      )
    )

  bind_new_vote: () =>
    if @ and @current_user.is_moderator()
      PrivatePub.subscribe("/discussion/"+@id+"/votes/new", (vote) =>
        argument = @arguments.filter((argument) => vote.argument_id == argument.id)[0]
        argument.add_vote(vote)
      )