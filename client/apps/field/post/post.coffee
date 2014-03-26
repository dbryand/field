Template.post.rendered = ->
  unless @_rendered
    @_rendered = true

    ele = $(@firstNode)
    canvas = $(Session.get("field:canvas"))

    FieldPositioner.centerElement ele, canvas

Template.post.events
  "mouseover .post, touchstart .post": (e) ->
    ele = $(e.currentTarget)
    FieldPositioner.enableFieldDraggable ele, @
