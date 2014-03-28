Template.fieldPost.rendered = ->
  @canvas = $(Session.get("field:canvas"))
  @ele = $(@firstNode)
  FieldPositioner.positionElement [@data.positionX, @data.positionY], @ele, @canvas

Template.fieldPost.events
  "mouseover .field-post": (e) ->
    ele = $(e.currentTarget)
    FieldPositioner.enableFieldDraggable ele
    FieldPositioner.onFieldItemDragstop ele, (position) =>
      Posts.update @_id,
        $inc:
          positionX: position[0]
          positionY: position[1]

  "dblclick .field-post": (e) ->
    Router.go "post",
      token: @token
