Template.fieldName.helpers
  isEditingName: ->
    Session.get('editing:field:name')

# Show
# ----------------------------------------------------------------
Template.showFieldName.events
 "click .can-edit": (evt, tmpl) ->
    Session.set('editing:field:name', true)

# Edit
# ----------------------------------------------------------------
Template.editFieldName.events
  "keyup .field-name-field": (evt, tmpl) ->
    if evt.which is 13
      name = tmpl.find(".field-name-field").value

      success = ->
        Session.set('editing:field:name', false)

      Meteor.call "field:update", Session.get('current:field'),
        name: name
      , success

  "blur .field-name-field": (evt, tmpl) ->
    Session.set('editing:field:name', false)

Template.editFieldName.rendered = ->
  $(@firstNode).focus()

