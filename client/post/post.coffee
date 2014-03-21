#Template.post.doYouLike = ->
  #Likes.find(@_id).count()

Template.post.likeCount = ->
  Likes.find(@_id).count()

Template.post.postComments = ->
  Posts.find parent: @_id

Template.post.events "keyup .comment": (evt, tmpl) ->
  if evt.which is 13
    commenttext = tmpl.find(".comment").value

    Meteor.call "addPost",
      text: commenttext
      parent: @_id
    $(".comment").val("").select().focus()

Template.post.events "click .likebtn": (evt, tmpl) ->
  debugger
  Meteor.call "addPost",
    text: commenttext
    parent: @_id
  $(".comment").val("").select().focus()
