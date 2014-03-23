Template.field.rendered = ->
  Deps.autorun ->
    Meteor.subscribe "posts", Meteor.userId()
    Meteor.subscribe "images", Meteor.userId()
    Meteor.subscribe "likes"

Template.field.posts = ->
  Posts.find parent: null, { sort: { date: -1 } }

Template.field.images = ->
  Images.find {}, { sort: { date: -1 } }

Template.field.events
  "keyup #posttext": (evt, tmpl) ->
    if evt.which is 13
      post = tmpl.find("#posttext")

      Meteor.call "addPost",
        text: posttext.value
        parent: null

      $(post).val("").select().focus()
