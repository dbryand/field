# Follow this:
# http://stackoverflow.com/questions/19620929/direct-browser-upload-to-s3-with-meteor-jquery-and-the-aws-sdk
Meteor.methods
  requestUpload: (filename, mimeType) ->
    key = "meteor/" + new Date().getTime() + "_" + filename
    fut = new Future()
    fib = new Fiber ->
      params =
        Bucket:       Meteor.settings.AWS.bucket
        Key:          key
        ContentType:  mimeType
        Body:         ''
        "ACL":        'public-read'
      surl = s3.getSignedUrl 'putObject', params, (err, surl) ->
        if !err
          fut.return(encodeURIComponent surl)
        else
          fut.return()
    fib.run()
    fut.wait()

  uploadComplete: (file, url) ->
    Meteor.call "addImage",
      url: url
      size: file.size
      name: file.name
      type: file.type
