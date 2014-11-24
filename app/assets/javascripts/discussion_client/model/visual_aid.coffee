class @VisualAid
  constructor: (@id, @url, @discussion) ->

  name: () =>
    return @url.split('/')[@url.split('/').length-1]

  show: () =>
    $.post(
      '/visual_aids/'+@id+'/open'
    )

  hide: () =>
    $.post(
        '/visual_aids/'+@id+'/close'
    )

  open: () =>

  close: () =>
