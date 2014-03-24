FieldController = FastRender.RouteController.extend
  waitOn: ->
    Meteor.subscribe "fieldByToken", @params.token,

  load: ->
    if field = Fields.findOne(token: @params.token)
      Session.set('current:field', field._id)

  unload: ->
    delete Session.keys['current:field']

Router.map ->
  @route 'field',
    path: '/f/:token'
    controller: FieldController

Template.field.helpers
  field: ->
    Fields.findOne _id: Session.get('current:field')

  posts: ->
    Posts.find fieldId: Session.get('current:field')

  images: ->
    Images.find fieldId: Session.get('current:field')

Template.field.events
  "keyup #posttext": (evt, tmpl) ->
    if evt.which is 13
      post = tmpl.find("#posttext")

      Meteor.call "addPost", Session.get('current:field'),
        text: post.value

      $(post).val("").select().focus()

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
