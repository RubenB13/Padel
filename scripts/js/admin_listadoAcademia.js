//$(document).ready(function(){

// muestra todas las incidencas 

  // rowDetailsTable = $('#tblIncidencias').dataTable({
  //     destroy: true,
  //     retrieve: true,
  //     responsive: true,
  //     ajax: 'scripts/asp/admin_capturarAgenda.asp?com=listarAgenda',
  //     processing: true,
  //     type: 'POST',
  //       "oLanguage": {
  //   "sUrl": "../../libs/datatables/tableLanguaje.txt"
  //   },
  //   'fnServerParams': function ( aoData ) {
  //       aoData.push( { "name": 'de', "value": $("#date_from").val() } );
  //       aoData.push( { "name": 'a', "value": $("#date_to").val() } );
  //     },
  //     columns: [
  //       { data: "id"},
  //       { data: "fecha_renta"},
  //       { data: "nombre_cliente"},
  //       { data: "tipo_servicio"},
  //       { data: "telefono"},
  //       { data: "cancha_asignada"},
  //       { data: "hora_inicio"},
  //       { data: "hora_fin"},
  //       { data: "eliminar"}
  //       // { data: "tarea"}
  //     ],
  //      order:[[0,"desc"]],
  //   });

  buscarReservacionesPorFecha()
  var fechaInicial, fechaFin
  // var table

  function buscarReservacionesPorFecha(){
    fechaInicial = $("#date_from").val()
    fechaFin = $("#date_to").val()
    console.log(fechaInicial + "  -  " + fechaFin)

      $('#tblReservacionesAcademia').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/admin_capturarAgenda.asp?com=listarAcademia&de='+fechaInicial+'&a='+fechaFin,
      processing: true,
      type: 'POST',
        "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
    },
      columns: [
        // {
        //   className: 'dt-control-detalle',
        //   orderable: false,
        //   data: null,
        //   defaultContent: '',
        //   render: function(){
        //     return '<i class="fa fa-plus-square" aria-hidden="true></i>"'
        //   }
        // },
        { data: "verReservacionAcademia"},
        { data: "id"},
        { data: "estatus_academia"},
        { data: "fecha_inscripcion"},
        { data: "nombre_cliente"},
        { data: "telefono"},
        { data: "nivel_academia"},
        { data: "grupo_asignado"},
        { data: "fecha_renta"},
        { data: "ultima_fecha_pago"},
        { data: "tipo_pago_academia"},
        { data: "precio_renta"}
      ],
       order:[[3,"desc"]],
    });
  }


  // function format(d) {
  //     // `d` is the original data object for the row
  //     return (
  //         '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">' +
  //         '<tr>' +
  //         '<td>Full name:</td>' +
  //         '<td>' +
  //          'nombre'+
  //         '</td>' +
  //         '</tr>' +
  //         '<tr>' +
  //         '<td>Extension number:</td>' +
  //         '<td>' +
  //         'extencion' +
  //         '</td>' +
  //         '</tr>' +
  //         '<tr>' +
  //         '<td>Extra info:</td>' +
  //         '<td>And any further details here (images etc)...</td>' +
  //         '</tr>' +
  //         '</table>'
  //     );
  // }


  // // Add event listener for opening and closing details
  //   $('#tblIncidencias tbody').on('click', 'td.dt-control-detalle', function () {
  //       var tr = $(this).closest('tr');
  //       var row = table.row(tr);
 
  //       if (row.child.isShown()) {
  //           // This row is already open - close it
  //           row.child.hide();
  //           tr.removeClass('shown');
  //       } else {
  //           // Open this row
  //           row.child(format(row.data())).show();
  //           tr.addClass('shown');
  //       }
  //   });

  // function generarReporte(){
  //   fechaSol = $("#txtfecha").val()

  //       $('#datatableHabitaciones').dataTable({
  //          destroy: true,
  //          // retrieve: true,
  //         ajax: 'scripts/asp/admin_consultaHabitacionesMoteles.asp?comm=reporteHabitaciones&fechaReporte='+fechaSol+'&usuarioRecepcion='+idUsuarioRecepcion,
  //         processing: true,
  //         type: 'POST',
  //           "oLanguage": {
  //       "sUrl": "../../libs/datatables/tableLanguaje.txt"
  //       },
  //         columns: [
  //           { data: "placa"},
  //           { data: "habitacion"},
  //           { data: "fechaEntrada"},
  //           { data: "horaEntrada"},
  //           { data: "horaSalida"}
  //         ]
  //       });

  // }

 

  

