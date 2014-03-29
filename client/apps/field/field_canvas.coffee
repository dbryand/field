# Field Canvas
# ----------------------------------------------------------------
Template.fieldCanvas.helpers
  posts: ->
    Posts.find fieldId: Session.get('current:field')

  images: ->
    Images.find fieldId: Session.get('current:field')

Template.fieldCanvas.events
  "mouseover #field-canvas": (e) ->
    ele = $(e.currentTarget)

    unless ele.data("isDraggable")
      ele.data('isDraggable', true).draggable
        cursor: "pointer"
        distance: 10

  "dblclick #field-canvas": (e, tmpl) ->
    # Meteor.call "post:create", Session.get('current:field'),
    #       name: post.value
    
    debugger

Template.fieldCanvas.rendered = ->
  unless @_rendered
    @_rendered = true
    # Center canvas
    element = $(@firstNode)
    container = $(window)
    FieldPositioner.positionElement [0, 0], element, container

    Session.set("field:canvas", "#" + element.attr("id"))

  Deps.autorun ->
    Meteor.subscribe "fieldPosts", Session.get('current:field')
    Meteor.subscribe "fieldImages", Session.get('current:field')