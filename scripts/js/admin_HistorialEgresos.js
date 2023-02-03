$(document).ready(function(){

// muestra todas las incidencas

  $('#tblEgresosEliminados').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/admin_guardaEgreso.asp?com=listarEgresosEliminados',
      processing: true,
      type: 'POST',
        "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
    },
      columns: [
        { data: "id"},
        { data: "fecha_baja"},
        { data: "fecha_realizo"},
        { data: "concepto"},
        { data: "descripcion"},
        { data: "tipo_egreso"},
        { data: "frecuencia_egreso"},
        { data: "justificacion"},
        { data: "responsable"},
        { data: "costo_unitario"},
        { data: "cantidad_total"},
        { data: "egreso_total"}

        // { data: "tarea"}
      ],
       order:[[0,"desc"]],
    });
})
