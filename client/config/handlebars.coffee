Handlebars.registerHelper "list", (context, options) ->
  debugger
  ret = "<ul>"
  i = 0
  j = context.length

  while i < j
    ret = ret + "<li>" + options.fn(context[i]) + "</li>"
    i++
  ret + "</ul>"
