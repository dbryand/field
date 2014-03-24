FieldController = FastRender.RouteController.extend
  waitOn: ->
    [
      Meteor.subscribe "fieldByToken", @params.token,
      Meteor.subscribe "fieldPosts", Session.get('current:field'),
      Meteor.subscribe "fieldImages", Session.get('current:field')
    ]

  data: ->
    if field = Fields.findOne(token: @params.token)
      Session.set('current:field', field._id)

      field:  field
      posts:  Posts.find fieldId: field._id
      images: Images.find fieldId: field._id

  unload: ->
    delete Session.keys['current:field']

Router.map ->
  @route 'field',
    path: '/f/:token'
    controller: FieldController

Template.field.events
  "keyup #posttext": (evt, tmpl) ->
    if evt.which is 13
      post = tmpl.find("#posttext")

      Meteor.call "addPost",
        text: posttext.value

      $(post).val("").select().focus()
