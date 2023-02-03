$(document).ready(function(){

// muestra todas las incidencas

  $('#tblIngresosEliminados').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/admin_guardaIngreso.asp?com=listarIngresosEliminados',
      processing: true,
      type: 'POST',
        "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
    },
      columns: [
        { data: "id"},
        { data: "fecha_realizo"},
        { data: "concepto"},
        { data: "descripcion"},
        { data: "tipo_venta"},
        { data: "cliente"},
        { data: "responsable"},
        { data: "costo_unitario"},
        { data: "cantidad_total"},
        { data: "ingreso_total"}
        // { data: "tarea"}
      ],
       order:[[0,"desc"]],
    });
})
