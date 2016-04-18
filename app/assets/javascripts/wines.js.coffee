jQuery ->
  $('#wines').dataTable
    serverSide: true,
    ajax: $('#wines').data('source')

  $.fn.dataTable.ext.errMode = 'throw';
