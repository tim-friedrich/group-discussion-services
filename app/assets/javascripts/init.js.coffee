$ ->
  # Improve bootstrap tabs
  $('.nav-tabs').stickyTabs()

  # Register datepickers
  $('.datepicker').datepicker
    startView: 2

  # Popovers
  $('[data-toggle="popover"]').popover()
  $('[data-toggle="popover"]').mouseenter (event) ->
    $(event.target).popover('show')
  $('[data-toggle="popover"]').mouseleave (event) ->
    $(event.target).popover('hide')
