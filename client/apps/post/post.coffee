# Controller & Routes
# ----------------------------------------------------------------
PostController = FastRender.RouteController.extend
  waitOn: ->
    Meteor.subscribe "postByToken", @params.token

  onRun: ->
    if post = Posts.findOne(token: @params.token)
      Session.set 'current:post', post._id
      Session.set 'current:field', post.fieldId

  onStop: ->
    delete Session.keys['current:post']

Router.map ->
  @route 'post',
    path: '/p/:token'
    controller: PostController
    fastRender: true

Template.post.helpers
  post: ->
    Posts.findOne _id: Session.get('current:post')

Template.closePost.helpers
  field: ->
    Fields.findOne _id: Session.get('current:field')

Template.closePost.rendered = ->
  Deps.autorun ->
    Meteor.subscribe "fieldById", Session.get('current:field')

 # Close Post
 # ----------------------------------------------------------------
 Template.closePost.events
   "click .close": (evt, tmpl) ->
      Router.go 'field',
        token: @token

# Template.post.events
#   "mouseover .field-post": (e) ->
#     ele = $(e.currentTarget)
#     FieldPositioner.enableFieldDraggable ele
#     FieldPositioner.onFieldItemDragstop ele, (position) =>
#       Posts.update @_id,
#         $inc:
#           positionX: position[0]
#           positionY: position[1]
