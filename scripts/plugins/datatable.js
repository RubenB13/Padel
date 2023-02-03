(function ($) {
	"use strict";

  
  var init = function(){
    $('#datatable').dataTable({
      ajax: 'asp/usuarios.asp', //'api/datatable.json',
      processing: true,
      // "scrollY":  "200px",
      // "scrollCollapse": true,
      columns: [
          // { data: "id" },
          // { data: "name"},
          // { data: "hr.position" },
          // { data: "contact.0" },
          // { data: "contact.1" },
          // { data: "hr.start_date" },
          // { data: "hr.QR" }
          { data: "id" },
          { data: "Nombre"},
          { data: "AP" },
          { data: "AM" },
          { data: "Email" },
          { data: "CrearQR", "orderable": false }
      ]
    });
  };

  // for ajax to init again
  $.fn.dataTable.init = init;

})(jQuery);
