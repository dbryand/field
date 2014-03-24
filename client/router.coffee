Router.map ->
  @route 'splash',
    path: '/',
    template: 'splash'

  @route 'fieldShow',
    path: '/f/:token'

  @route 'home',
    path: '/home'

  @route 'messages',
    path: '/messages'

  @route 'events',
    path: '/events'
