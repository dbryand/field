Meteor.publish "fieldByToken", (token) ->
  check(token, String)

  Fields.find token: token

Meteor.publish "fieldById", (id) ->
  check(id, String)

  Fields.find _id: id

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

  "field:update": (fieldId, update, success, error) ->
    update = _.pick update, "name"
    Fields.update _id: fieldId,
      $set:
        update

  'field:trash': (id) ->
    Fields.update id,
      $set:
        trashed_at: new Date()

  'field:restore': (id) ->
    Fields.update id,
      $set:
        trashed_at: null

  'field:token': (id) ->
    Fields.findOne(_id: id).token

  'field:delete': (id) ->
    Fields.remove _id: id
