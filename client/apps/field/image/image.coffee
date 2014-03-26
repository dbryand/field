Template.image.rendered = ->
  @canvas = $(Session.get("field:canvas"))
  @ele = $(@firstNode)
  FieldPositioner.positionElement [@data.positionX, @data.positionY], @ele, @canvas

Template.image.events =
  "mouseover .field-image": (e) ->
    ele = $(e.currentTarget)
    FieldPositioner.enableFieldDraggable ele
    FieldPositioner.onFieldItemDragstop ele, (position) =>
      Images.update @_id,
        $inc:
          positionX: position[0]
          positionY: position[1]
