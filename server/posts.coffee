Meteor.publish "fieldPosts", (fieldId) ->
  check(fieldId, String)

  Posts.find fieldId: fieldId

Meteor.methods
  addPost: (fieldId, options) ->
    post =
      userId:   Meteor.userId()
      fieldId:  fieldId
      text:     options.text
      date:     new Date()

    Posts.insert post

  removePost: (id) ->
    Posts.remove _id: id
