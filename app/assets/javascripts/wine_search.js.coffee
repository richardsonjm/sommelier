ready = ->
  $('#wine-search-input').on 'click input', (event) ->
    term = $('#wine-search-input').val()
    url = $('#wine-search-form').data('path')
    data = search: term
    if term.length >= 2
      $.ajax
        type: "GET"
        url: url + '.js'
        data: data

$(document).ready(ready)
$(document).on('page:load', ready)
