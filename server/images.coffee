#Meteor.publish "fieldImages", (fieldId) ->
  #check(fieldId, String)

  #Images.find
    #fieldId: fieldId

Meteor.methods
  addImage: (fieldId, options={}) ->
    image =
      userId: Meteor.userId()
      fieldId: Fields.findOne(fieldId)
      date:  new Date()
      url:   options.url
      size:  options.size
      name:  options.name
      type:  options.type

    Images.insert image

  removeImage: (id) ->
    Images.remove _id: id
