# * Position: an [x, y] representing the placement of the center point of an element
# relative to the center point of another element. Usually, this will be the
# center point of the field-canvas.
#   * So, [-100, 50] means that the center point of this element should be placed
#     100px left of the center point, and 50px above the center point of the
#     container.
@FieldPositioner =
  getCenterOfElement: (element) ->
    elementW = $(element).outerWidth()
    elementH = $(element).outerHeight()

    [elementW/2, elementH/2]

  # position: [x, y] of center point offset.
  # element: The element to be positioned.
  # container: The containter in which the element will be positioned.
  positionElement: (position, element, container) ->
    elementCenter   = @getCenterOfElement element
    containerCenter = @getCenterOfElement container

    left = containerCenter[0] + position[0] - elementCenter[0]
    top = containerCenter[1] + position[1] - elementCenter[1]

    element.css "left", left + "px"
    element.css "top", top + "px"

  enableFieldDraggable: (ele) ->
    unless ele.data("isDraggable")
      ele.data("isDraggable", true).draggable
        addClasses:   false
        containment:  "parent"
        opacity:      .8

  onFieldItemDragstop: (ele, callback) ->
    unless ele.data("hasDragstop")
      ele.data("hasDragstop", true).on "dragstop", (e, ui) ->
        console.log "drop"
        start = ui.originalPosition
        stop  = ui.position

        left = stop.left - start.left
        top  = stop.top - start.top

        callback [left, top]
