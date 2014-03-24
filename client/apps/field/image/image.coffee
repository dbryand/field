Template.image.rendered = ->
  image = $(this.find(".image"))

  random = Math.floor(Math.random() * 500)
  random2 = Math.floor(Math.random() * 840)
  image.css("top", "#{random}px")
  image.css("left", "#{random2}px")

Template.image.events =
  "drag": (e, tmpl) ->
    #debugger