//}) cierro document

  
  $(".buscarAcademia").click(function(){
    console.log("entro buscar por fecha")
    $('#tblReservacionesAcademia').DataTable().destroy();
    // $('#tblIncidencias').DataTable().draw();
    buscarReservacionesPorFecha()
    // if ( $("#date_from").val() != "" && $("#date_to").val() != "") {
    //   rowDetailsTable.api().ajax.reload();  
    // }else{
    //   $('#tblIncidencias').DataTable().ajax.reload();
    // }
    
  })


  function cambiarEstatusAcademia(IdReg, estatus){
    if (estatus == 1) {
      if(confirm("¿Desea cambiar el estatus a PENDIENTE de este registro?")){
        cambiaEstatusAcademia(IdReg, 2)
      }
    }else if (estatus == 2) {
      if(confirm("¿Desea cambiar el estatus a ACTIVO de este registro?")){
        cambiaEstatusAcademia(IdReg, 1)
      }
    }
  }

  function cambiaEstatusAcademia(IdReg, estatus){
    $.ajax({
           url:"scripts/asp/admin_capturarAgenda.asp",
           method: "POST",
           cache: false,
           data: {idReg:IdReg,comm:'cambiarEstatusAcademia', optEstatus:estatus},
           dataType: "json"
       }).done(function(rest){
          $.each(rest.data, function (i, item) {
            if(item.ok == 'ok'){
              // alert("Se elimino correctamente...")
              $('#tblReservacionesAcademia').DataTable().ajax.reload();                    
            }else{
              alert("Error al cambiar el estatus, consulte al administrador del sistema")
            } 
          })
           

       })
  }

  // function eliminarAgenda(IdReg){
  //   if(confirm("¿Seguro desea borrar esta reservación?")){
  //      $.ajax({
  //          url:"scripts/asp/admin_capturarAgenda.asp",
  //          method: "POST",
  //          cache: false,
  //          data: {idReg:IdReg,comm:'eliminarAgenda'},
  //          dataType: "json"
  //      }).done(function(rest){
  //         $.each(rest.data, function (i, item) {
  //           if(item.ok == 'ok'){
  //             alert("Se elimino correctamente...")
  //             $('#tblIncidencias').DataTable().ajax.reload();                    
  //           }else{
  //             alert("No se borro el registro, consulte al administrador del sistema")
  //           } 
  //         })
           

  //      })
  //   }
  // }













//abrir y cerrar incidencias

  // function cerrarIncidencia(ide){
  //   $.ajax({
  //       url: 'scripts/asp/erpsichertech/admin_capturarIncidenciaNotificacionERP.asp',
  //       data: {comm:"cerrarIncidencia", idReg:ide},
  //       cache: false,
  //       method: 'POST',
  //       dataType:'json'
  //   }).done(function(rest){
        
  //       $.each(rest.data, function(i, item){
  //         if (item.ok == 'ok') {
  //           alert("Incidencia cerrada correctamente...")
  //           $('#tblIncidencias').DataTable().ajax.reload();
  //         }         
  //       })  

  //   }).fail(function(){
  //       alert("Error interno, contacte al administrador")
  //   });  
  // }

  // function abrirIncidencia(ide){
  //   $.ajax({
  //       url: 'scripts/asp/erpsichertech/admin_capturarIncidenciaNotificacionERP.asp',
  //       data: {comm:"abrirIncidencia", idReg:ide},
  //       cache: false,
  //       method: 'POST',
  //       dataType:'json'
  //   }).done(function(rest){
        
  //       $.each(rest.data, function(i, item){
  //         if (item.ok == 'ok') {
  //           alert("Incidencia abierta correctamente...")
  //           $('#tblIncidencias').DataTable().ajax.reload();
  //         }         
  //       })  

  //   }).fail(function(){
  //       alert("Error interno, contacte al administrador")
  //   });  
  // }