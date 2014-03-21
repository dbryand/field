# https://github.com/meteor/meteor/issues/1369
Accounts.onCreateUser (options, user) ->
  # We're enforcing at least an empty profile object to avoid needing to check
  # for its existence later.
  user.profile = (if options.profile then options.profile else {})
  user
