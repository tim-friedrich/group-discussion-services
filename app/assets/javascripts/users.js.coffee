

@register_paginations = () ->
  $(".pagination").find("a").on("click", (event) ->
    $.get(
      this.href,
      (data) => register_paginations()
      "script"
    )
    return false
  )


$ ->
  $('.datepicker').datepicker
    startView: 2