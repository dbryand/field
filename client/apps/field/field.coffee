# Controller & Routes
# ----------------------------------------------------------------
FieldController = FastRender.RouteController.extend
  waitOn: ->
    Meteor.subscribe "fieldByToken", @params.token

  onRun: ->
    if field = Fields.findOne(token: @params.token)
      Session.set('current:field', field._id)

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

Template.field.rendered = ->
  $(@find("#field")).fadeIn()

# Close Field
# ----------------------------------------------------------------
Template.closeField.events
  "click .page-close": (evt, tmpl) ->
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
