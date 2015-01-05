class @VisualAid

  constructor: (@id, @url, @name, @media_type, @discussion) ->
    @commands =
      open: () => @open()
      close: () => @close()

  open: () =>
    @container = $('.chat').find('.top')
    $('#visual_aid_container').remove()
    @container.children().hide()
    @container.append(@visual_aid)

    if @discussion.current_user.is_moderator()
      $('#visual_aid_container').prepend('<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>')
      @container.find('button').click( (event) =>
        @send_command('close')
      )

  close: () =>
    container = $('.chat').find('.top')
    $('#visual_aid_container').remove()
    container.children().show()
    container.css('height', '125px')
    @discussion.view.resize()

  send_command: (command, params) =>
    $.ajax(
      type: 'POST'
      url: '/visual_aids/'+@id+'/command'
      data:
        id: @id
        command: command
        params: params
    )

  run_command: (command, params) =>
    @commands[command](params)
