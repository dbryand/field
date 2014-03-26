Template.image.rendered = ->
  unless @_rendered
    @_rendered = true

    ele = $(@firstNode)
    canvas = $(Session.get("field:canvas"))

    FieldPositioner.centerElement ele, canvas

Template.image.events =
  "mouseover .image, touchstart .image": (e) ->
    ele = $(e.currentTarget)
    FieldPositioner.enableFieldDraggable ele
