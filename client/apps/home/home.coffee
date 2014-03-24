HomeController = FastRender.RouteController.extend
  waitOn: ->
    Meteor.subscribe "fieldsForUser", Meteor.userId()

Router.map ->
  @route 'home',
    path: '/'
    controller: HomeController
    
Template.home.fields = ->
  Fields.find {}
