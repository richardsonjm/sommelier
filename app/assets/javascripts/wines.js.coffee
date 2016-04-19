ready = ->
  $('#wines').dataTable
    serverSide: true,
    ajax: $('#wines').data('source')

  $.fn.dataTable.ext.errMode = 'throw';

$(document).ready(ready)
$(document).on('page:load', ready)
