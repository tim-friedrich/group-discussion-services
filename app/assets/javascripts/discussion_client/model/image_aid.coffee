#= require discussion_client/model/visual_aid

class @ImageAid extends VisualAid

  open: () =>
    @visual_aid =
    """
        <div id="visual_aid_container">
          <img src="#{ @url }" alt="#{ @name }"/>
        </div>
      """

    super

    @container
    .css('overflow', 'hidden')
    .css('height', '70%')

    image = @container.find('img')

    image.css('max-height', @container.height()+'px')
    image.css('max-width', @container.width()+'px')

    image.load(() =>
      @container.css('height', $('#visual_aid_container').height()+'px')
      @discussion.view.resize()
    )
