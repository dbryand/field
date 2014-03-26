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

  repositionElement: (element, offsets) ->
    top = parseInt element.css("top"), 10
    left = parseInt element.css("left"), 10

    element.css "left", top + offsets.left + "px"
    element.css "top", left + offsets.top + "px"

  enableFieldDraggable: (ele) ->
    unless ele.data("isDraggable")
      ele.data("isDraggable", true).draggable
        addClasses:   false
        distance:     10
        containment:  "parent"
        opacity:      .8
        stack:        ".field-item"
