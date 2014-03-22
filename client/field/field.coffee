Template.field.rendered = ->
  Deps.autorun ->
    Meteor.subscribe "posts", Meteor.userId()
    Meteor.subscribe "likes"

Template.field.posts = ->
  Posts.find parent: null, { sort: { date: -1 } }

Template.field.events
  "keyup #posttext": (evt, tmpl) ->
    if evt.which is 13
      post = tmpl.find("#posttext")

      Meteor.call "addPost",
        text: posttext.value
        parent: null

      $(post).val("").select().focus()

  #"submit form": (e, t) ->
    #e.preventDefault()
    #fileInput = t.find("input[type=file]")
    #i = 0

    #while i < fileInput.files.length
      #file = fileInput.files[i]
      #Meteor.call "requestUpload", file.name, (err, surl) ->
        #unless err
          #console.log "signed url: " + surl
          #reader = new FileReader()
          #reader.onload = (event) ->
            ## Here I am trying to upload, it fails
            #$.ajax surl,
              #data: reader.result
              #type: "PUT"
              #success: (data, status) ->
                #console.log "status: " + status
                #console.log "data: " + data
          #reader.readAsDataURL file
        #else
          #console.log err
        #return

      #i++
