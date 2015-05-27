class @User
  constructor: (@id, @name, @color, @is_present, @role, @discussion) ->

  leave: () =>
    $.ajax({
      type: 'POST',
      url: '/discussions/'+@discussion.id+'/leave',
      async: false
    })

  leaved: () =>
    @is_present = false
    @discussion.view.change_user_status(false, @)

  enter: () =>
    @is_present = true
    @discussion.view.change_user_status(true, @)

  argument_count: () =>
    arg = @discussion.arguments.filter((argument) =>
      argument.user == @
    )
    return arg.length

  is_moderator: () =>
    return @discussion.moderator.id == @id

  is_observer: () =>
    return @role == 'observer'

