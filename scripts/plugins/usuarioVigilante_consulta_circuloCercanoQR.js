(function ($) {
	"use strict";

  
  // var init = function(){
    $('#datatable').dataTable({
      ajax: 'asp/usuarioDueno_consulta_circuloCercanoQR.asp', //'api/datatable.json',
      processing: true,
      "scrollY":  "200px",
      "scrollCollapse": true,
      columns: [
          
          { data: "id" },
          { data: "nombre"},
          { data: "domicilio" },
          { data: "circulo" },
          { data: "entrada" },
          { data: "QR", "orderable": false }
      ]
    });
  // };

  // for ajax to init again
  // $.fn.dataTable.init = init;

});//(jQuery);
