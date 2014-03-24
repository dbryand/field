Meteor.startup ->
  $("html").on "dragover", (e, ui) ->
    e.stopPropagation()
    e.preventDefault()
    if isFileDragEvent(e)
      $("body").addClass('dragover')

  $("html").on "paste drop", (e, ui) ->
    e.stopPropagation()
    e.preventDefault()
    files = getFilesFromEvent(e)
    $("body").removeClass('dragover')
    if files[0]
      handleFileSelect files
    return false

isFileDragEvent = (e) ->
  !!e.originalEvent.dataTransfer.items.length

getFilesFromEvent = (e) ->
  # Paste image
  paste = e.originalEvent.clipboardData
  if paste && item = paste.items[0]
    if item.kind == "file"
      item      = item.getAsFile()
      item.name = "paste"
      return files     = [item]
  files = e.originalEvent.dataTransfer.files

handleFileSelect = (files) ->
  setProgress 0, "Upload started."

  for file in files
    uploadFile file

progressElement = ->
  progress = $(".upload-progress")
  unless progress.length
    progress = $('<div class="upload-progress">Uploading...</div>').appendTo("body")
  progress

setProgress = (percent, statusLabel) ->
  p = progressElement()
  p.text(percent + "% " + statusLabel)

uploadFile = (file) ->
  executeOnSignedUrl file, (signedURL) ->
    uploadToS3 file, signedURL

executeOnSignedUrl = (file, callback) ->
  Meteor.call "requestUpload", file.name, file.type, (error, result) ->
    callback decodeURIComponent(result)

# Strip parameters out of PUT url
s3Location = (url) ->
  url.split("?")[0]

uploadToS3 = (file, url) ->
  xhr = createCORSRequest("PUT", url)
  unless xhr
    setProgress 0, "CORS not supported"
  else
    xhr.onload = (options...) ->
      if xhr.status is 200
        setProgress 100, "Upload completed."
        onUploadSuccess file, s3Location(url)
      else
        setProgress 0, "Upload error: " + xhr.status

    xhr.onerror = (e) ->
      setProgress 0, "XHR error."

    xhr.upload.onprogress = (e) ->
      if e.lengthComputable
        percentLoaded = Math.round((e.loaded / e.total) * 100)
        setProgress percentLoaded, (if percentLoaded is 100 then "Finalizing." else "Uploading.")

    xhr.send file

createCORSRequest = (method, url) ->
  xhr = new XMLHttpRequest()
  if "withCredentials" of xhr
    xhr.open method, url, true
  else unless typeof XDomainRequest is "undefined"
    xhr = new XDomainRequest()
    xhr.open method, url
  else
    xhr = null
  xhr

onUploadSuccess = (file, url) ->
  progressElement().remove()

  # TODO: This is too incestuous...
  Meteor.call "addImage", Session.get('current:field'),
    url: url
    size: file.size
    name: file.name
    type: file.type
