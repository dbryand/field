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
      name:  options.name || "Untitled - #{(new Date()).getTime()}"
      token: makeToken()

    Fields.insert field

  removeField: (id) ->
    Fields.remove _id: id
