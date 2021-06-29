jQuery(function() {
  $('#table').DataTable({
    "order": [[ 0, 'desc' ]],
    "columnDefs": [{
      "targets": 'no-sort',
      "orderable": false,
    }],
    "language": {
      "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Portuguese-Brasil.json"
    }
  });
});
