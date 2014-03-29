Template.postBody.helpers
  isEditingBody: ->
    Session.get('editing:post:body')

# Show
# ----------------------------------------------------------------
Template.showPostBody.helpers
  bodyFormatted: ->
    if @body
      converter = new Markdown.Converter()
      html_body = converter.makeHtml(@body)
      html_body.autoLink()

Template.showPostBody.events
 "click .can-edit, click .write-post-body": (evt, tmpl) ->
    Session.set('editing:post:body', true)

# Edit
# ----------------------------------------------------------------
Template.editPostBody.events
  "click .post-body-save": (evt, tmpl) ->
    body = tmpl.find(".post-body-input").value
    body = cleanUp body

    success = ->
      Session.set('editing:post:body', false)

    Meteor.call "post:update", Session.get('current:post'),
      body: body
    , success

Template.editPostBody.rendered = ->
  $(@firstNode).select()
