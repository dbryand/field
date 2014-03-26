Template.post.rendered = ->
  @canvas = $(Session.get("field:canvas"))
  @ele = $(@firstNode)
  FieldPositioner.positionElement [@data.positionX, @data.positionY], @ele, @canvas

Template.post.events
  "mouseover .field-post": (e) ->
    ele = $(e.currentTarget)
    FieldPositioner.enableFieldDraggable ele
    FieldPositioner.onFieldItemDragstop ele, (position) =>
      Posts.update @_id,
        $inc:
          positionX: position[0]
          positionY: position[1]
