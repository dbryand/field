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

Template.field.helpers
  field: ->
    Fields.findOne _id: Session.get('current:field')

  posts: ->
    Posts.find fieldId: Session.get('current:field')

  images: ->
    Images.find fieldId: Session.get('current:field')

  visible: ->
    # TODO: put this in a model.
    ! @trashed_at

Template.createPost.events
  "keyup #create-post": (evt, tmpl) ->
    if evt.which is 13
      post = tmpl.find("#create-post")

      Meteor.call "addPost", Session.get('current:field'),
        text: post.value

      $(post).val("").select().focus()

Template.closeField.events
  "click .close": (evt, tmpl) ->
    Router.go('home')

Template.trashField.events
  "click .trash": (evt, tmpl) ->
    Meteor.call "field:trash", Session.get('current:field')

Template.untrashField.events
  "click .untrash": (evt, tmpl) ->
    Meteor.call "field:untrash", Session.get('current:field')

Template.field.rendered = ->
  name = @find(".editable:not(.editable-click)")

  $(name).editable("destroy").editable
    success: (response, newValue) ->
      # TODO: Make sure I want to be issuing queries from here...
      Fields.update Session.get('current:field'),
        $set:
          name: newValue

  Deps.autorun ->
    Meteor.subscribe "fieldPosts", Session.get('current:field'),
    Meteor.subscribe "fieldImages", Session.get('current:field')
