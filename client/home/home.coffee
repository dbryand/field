Template.home.rendered = ->
  Deps.autorun ->
    Meteor.subscribe "posts", Meteor.userId()
    Meteor.subscribe "likes"
    Meteor.subscribe "appusers"

Template.home.posts = ->
  Posts.find({parent:null},{sort:{date:-1}})

Template.home.events "keyup .posttext": (evt, tmpl) ->
  if evt.which is 13
    posttext = tmpl.find(".posttext").value
    options =
      text: posttext
      parent: null

    Meteor.call "addPost", options
    $(".posttext").val("").select().focus()
