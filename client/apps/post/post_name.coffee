Template.postName.helpers
  isEditingName: ->
    Session.get('editing:post:name')

# Show
# ----------------------------------------------------------------
Template.showPostName.events
 "click .can-edit": (evt, tmpl) ->
    Session.set('editing:post:name', true)

# Edit
# ----------------------------------------------------------------
Template.editPostName.events
  "keyup .post-name-input": (evt, tmpl) ->
    if evt.which is 13
      name = tmpl.find(".post-name-input").value

      success = ->
        Session.set('editing:post:name', false)

      Meteor.call "post:update", Session.get('current:post'),
        name: name
      , success

  "blur .post-name-input": (evt, tmpl) ->
    Session.set('editing:post:name', false)

Template.editPostName.rendered = ->
  $(@firstNode).focus()

