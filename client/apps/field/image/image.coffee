Template.image.rendered = ->
  unless @_rendered
    @_rendered = true

    ele = $(@firstNode)
    canvas = $(Session.get("field:canvas"))

    FieldPositioner.centerElement ele, canvas
    FieldPositioner.repositionElement ele, @data.ui

Template.image.events =
  "mouseover .image, touchstart .image": (e) ->
    ele = $(e.currentTarget)
    FieldPositioner.enableFieldDraggable ele

    ele.on "dragstop", (e, ui) =>
      start = ui.originalPosition
      stop  = ui.position

      left = stop.left - start.left
      top  = stop.top - start.top

      Images.update @_id,
        $set:
          ui:
            top:  top
            left: left
