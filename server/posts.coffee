Meteor.publish "postByToken", (token) ->
  check(token, String)

  Posts.find token: token

Meteor.publish "fieldPosts", (fieldId) ->
  check(fieldId, String)

  Posts.find fieldId: fieldId

Meteor.methods
  "post:create": (fieldId, options) ->
    post =
      userId:    Meteor.userId()
      fieldId:   fieldId
      name:      options.name
      text:      options.text
      date:      new Date()
      token:     makeToken()
      positionX: 0
      positionY: 0

    Posts.insert post

  "post:delete": (id) ->
    Posts.remove _id: id
