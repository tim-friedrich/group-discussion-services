@initHome = () =>
  @$teasers = $($(".teaser").find('.teaser-div'))
  @$arrows = $(".separate-arrow")
  @prevImages = $(".prev-image")
  $('.content').removeClass('content')
  @$arrows.hide()
  @$teasers.hide()
  @$left_nav = $('#nav-left')
  @$right_nav = $('#nav-right')
  @enabled = true
  $('#teaser-container').show()
  $('#separation-arrow-container').show()
  openPage(1, 'our-service-teaser')

  prevImages.click((event)=>
      openPage(1, $(event.target).attr("data-id"))
  )
  $('#nav-right').click((event) ->
    if !$(event.target).parent().hasClass('disabled')
      openPage($('.active').data('page')+1, $('.active').parent().attr('id'))
  )
  $('#nav-left').click((event) ->
    if !$(event.target).parent().hasClass('disabled')
      openPage($('.active').data('page')-1, $('.active').parent().attr('id'))
  )

openPage = (pageNumber, id) =>
  if (id != $('.active').parent().attr('id') or pageNumber != $('.active').data('page')) and @enabled
    @enabled = false
    @$arrows.hide()
    @$left_nav.parent().removeClass('disabled')
    @$right_nav.parent().removeClass('disabled')
    @$left_nav.show()
    @$right_nav.show()
    items = $("."+id)
    $('.active').animate({ width: '0px' }, 1000, () ->
      $(this).hide())
    @$teasers.removeClass('active')
    page = items.filter('[data-page='+pageNumber+']')
    page.addClass('active')
    page.show()
    page.animate({ width: '900px' }, 1000, () =>
      @enabled = true
    )

    items.filter('.separate-arrow').show()
    if pageNumber == 1
      @$left_nav.parent().addClass('disabled')
      @$left_nav.hide()
    if items.filter('[data-page='+(pageNumber+1)+']').length == 0
      @$right_nav.parent().addClass('disabled')
      @$right_nav.hide()


