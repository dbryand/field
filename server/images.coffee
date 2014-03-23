Meteor.publish "images", (userId) ->
  Images.find
    owner: userId

Meteor.methods
  addImage: (options) ->
    image =
      owner: Meteor.userId()
      date:  new Date()
      url:   options.url
      size:  options.size
      name:  options.name
      type:  options.type

    Images.insert image

  removeImage: (id) ->
    Images.remove _id: id
