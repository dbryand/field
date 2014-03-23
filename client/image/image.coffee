Template.image.rendered = ->
  image = $(this.find(".image"))

  random = Math.floor(Math.random() * 500)
  random2 = Math.floor(Math.random() * 840)
  image.css("top", "#{random}px")
  image.css("left", "#{random2}px")

Template.image.likeCount = ->
  Likes.find(@_id).count()

Template.image.imageComments = ->
  images.find parent: @_id

Template.image.events =
  "keyup .comment": (evt, tmpl) ->
    if evt.which is 13
      comment = tmpl.find(".comment")

      Meteor.call "addimage",
        text: comment.value
        parent: @_id
      $(comment).val("").select().focus()

  "click .likebtn": (evt, tmpl) ->
    Meteor.call "likeimage",
      image: @_id
