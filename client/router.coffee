Router.map ->
  @route 'splash',
    path: '/',
    template: 'splash',
    data: ->
      Meteor.user()

  @route 'home',
    path: '/home',
    data: ->
      Meteor.user()

  @route 'messages',
    path: '/messages'

  @route 'events',
    path: '/events'
