@FieldPositioner =
  getCenterOffsets: (element, parent) ->
    element = $(element)
    parent  = $(parent)

    elementW = element.width()
    elementH = element.height()

    parentW = parent.width()
    parentH = parent.height()

    left: (-1*elementW/2)+(parentW/2)
    top: (-1*elementH/2)+(parentH/2)

  centerElement: (element, parent) ->
    offset = @getCenterOffsets element, parent

    element.css "left", offset.left
    element.css "top", offset.top

  # TODO: put this somewhere better
  enableFieldDraggable: (ele) ->
    unless ele.data("isDraggable")
      ele.data("isDraggable", true).draggable
        distance:     10
        containment:  "parent"
        opacity:      .8
        stack:        ".field-item"

