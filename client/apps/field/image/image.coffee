Template.image.rendered = ->
  image = $(this.find(".image"))

  random = Math.floor(Math.random() * 500)
  random2 = Math.floor(Math.random() * 840)
  image.css("top", "#{random}px")
  image.css("left", "#{random2}px")

Template.image.events =
  "mouseover .image, touchstart .image": (e) ->
    ele = $(e.currentTarget)
    unless ele.data("isDraggable")
      ele.data("isDraggable", true).draggable
        distance: 3
