jQuery(function() {
  $('#table').DataTable({
    "order": [],
    "bPaginate": false,
    "bInfo" : false,
    "bFilter": false,
    "columnDefs": [{
      "targets": 'no-sort',
      "orderable": false,
    }],
    "language": {
      "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Portuguese-Brasil.json"
    }
  });

  $('#table').removeClass("no-footer");
});
