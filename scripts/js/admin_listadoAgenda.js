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
  function buscarReservacionesPorFecha(){
    fechaInicial = $("#date_from").val()
    fechaFin = $("#date_to").val()
    console.log(fechaInicial + "  -  " + fechaFin)

      $('#tblIncidencias').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/admin_capturarAgenda.asp?com=listarAgenda&de='+fechaInicial+'&a='+fechaFin,
      processing: true,
      pageLenght:5,
      lengthMenu: [[5, 10, 20, -1], [5, 10, 20, 'Todos']],
      type: 'POST',
        "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
    },
      columns: [
        { data: "id", visible: false},
        { data: "fecha_renta"},
        { data: "nombre_cliente"},
        { data: "pagado"},
        { data: "tipo_servicio"},
        { data: "precio_renta"},
        { data: "profesor"},
        { data: "cancha_asignada"},
        { data: "hora_inicio"},
        { data: "hora_fin"},
        {data:"numero_personas"},
        { data: "eliminar"}
        // { data: "clase"}
      ],
       order:[[1,"desc"]],
    });
  }

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

  
  $(".buscar").click(function(){
    console.log("entro buscar por fecha")
    $('#tblIncidencias').DataTable().destroy();
    // $('#tblIncidencias').DataTable().draw();
    buscarReservacionesPorFecha()
    // if ( $("#date_from").val() != "" && $("#date_to").val() != "") {
    //   rowDetailsTable.api().ajax.reload();  
    // }else{
    //   $('#tblIncidencias').DataTable().ajax.reload();
    // }
    
  })


  var idRegistroEliminar

  function eliminarAgenda(IdReg){
    // if(confirm("¿Seguro desea borrar esta reservación?")){
      $("#txtClave").val("")
      $('#modalEliminarRegistro').modal({backdrop: 'static',keyboard: false})
      $("#modalEliminarRegistro").modal("show")
      idRegistroEliminar = IdReg
    // }
  }

  var Clave

  //BUSCAMOS PRIMERO SI EXISTE EL USUARIO CON ESA CLAVE PARA ELIMINAR
  $("#btnEliminarRegistro").click(function(e){
      e.preventDefault()
      e.stopImmediatePropagation()

      Clave = $("#txtClave").val()
      if (Clave != "") {
        $.ajax({
           url:"scripts/asp/admin_capturarAgenda.asp",
           method: "POST",
           cache: false,
           data: {idReg:Clave,comm:'buscaUsuarioParaEliminarRegistro'},
           dataType: "json"
        }).done(function(rest){
          $.each(rest.data, function (i, item) {
            if(item.ok == 'ok'){
              borrarRegistro()
              $("#txtClave").val("")
            }else{
              alert("Clave incorrecta")
              $("#modalEliminarRegistro").modal("hide")            
              $("#txtClave").val("")
            } 
          })
        })     
      }else{
        alert("Debe agregar una clave...")
      }
      
  })


  function borrarRegistro(){

      $.ajax({
         url:"scripts/asp/admin_capturarAgenda.asp",
         method: "POST",
         cache: false,
         data: {idReg:idRegistroEliminar,comm:'eliminarAgenda'},
         dataType: "json"
      }).done(function(rest){
        console.log(rest)
        $.each(rest.data, function (i, item) {
          if(item.ok == 'ok'){
            alert("Se elimino correctamente...")
            $('#tblIncidencias').DataTable().ajax.reload();
            $("#modalEliminarRegistro").modal("hide")                   
            
          }else{
            alert("No se borro el registro, consulte al administrador del sistema")
            $("#loading").hide();
            $("#modalEliminarRegistro").modal("hide")
          } 
        })
      })

  }

  function limpiaCamposPago(){
    $("#txtPrecioRenta").text("")
    $("#txtPrecioRentaConDescuento").text("")
    $("#lblNombreCliente").text("")
    $("#lblTelefono").text("")
    $("#lblObservacion").text("")
    $("#txtDescuento").val("")
    $("#txtPlayTomic").val("")
  }

  var idRegPago

  function verPago(idReg, estatus_pagado){
    
        limpiaCamposPago()
        idRegPago = idReg

        $.ajax({
           url:"scripts/asp/admin_capturarAgenda.asp",
           method: "POST",
           cache: false,
           data: {idReg:idReg,comm:'obtienePrecioRenta'},
           dataType: "json"
        }).done(function(rest){
          $.each(rest.data, function (i, item) {
            if(item.ok == 'ok'){
              descuento = item.descuento < 0 || item.descuento == ""  ? 0 : item.descuento
              $("#txtPrecioRenta").text(number_format(parseFloat(item.precio_renta)+parseFloat(descuento),2))
                
              $("#txtPrecioRentaConDescuento").text(number_format(item.precio_renta,2))
              $("#lblNombreCliente").text(item.nombre_cliente)
              $("#lblTelefono").text(item.telefono)
              $("#lblObservacion").text(item.observaciones)

              $("#txtDescuento").val(item.descuento)
              $("#txtPlayTomic").val(item.playtomic)
              $("#txtTransferencia").val(item.transferencia)
              $("#txtTarjeta").val(item.tarjeta)
              $("#txtDeposito").val(item.deposito)
              $("#txtEfectivo").val(item.efectivo)


              if (estatus_pagado == 0) { //NO ESTA PAGADO
                //ACTIVAMOS LOS CAMPOS PARA AGREGAR EL PAGO
                $("#txtDescuento").removeAttr("disabled", "disabled")
                $("#txtPlayTomic").removeAttr("disabled", "disabled")
                $("#btnRealizarPago").removeAttr("disabled", "disabled")
                $("#txtTransferencia").removeAttr("disabled", "disabled")
                $("#txtTarjeta").removeAttr("disabled", "disabled")
                $("#txtDeposito").removeAttr("disabled", "disabled")
                $("#txtEfectivo").removeAttr("disabled", "disabled")

                $("#spanPAGADO").hide()

              }else if (estatus_pagado == 1) { //1: YA ESTA PAGADO
                //ponemos los campos en solo lectura para que visualice el pago realizado
                
                $("#txtDescuento").attr("disabled", "disabled")
                $("#txtPlayTomic").attr("disabled", "disabled")
                $("#txtTransferencia").attr("disabled", "disabled")
                $("#txtTarjeta").attr("disabled", "disabled")
                $("#txtDeposito").attr("disabled", "disabled")
                $("#txtEfectivo").attr("disabled", "disabled")

                $("#btnRealizarPago").attr("disabled", "disabled")
                $("#spanPAGADO").show()

              } 

            }else{
              alert("Registro no encontrado, consulte al administrador del sistema")
            } 
          })
           
          $('#modalPago').modal({backdrop: 'static',keyboard: false})
          $("#modalPago").modal("show")
        })

        
    
  }


  // var datoAnterior, precioConDescuento, precioAnterior, p1, descuento

  // $("#txtDescuento").on('input', function(){
  //   if ( $(this).val() != datoAnterior) {
  //     datoAnterior = $(this).val()
  //     calculaPrecio_conDescuento() 
  //   }
  //   calcula_preciofinal()  
  // })

  // function calculaPrecio_conDescuento(){
  //   precioAnterior = $("#txtPrecioRenta").text()
    
  //   if ( $("#txtPlayTomic").val() != "") {
  //     precioAnterior = number_format(parseFloat(precioAnterior) - parseFloat($("#txtPlayTomic").val()),2)
  //     console.log(precioAnterior)
  //   }

  //   descuento = $("#txtDescuento").val()
  //   p1 = precioAnterior.split(",")
  //   p1 = p1.join("")
  //   // console.log(precioAnterior)
  //   // console.log(descuento)

  //   if (descuento=="" && $("#txtPlayTomic").val() =="" ) {
  //     $("#txtPrecioRentaConDescuento").text($("#txtPrecioRenta").text())
  //   }else{
  //     precioConDescuento = dividir(parseFloat(multiplicar(p1)) - parseFloat(multiplicar(descuento)))
  //     $("#txtPrecioRentaConDescuento").text(number_format(precioConDescuento,2))
  //   }    
  // }

  // function multiplicar(a){
  //   return a*1000;
  // }

  // function dividir(a){
  //   return a/1000;
  // }


  var precioOriginal, precioOriginal_1, descuento, playtomic, transferencia, clip, deposito, efectivo

  $("#txtDescuento, #txtPlayTomic, #txtTransferencia, #txtTarjeta, #txtDeposito, #txtEfectivo").on('input', function(){
    calcula_preciofinal()  
  })
  
  function calcula_preciofinal(){
    precioOriginal = $("#txtPrecioRenta").text()
    precioOriginal_1 = precioOriginal.split(",")
    precioOriginal_1 = precioOriginal_1.join("")

    descuento = $("#txtDescuento").val() == "" ? 0 : $("#txtDescuento").val()
    playtomic = $("#txtPlayTomic").val() == "" ? 0 : $("#txtPlayTomic").val()
    transferencia = $("#txtTransferencia").val() == "" ? 0 : $("#txtTransferencia").val()
    clip = $("#txtTarjeta").val() == "" ? 0 : $("#txtTarjeta").val()
    deposito = $("#txtDeposito").val() == "" ? 0 : $("#txtDeposito").val()
    efectivo = $("#txtEfectivo").val() == "" ? 0 : $("#txtEfectivo").val()



    preciofinal = parseFloat(precioOriginal_1) - (parseFloat(descuento) + parseFloat(transferencia) + parseFloat(playtomic) + parseFloat(clip) + parseFloat(deposito) + parseFloat(efectivo))

    $("#txtPrecioRentaConDescuento").text(number_format(preciofinal,2)) 
  }



  var total_servicio

  $("#btnRealizarPago").click(function (e) {
    e.preventDefault()
    e.stopImmediatePropagation()

    if ( parseFloat($("#txtPrecioRentaConDescuento").text()) > 0 ) {
      alert("El Total debe estar en 0.00")
    }else{

      descuento = $("#txtDescuento").val() == "" ? 0 : $("#txtDescuento").val()
      precioOriginal = $("#txtPrecioRenta").text() == "" ? 0 : $("#txtPrecioRenta").text()

      total_servicio = parseFloat(precioOriginal) - parseFloat(descuento)

      $.ajax({
         url:"scripts/asp/admin_capturarAgenda.asp",
         method: "POST",
         cache: false,
         data: { idReg:idRegPago,
                 comm:'realizarPago',
                 txtPrecioFinalTipoServicio: total_servicio, //$("#txtPrecioRentaConDescuento").text()
                 txtDescuento:$("#txtDescuento").val(),
                 txtPlayTomic:$("#txtPlayTomic").val(),
                 txtTransferencia: $("#txtTransferencia").val(), 
                 txtTarjeta: $("#txtTarjeta").val(),
                 txtDeposito: $("#txtDeposito").val(),
                 txtEfectivo: $("#txtEfectivo").val()
               },
         dataType: "json"
      }).done(function(rest){
        $.each(rest.data, function (i, item) {
          if(item.ok == 'ok'){
            alert("Pago realizado")
            $("#modalPago").modal("hide")
            $('#tblIncidencias').DataTable().ajax.reload();
          }else{
            alert("Pago no realizado, consulte al administrador del sistema")
            $("#modalPago").modal("hide")
          } 
        })
      })
    } 
  })


  function number_format(amount, decimals) {

    amount += ''; // por si pasan un numero en vez de un string
    amount = parseFloat(amount.replace(/[^0-9\.-]/g, '')); // elimino cualquier cosa que no sea numero o punto

    decimals = decimals || 0; // por si la variable no fue fue pasada

    // si no es un numero o es igual a cero retorno el mismo cero
    if (isNaN(amount) || amount === 0) 
        return parseFloat(0).toFixed(decimals);

    // si es mayor o menor que cero retorno el valor formateado como numero
    amount = '' + amount.toFixed(decimals);

    var amount_parts = amount.split('.'),
        regexp = /(\d+)(\d{3})/;

    while (regexp.test(amount_parts[0]))
        amount_parts[0] = amount_parts[0].replace(regexp, '$1' + ',' + '$2');

    return amount_parts.join('.');
}








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