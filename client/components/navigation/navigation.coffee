Template.navigation.rendered = ->
  Deps.autorun ->
    Meteor.subscribe "fieldsForUser", Meteor.userId()

Template.navigation.fields = ->
  Fields.find {}

