#= require discussion_client/model/visual_aid

class @ImageAid extends VisualAid

  open: () =>
    container = $('.chat').find('.top')
    $('#visual_aid_container').remove()
    container.children().hide()
    container.append(
      """
        <div id="visual_aid_container">
          <img src="https://#{ @url }" alt="#{ @name() }"/>
        </div>
      """)

    container
      .css('overflow', 'hidden')
      .css('height', '70%')

    image = container.find('img')

    if @discussion.current_user.is_moderator()
      $('#visual_aid_container').prepend('<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>')
      container.find('button').click( (event) =>
        @hide()
      )
    image.css('max-height', container.height()+'px')
    image.css('max-width', container.width()+'px')

    image.load(() =>
      container.css('height', $('#visual_aid_container').height()+'px')
      @discussion.view.resize()
    )

  close: () =>
    container = $('.chat').find('.top')
    $('#visual_aid_container').remove()
    container.children().show()
    container.css('height', '125px')
    @discussion.view.resize()