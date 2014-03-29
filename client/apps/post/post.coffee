# Controller & Routes
# ----------------------------------------------------------------
PostController = FastRender.RouteController.extend
  waitOn: ->
    Meteor.subscribe "postByToken", @params.token

  onRun: ->
    if post = Posts.findOne(token: @params.token)
      Session.set 'current:post', post._id
      Meteor.call "field:token", post.fieldId, (err, data) ->
        Session.set 'current:field:token', data

  onStop: ->
    delete Session.keys['current:post']

Router.map ->
  @route 'post',
    path: '/p/:token'
    controller: PostController
    fastRender: true

# Post
# ----------------------------------------------------------------
Template.post.helpers
  post: ->
    Posts.findOne _id: Session.get('current:post')

  isEditingName: ->
    Session.get('editing:post:name')

Template.post.events
 "click .post-name": (evt, tmpl) ->
    Session.set('editing:post:name', true)

Template.post.rendered = ->
  Mousetrap.bind 'esc', ->
    Router.go 'field',
      token: Session.get 'current:field:token'

# Edit Post Name
# ----------------------------------------------------------------
Template.editPostName.events
  "keyup #post-name-field": (evt, tmpl) ->
    if evt.which is 13
      field = tmpl.find("#post-name-field")

      success = ->
        Session.set('editing:post:name', false)

      Meteor.call "post:update", Session.get('current:post'),
        name: field.value
      , success

      $(post).val("").select().focus()

  "blur #post-name-field": (evt, tmpl) ->
    Session.set('editing:post:name', false)

Template.editPostName.rendered = ->
  $(@firstNode).focus()

# Close Post
# ----------------------------------------------------------------
Template.closePost.helpers
  field: ->
    Fields.findOne _id: Session.get('current:field')

Template.closePost.rendered = ->
  Deps.autorun ->
    Meteor.subscribe "fieldById", Session.get('current:field')

 Template.closePost.events
   "click .page-close": (evt, tmpl) ->
      Router.go 'field',
        token: Session.get 'current:field:token'
