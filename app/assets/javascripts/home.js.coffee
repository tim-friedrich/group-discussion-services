
@initHome = () =>
  @$teasers = $($(".teaser").find('.teaser-div'))
  @$arrows = $(".separate-arrow")
  @prevImages = $(".prev-image")
  $('.content').removeClass('content')
  @$arrows.hide()
  @$teasers.hide()
  openPage(1, 'our-service-teaser')

  prevImages.click((event)->
    openPage(1, $(event.target).attr("data-id"))
  )
  $('#nav-right').click((event) ->
    if !$(event.target).hasClass('disabled')
      openPage($('.active').data('page')+1, $('.active').parent().attr('id'))
  )
  $('#nav-left').click((event) ->
    if !$(event.target).hasClass('disabled')
      openPage($('.active').data('page')-1, $('.active').parent().attr('id'))
  )

openPage = (pageNumber, id) =>


  @$arrows.hide()
  $('#nav-left').removeClass('disabled')
  $('#nav-right').removeClass('disabled')
  items = $("."+id)
  $('.active').animate({ width: '0px' }, 1000, () ->
    $(this).hide())
  @$teasers.removeClass('active')
  page = items.filter('[data-page='+pageNumber+']')
  page.addClass('active')

  page.animate({ width: '900px' }, 1000 )
  page.show()
  items.filter('.separate-arrow').show()
  if pageNumber == 1
    $('#nav-left').addClass('disabled')
  if items.filter('[data-page='+(pageNumber+1)+']').length == 0
    $('#nav-right').addClass('disabled')
