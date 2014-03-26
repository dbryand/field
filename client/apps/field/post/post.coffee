Template.post.events
  "mouseover .post, touchstart .post": (e) ->
    ele = $(e.currentTarget)
    unless ele.data("isDraggable")
      ele.data("isDraggable", true).draggable
        distance: 3
        containment: "parent"

Template.post.rendered = ->
  unless @_rendered
    @_rendered = true

    ele = $(@firstNode)

    #$(this.find('a[rel=tooltip]')).tooltip()

    random = Math.floor(Math.random() * 500)
    random2 = Math.floor(Math.random() * 840)
    ele.css("top", "#{random}px")
    ele.css("left", "#{random2}px")
