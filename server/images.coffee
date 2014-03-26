Meteor.publish "fieldImages", (fieldId) ->
  check(fieldId, String)

  Images.find fieldId: fieldId

Meteor.methods
  "image:create": (fieldId, options={}) ->
    image =
      userId:     Meteor.userId()
      fieldId:    fieldId
      date:       new Date()
      url:        options.url
      size:       options.size
      name:       options.name
      type:       options.type
      positionX:  0
      positionY:  0

    Images.insert image

  "image:delete": (id) ->
    Images.remove _id: id
