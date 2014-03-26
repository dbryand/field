@Posts  = new Meteor.Collection('posts')
@Images = new Meteor.Collection('images')
@Fields = new Meteor.Collection('fields')
@Likes  = new Meteor.Collection('likes')

#Fields.deny
  #update: (fieldId, post, fieldNames) ->
    ##return false  if isAdminById(userId)
    
    ## deny the update if it contains something other than the following fields
    #_.without(fieldNames, "name").length > 0

Fields.allow
  insert: -> true,
  update: -> true,
  remove: -> true

Images.allow
  insert: -> true,
  update: -> true,
  remove: -> true

Posts.allow
  insert: -> true,
  update: -> true,
  remove: -> true
