Meteor.publish "posts", (userid) ->
  Posts.find {}

Meteor.methods
  #{text:'',owner:'',date:'',parent:''}
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
