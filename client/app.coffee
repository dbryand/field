Template.app.rendered = ->
  $("html").on "dragover", (e, ui) ->
    e.stopPropagation()
    e.preventDefault()
    $("body").addClass('dragover')

  $("html").on "drop", (e, ui) ->
    e.stopPropagation()
    e.preventDefault()
    $("body").removeClass('dragover')
    files = e.originalEvent.dataTransfer.files
    handleFileSelect files
    return false

handleFileSelect = (files) ->
  setProgress 0, "Upload started."

  for file in files
    uploadFile file

setProgress = (percent, statusLabel) ->
  progress = document.querySelector(".percent")
  progress.style.width = percent + "%"
  progress.textContent = percent + "%"
  document.getElementById("status").innerText = statusLabel

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
  Meteor.call "addImage",
    url: url
    size: file.size
    name: file.name
    type: file.type
