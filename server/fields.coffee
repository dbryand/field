Meteor.publish "fields", (userId) ->
  Fields.find
    owner: userId

Meteor.methods
  addField: (options={}) ->
    # Move this at some point...
    chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz"
    token = ""

    while token.length < 8
      rnum = Math.floor(Math.random() * chars.length)
      token += chars.substring(rnum, rnum + 1)

    field =
      owner: Meteor.userId()
      date:  new Date()
      name:  options.name || "Untitled"
      token: token

    Fields.insert field

  removeField: (id) ->
    Fields.remove _id: id

