# Controller & Routes
# ----------------------------------------------------------------
PostController = FastRender.RouteController.extend
  waitOn: ->
    Meteor.subscribe "postByToken", @params.token

  onRun: ->
    if field = Posts.findOne(token: @params.token)
      Session.set('current:post', field._id)

  onStop: ->
    delete Session.keys['current:post']

Router.map ->
  @route 'post',
    path: '/p/:token'
    controller: PostController
    fastRender: true

# Template.post.rendered = ->

# Template.post.events
#   "mouseover .field-post": (e) ->
#     ele = $(e.currentTarget)
#     FieldPositioner.enableFieldDraggable ele
#     FieldPositioner.onFieldItemDragstop ele, (position) =>
#       Posts.update @_id,
#         $inc:
#           positionX: position[0]
#           positionY: position[1]
