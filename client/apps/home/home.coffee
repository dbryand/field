HomeController = FastRender.RouteController.extend
  waitOn: ->
    Meteor.subscribe "fieldsForUser", Meteor.userId()

Router.map ->
  @route 'home',
    path: '/'
    controller: HomeController

Template.home.helpers
  fields: ->
    Fields.find {trashed_at: null}

Template.home.events =
  "click .new-field": (e, tmpl) ->
    Meteor.call "field:create", (err, data) ->
      Router.go 'field',
        token: data.token

# New Field Nav Template
# -----------------------------------------
Template.newFieldNav.events =
  "click .field": (e, tmpl) ->
    Meteor.call "field:create", (err, data) ->
      Router.go 'field',
        token: data.token

# Field Nav Template
# -----------------------------------------
Template.fieldNav.events =
  "click .field": (e, tmpl) ->
    Router.go 'field',
      token: @token
