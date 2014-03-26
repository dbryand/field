# Controller & Routes
# ----------------------------------------------------------------
FieldController = FastRender.RouteController.extend
  waitOn: ->
    Meteor.subscribe "fieldByToken", @params.token

  load: ->
    if field = Fields.findOne(token: @params.token)
      Session.set('current:field', field._id)

  unload: ->
    delete Session.keys['current:field']

Router.map ->
  @route 'field',
    path: '/f/:token'
    controller: FieldController
    fastRender: true

# Field Template
# ----------------------------------------------------------------
Template.field.helpers
  field: ->
    Fields.findOne _id: Session.get('current:field')

  visible: ->
    # TODO: put this in a model.
    ! @trashed_at

Template.field.events
  "click #field": (e, tmpl) ->
    #debugger

Template.field.rendered = ->
  $(@firstNode).fadeIn()

# Field Canvas
# ----------------------------------------------------------------
Template.fieldCanvas.helpers
  posts: ->
    Posts.find fieldId: Session.get('current:field')

  images: ->
    Images.find fieldId: Session.get('current:field')

Template.fieldCanvas.events
  "mouseover #field-canvas, touchstart #field-canvas": (e) ->
    ele = $(e.currentTarget)
    unless ele.data("isDraggable")
      ele.data("isDraggable", true).draggable
        distance: 3
        cursor: "pointer"

Template.fieldCanvas.rendered = ->
  unless @_rendered
    @_rendered = true
    ele = $(@firstNode)

    width  = ele.width()
    height = ele.height()

    ele.css('left', (width/2))
    ele.css('top', (height/2))

  Deps.autorun ->
    Meteor.subscribe "fieldPosts", Session.get('current:field'),
    Meteor.subscribe "fieldImages", Session.get('current:field')

# Field Title
# ----------------------------------------------------------------
Template.fieldTitle.rendered = ->
  name = @find(".editable:not(.editable-click)")

  $(name).editable("destroy").editable
    success: (response, newValue) ->
      # TODO: Make sure I want to be issuing queries from here...
      Fields.update Session.get('current:field'),
        $set:
          name: newValue

# Create Post
# ----------------------------------------------------------------
Template.createPost.events
  "keyup #create-post": (evt, tmpl) ->
    if evt.which is 13
      post = tmpl.find("#create-post")

      Meteor.call "addPost", Session.get('current:field'),
        text: post.value

      $(post).val("").select().focus()

# Close Field
# ----------------------------------------------------------------
Template.closeField.events
  "click .close": (evt, tmpl) ->
    Router.go('home')

# Trash Field
# ----------------------------------------------------------------
Template.trashField.events
  "click .trash": (evt, tmpl) ->
    Meteor.call "field:trash", Session.get('current:field')
    Router.go "home"

# Restore Field
# ----------------------------------------------------------------
Template.restoreField.events
  "click .restore": (evt, tmpl) ->
    Meteor.call "field:restore", Session.get('current:field')
