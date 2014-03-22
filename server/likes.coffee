Meteor.publish "likes", (postid) ->
  Likes.find post: postid
