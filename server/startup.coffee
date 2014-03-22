Meteor.startup ->
  @Future = Npm.require('fibers/future')
  @Fiber = Npm.require('fibers')

  if Meteor.settings.AWS
    AWS.config.update
      accessKeyId: Meteor.settings.AWS.accessKeyId
      secretAccessKey: Meteor.settings.AWS.secretAccessKey
  else
    console.warn "AWS settings missing"

  @s3 = new AWS.S3()
