Template.uploader.events "change #files": (e, tmpl) ->
  e.preventDefault()
  handleFileSelect e

handleFileSelect = (evt) ->
  setProgress 0, "Upload started."
  files = evt.target.files
  output = []
  i = 0
  f = undefined

  while f = files[i]
    uploadFile f
    i++

setProgress = (percent, statusLabel) ->
  progress = document.querySelector(".percent")
  progress.style.width = percent + "%"
  progress.textContent = percent + "%"
  document.getElementById("progress_bar").className = "loading"
  document.getElementById("status").innerText = statusLabel

uploadFile = (file) ->
  executeOnSignedUrl file, (signedURL) ->
    uploadToS3 file, signedURL

executeOnSignedUrl = (file, callback) ->
  Meteor.call "requestUpload", file.name, file.type, (error, result) ->
    callback decodeURIComponent(result)

uploadToS3 = (file, url) ->
  xhr = createCORSRequest("PUT", url)
  unless xhr
    setProgress 0, "CORS not supported"
  else
    xhr.onload = ->
      if xhr.status is 200
        setProgress 100, "Upload completed."
      else
        setProgress 0, "Upload error: " + xhr.status

    xhr.onerror = (e) ->
      setProgress 0, "XHR error."

    xhr.upload.onprogress = (e) ->
      if e.lengthComputable
        percentLoaded = Math.round((e.loaded / e.total) * 100)
        setProgress percentLoaded, (if percentLoaded is 100 then "Finalizing." else "Uploading.")

    xhr.setRequestHeader "Content-Type", file.type
    xhr.setRequestHeader "x-amz-acl", "public-read"
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
