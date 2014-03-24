Meteor.publish "fieldByToken", (token) ->
  check(token, String)

  Fields.find token: token

Meteor.publish "fieldsForUser", (userId) ->
  check(userId, String)

  Fields.find userId: userId

Meteor.methods
  addField: (options={}) ->
    field =
      userId: Meteor.userId()
      date:  new Date()
      name:  options.name || "Untitled - #{moment(new Date()).format("MMMM Do, h:mm:ss a")}"
      token: makeToken()

    id = Fields.insert field
    Fields.findOne _id: id

  removeField: (id) ->
    Fields.remove _id: id
