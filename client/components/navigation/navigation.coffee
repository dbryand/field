Template.navigation.rendered = ->
  Deps.autorun ->
    Meteor.subscribe "fieldsForUser", Meteor.userId()

Template.navigation.fields = ->
  Fields.find {}

Template.navigation.events =
  "click .new-field": (e, tmpl) ->
    comment = tmpl.find(".comment")

    Meteor.call "addField", (err, data) ->
      Router.go 'field',
        token: data.token
