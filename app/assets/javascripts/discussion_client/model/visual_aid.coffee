class @VisualAid

  constructor: (@id, @url, @name, @media_type, @discussion) ->
    @commands =
      open: () => @open()
      close: () => @close()

  open: () =>
    $('#discussion').find('#moderator').hide()
    $('#visual_aid_container').remove()
    
    $('.chat_container').prepend(@visual_aid)
    @container = $('#visual_aid_container')

    if @discussion.current_user.is_moderator()
      $('#visual_aid_container').prepend('<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>')
      $('#visual_aid_container').find('button').click( (event) =>
        @send_command('close')
      )

    $('#visual_aid_container').find('img').load(()=>
      @discussion.view.resize()
    )

  close: () =>
    container = $('.chat').find('.top')
    $('#visual_aid_container').remove()
    $('#moderator').show()
    #container.css('height', '125px')
    $('#visual_aids').find('.active').removeClass('active')
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
