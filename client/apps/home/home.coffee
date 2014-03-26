HomeController = FastRender.RouteController.extend
  waitOn: ->
    Meteor.subscribe "fieldsForUser", Meteor.userId()

Router.map ->
  @route 'home',
    path: '/'
    controller: HomeController

Template.home.helpers
  fields: ->
    Fields.find {}

Template.home.events =
  "click .new-field": (e, tmpl) ->
    Meteor.call "field:create", (err, data) ->
      Router.go 'field',
        token: data.token
