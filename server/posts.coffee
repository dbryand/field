Meteor.publish "posts", (userid) ->
  Posts.find {}

Meteor.methods
  addPost: (options) ->
    post =
      text:    options.text
      owner:   Meteor.userId()
      date:    new Date()
      parent:  options.parent

    Posts.insert post

  removePost: (id) ->
    Posts.remove _id: id

  removeAllPosts: ->
    Posts.remove {}

  likePost: (options) ->
    console.log "liked"
