var table;
$(document).ready(function() {
    table = $('table.table').DataTable( {
	fixedHeader: true,
        "paging": false,
        dom: 'Bfrtip',
        buttons: [
            'copy', 'csv', 'excel', 'pdf',
	    {
                extend: 'print',
                customize: function ( win ) {
                    $(win.document.body)
                        .css( 'font-size', '9pt' );
 
                    $(win.document.body).find( 'table' )
                        .addClass( 'compact' )
                        .css( 'font-size', 'inherit' );
                },
	    }
        ]
    } );

} );
