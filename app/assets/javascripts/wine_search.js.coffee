ready = ->
  old_value = 0
  $('#wine-search-input').on 'click input', (event) ->
    term = $('#wine-search-input').val()
    url = $('#wine-search-form').data('path') + '.js'
    data = search: term
    current_value = term.length
    if validSearch(current_value, old_value)
      $.ajax
        type: "GET"
        url: url
        data: data
    old_value = current_value

validSearch = (current_value, old_value)->
  if current_value >= 2
   return true
  else if current_value == 0 and old_value >= 1
   return true
  else if current_value == 1 and old_value == 2
    return true
  else
   return false

$(document).ready(ready)
$(document).on('page:load', ready)
