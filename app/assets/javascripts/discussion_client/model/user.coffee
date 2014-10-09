class @User
  constructor: (@id, @name, @color, @discussion) ->

  enter: () =>
    $.ajax({
      type: 'POST',
      url: '/discussions/'+$('#discussion').attr('data-discussionId')+'/enter'
    })

  leave: () ->
    $.ajax({
      type: 'POST',
      url: '/discussions/'+$('#discussion').attr('data-discussionId')+'/leave',
      async: false
    })

  leaved: () =>
    $.ajax({
      type: 'GET',
      url: '/user_leaved/'+data.user_id
    })

  entered: () =>
    $.ajax({
      type: 'GET',
      url: '/user_entered/'+data.user_id
    })

  argument_count: () =>
    arg = @discussion.arguments.filter((argument) =>
      argument.user == @
    )
    return arg.length

  is_moderator: () =>
    return @discussion.moderator.id == @id
