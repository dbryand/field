Meteor.publish "likes", (postid) ->
  Likes.find post: postid

Meteor.methods
  likePost: (options) ->
    debugger
    #post =
      #text:    options.text
      #owner:   Meteor.userId()
      #date:    new Date()
      #parent:  options.parent

    #Posts.insert post
