ready = ->
  spinner = $(".spinner")

  spinner.hide()

  $(document).ajaxStart ->
    spinner.show()

  $(document).ajaxStop ->
    spinner.hide()

$(document).ready(ready)
$(document).on('page:load', ready)
