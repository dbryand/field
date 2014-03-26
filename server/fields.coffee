Meteor.publish "fieldByToken", (token) ->
  check(token, String)

  Fields.find token: token

Meteor.publish "fieldsForUser", (userId) ->
  check(userId, String)

  Fields.find userId: userId

Meteor.methods
  'field:create': (options={}) ->
    field =
      userId: Meteor.userId()
      date:  new Date()
      name:  options.name || "Untitled - #{moment(new Date()).format("MMMM Do, h:mm:ss a")}"
      token: makeToken()

    id = Fields.insert field
    Fields.findOne _id: id

  'field:trash': (id) ->
    Fields.update id,
      $set:
        trashed_at: new Date()

  'field:restore': (id) ->
    Fields.update id,
      $set:
        trashed_at: null

  'field:delete': (id) ->
    Fields.remove _id: id
