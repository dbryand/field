Template.post.rendered = ->

  $(this.find('a[rel=tooltip]')).tooltip()

  post = $(this.find(".post"))

  random = Math.floor(Math.random() * 500)
  random2 = Math.floor(Math.random() * 840)
  post.css("top", "#{random}px")
  post.css("left", "#{random2}px")

Template.post.likeCount = ->
  Likes.find(@_id).count()

Template.post.postComments = ->
  Posts.find parent: @_id

Template.post.events =
  "keyup .comment": (evt, tmpl) ->
    if evt.which is 13
      comment = tmpl.find(".comment")

      Meteor.call "addPost",
        text: comment.value
        parent: @_id
      $(comment).val("").select().focus()

  "click .likebtn": (evt, tmpl) ->
    Meteor.call "likePost",
      post: @_id
