#= require discussion_client/view/moderator_view
#= require discussion_client/view/proband_view

class @Discussion
  constructor: () ->
    @arguments = []
    @users = []
    @visual_aids = []
    @load_discussion()

  new_argument: (json) =>
    argument = new Argument(
      id = json.id,
      content = json.content,
      user = @users.filter((user) => user.id == json.user_id)[0],
      timestamp = new Date(json.created_at),
      discussion = @,
      type = json.argument_type,
    )
    @arguments.push(argument)
    return argument

  bind_new_argument: () =>
    PrivatePub.subscribe("/discussion/"+@id+"/arguments/new", (data) =>
      argument = @new_argument(data)
      @view.draw_argument(argument)
    )

    if @current_user.is_moderator() or @current_user.role == 'observer'
      PrivatePub.subscribe("/discussion/"+@id+"/observer/arguments/new", (data) =>
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
            is_present = user.is_present,
            role = user.role,
            @
          )
          @users.push(new_user)
        )
        $.each(json.discussion.arguments, (index, argument) =>
          @new_argument(argument)
        )
        $.each(json.discussion.visual_aids, (index, visual_aid) =>
          @visual_aids.push(new ImageAid(
            id = visual_aid.id,
            url = visual_aid.url,
            @
          ))
        )
        if json.discussion.votes
          $.each(json.discussion.votes, (index, vote) =>
            @arguments.filter((argument) => argument.id == vote.argument_id)[0].votes.push(vote)
          )
        @current_user = @users.filter((user) => user.id == json.current_user_id)[0]
        @moderator = @users.filter((user) => user.id == json.discussion.moderator_id)[0]
        @questions = json.discussion.questions
        @init_discussion()

        last_log = json.discussion.visual_aids_logs[json.discussion.visual_aids_logs.length-1]
        if last_log?.open == true
          $.each(@visual_aids, (index, visual_aid) =>
            if(visual_aid.id == last_log.visual_aid_id)
              visual_aid.open()
          )
    )

  init_discussion: () =>
    if @current_user.is_moderator()
      @view = new ModeratorView(@)
    else if @current_user.role == 'proband'
      @view = new ProbandView(@)
    else if @current_user.role == 'observer'
      @view = new ObserverView(@)
    @view.draw()

    @bind_new_argument()
    @bind_new_question()
    @bind_new_vote()
    @bind_user_entered()
    @bind_user_leaved()
    @bind_open_visual_aid()
    @bind_close_visual_aid()
    window.onbeforeunload = () => @current_user.leave()


  bind_user_leaved: () =>
    PrivatePub.subscribe("/discussion/"+@id+"/users/leave", (data) =>
      $.each(@users, (index, user) =>
        if data.user_id == user.id
          user.leaved()
      )
    )

  bind_open_visual_aid: () =>
    PrivatePub.subscribe("/discussion/"+@id+"/visualAid/open", (data) =>
      $.each(@visual_aids, (index, visual_aid) =>
        if visual_aid.id == data.id
          visual_aid.open()
      )
    )

  bind_close_visual_aid: () =>
    PrivatePub.subscribe("/discussion/"+@id+"/visualAid/close", (data) =>
      $.each(@visual_aids, (index, visual_aid) =>
        if visual_aid.id == data.id
          visual_aid.close()
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