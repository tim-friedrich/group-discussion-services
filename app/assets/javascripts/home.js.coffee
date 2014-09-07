# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



initHome = () ->
  $teasers = $($(".teaser").children())
  $arrows = $(".separate-arrow")
  prevImages = $(".prev-images").find("img")

  $arrows.hide()
  $teasers.hide()
  $teasers.first().show()
  $arrows.first().show()

  prevImages.click((event)->
    $teasers.hide()
    $arrows.hide()
    $("."+$(event.target).attr("data-id")).show(800)
  )


$(window).load(()-> initHome())