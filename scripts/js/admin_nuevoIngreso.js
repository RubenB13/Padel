function guardarIngreso(){
    //cliente = $("#optCliente option:selected").text();
    //console.log(cliente)
  //  total_Ingreso = $("15").text()
    info = $("#frmIngresos").serialize()
    info =  info + "&comm=nuevoIngreso&idReg=0"
    console.log(info)
    $.ajax({
    url: "scripts/asp/admin_guardaIngreso.asp",
    cache:false,
    dataType:"json",
    data: info,
    method: "POST"
  }).done(function(rest){
     $.each(rest.data, function (i, item) {
      if (item.ok=="ok") {
        $("#frmIngresos").get(0).reset();
        $("#txtIngTotalR").text("")
        // $('#tblAgenda').DataTable().ajax.reload();
        alert("Se guardo correctamente")
      }
     })
  }).fail(function(jqXHR,estado,error){
    console.log(estado);
    console.log(error);
  })
}

function multi(){
  costo_unidad = $("#txtCosto").val()
  total_unidades = $("#txtConceptoTotal").val()
  ingreso_total = costo_unidad * total_unidades ;
  document.getElementById('txtIngTotalR').value =  ingreso_total

/*  const $total = document.getElementById('txtIngTotalR');
 let subtotal = 0;
 [ ...document.getElementsByClassName( "form-control multi" ) ].forEach( function ( element ) {
   if(element.value !== '') {
     subtotal *= parseFloat(element.value);
   }
 });
 $total.value = subtotal;*/

}
/*
function sumar(){
  costo_unidad = $("#txtCosto").val()
  total_unidades = $("#txtConceptoTotal").val()
  ingreso_total = (costo_unidad) * (total_unidades) ;
  $("#txtIngTotalR").text(ingreso_total)
}*/

// function calcularMinutos(){
// 	horaInicioArray = $("#txthorarioInicio").val().split(":")
// 	horaFinArray = $("#txthorarioFin").val().split(":")

// 	horaInicio = horaInicioArray[0]
// 	minutoInicio = horaInicioArray[1]

// 	horaFin = horaFinArray[0]
// 	minutoFin = horaFinArray[1]

// 	minutosTotalesInicio = (parseInt(horaInicio) * 60) + parseInt(minutoInicio)
// 	minutosTotalesFin = (parseInt(horaFin) * 60) + parseInt(minutoFin)
// }



$("#optTipoServicio").change(function(){
      if($(this).val()!=""){
        idTipoServicio = $(this).val()
          buscaPrecioTipoServicio(idTipoServicio)
      }
})


function buscaPrecioTipoServicio(idTipoServicio){
  //busca los precios del tipo de servicio
  $.ajax({
      url:"scripts/asp/admin_capturarTipoServicio.asp",
      cache: false,
      data: {comm:"precioServicios", idTipoServicio:idTipoServicio},
      dataType: "json",
      method: "POST"
  }).done(function(rest){
      $.each(rest.data, function (i, item) {
        $("#txtprecioCancha").val(item.precio_hora)
        $("#txtdosPersonas").val(item.dos_personas)
        $("#txttresPersonas").val(item.tres_personas)
        $("#txtcuatroPersonas").val(item.cuatro_personas)
        $("#txtinscripcion").val(item.inscripcion)
      });
     calculaPrecioFinalTipoServicio()
  })
}

function calculaPrecioFinalTipoServicio(){
  if ( $("#optTipoServicio").val()== 1 ) {

    //renta cancha normal
    $("#divDatosAcademia").hide()
    $("#divClasesAcademia").hide()
    limpiarDatosAcademia()

    if ( numHoras > 1 ) {
      $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val() * numHoras).toFixed(2) )
    }else {
      $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()).toFixed(2) )
    }


  }else if ( $("#optTipoServicio").val()== 2 ) {

    //renta cancha WPT
    $("#divDatosAcademia").hide()
    $("#divClasesAcademia").hide()
    limpiarDatosAcademia()

    if ( numHoras > 1 ) {
      $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val() * numHoras).toFixed(2) )
    }else {
      $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()).toFixed(2) )
    }


  }else if ( $("#optTipoServicio").val()== 3 ) {

    //renta cancha academia
    $("#divDatosAcademia").show()
    $("#divClasesAcademia").show()
    limpiarDatosAcademia()
    $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()).toFixed(2) )

    if ( $("#optTipoPago").val() == 1 ) { //Mensual
      $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()* 1 ).toFixed(2) )
    }else if ( $("#optTipoPago").val() == 2 ) { //Bimestral
      $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()* 2 ).toFixed(2) )
    }else if ( $("#optTipoPago").val() == 3 ) { //Trimestral
      $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()* 3 ).toFixed(2) )
    }else if ( $("#optTipoPago").val() == 4 ) { //Anual
      $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()* 12).toFixed(2)  )
    }

  }else if ( $("#optTipoServicio").val()== 4 ) {

    //renta cancha Clase Grupal
    if ( $("#optNumPersonas").val() > 1) {
      if ( $("#optNumPersonas").val() == 2 ) {
        $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtdosPersonas").val()).toFixed(2) )
      }else if ( $("#optNumPersonas").val() == 3 ) {
        $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txttresPersonas").val()).toFixed(2) )
      }else if ( $("#optNumPersonas").val() == 4 ) {
        $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtcuatroPersonas").val()).toFixed(2) )
      }
    }else{
      $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()).toFixed(2) )
    }

    $("#divDatosAcademia").hide()
    $("#divClasesAcademia").hide()
    limpiarDatosAcademia()

  }else if ( $("#optTipoServicio").val()== 5 ) {

    //renta cancha Clase Particular
    if ( $("#optNumPersonas").val() > 1) {
      if ( $("#optNumPersonas").val() == 2 ) {
        $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtdosPersonas").val()).toFixed(2) )
      }else if ( $("#optNumPersonas").val() == 3 ) {
        $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txttresPersonas").val()).toFixed(2) )
      }else if ( $("#optNumPersonas").val() == 4 ) {
        $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtcuatroPersonas").val()).toFixed(2) )
      }
    }else{
      $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()).toFixed(2) )
    }
    $("#divDatosAcademia").hide()
    $("#divClasesAcademia").hide()
    limpiarDatosAcademia()
  }
}


//Calculamos el precio por el numero de personas, solo para la clase particular y Clase grupal
$("#optNumPersonas").change(function() {
  //
  if ( $("#optTipoServicio").val() == 4 || $("#optTipoServicio").val() == 5 ) {
    if ( $("#optNumPersonas").val() == 1 ) {
      $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()).toFixed(2) )
    }else if ( $("#optNumPersonas").val() == 2 ) {
      $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtdosPersonas").val()).toFixed(2) )
    }else if ( $("#optNumPersonas").val() == 3 ) {
      $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txttresPersonas").val()).toFixed(2) )
    }else if ( $("#optNumPersonas").val() == 4 ) {
      $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtcuatroPersonas").val()).toFixed(2) )
    }
  }
})


//calculamos la fecha del proximo pago del tipo ACADEMIA
$("#optTipoPago").change(function(){
  if ( $("#txtfechaInscrpcion").val() != '' ) {
    fechaInscripcion = $("#txtfechaInscrpcion").val().split("/")
    dia = fechaInscripcion[1]
    mes = fechaInscripcion[0]
    anio = fechaInscripcion[2]
    f = anio+"/"+mes+"/"+dia
    var fechaIns = new Date(f)
    console.log(fechaIns)

    if ( $("#optTipoPago").val()== 1 ) {
      //Mensual, sumamos 30 dias
      $("#txtUltimaFechadePago").val( sumarDias( fechaIns, 30 ) )
      $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val() * 1).toFixed(2) )
    }else if ( $("#optTipoPago").val()== 2 ) {
      //Bimestral, sumamos 60 dias
      $("#txtUltimaFechadePago").val( sumarDias( fechaIns, 60 ) )
      $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val() * 2).toFixed(2) )
    }else if ( $("#optTipoPago").val()== 3 ) {
      //Trimestral, sumamos 90 dias
      $("#txtUltimaFechadePago").val( sumarDias( fechaIns, 90 ) )
      $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val() * 3).toFixed(2) )
    }else if ( $("#optTipoPago").val()== 4 ) {
      //Anual, sumamos 365 dias
      $("#txtUltimaFechadePago").val( sumarDias( fechaIns, 365 ) )
      $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val() * 12).toFixed(2) )
    }
  }
})

//funcion para sumar los dias del proximo pago en tipo servico ACADEMIA
function sumarDias(fecha, dias){
  fecha.setDate(fecha.getDate() + dias)
  let formatted_date = (fecha.getMonth() + 1) + "/" + fecha.getDate() + "/" + fecha.getFullYear()
  return formatted_date
}

function limpiarDatosAcademia(){
  $("#txtNivel").val('')
  $("#txtGrupoAsignado").val('')
  $("#txtfechaInscrpcion").val('')
  $("#txtUltimaFechadePago").val('')
  $("#optTipoPago").val('')
  $("#optEstatus").val('')
}

var numHoras;

function calcularHoras(){
  horaInicioArray = $("#txthorarioInicioC1").val().split(":")
  horaFinArray = $("#txthorarioFinC1").val().split(":")

  horaInicio = horaInicioArray[0]
  minutoInicio = horaInicioArray[1]

  horaFin = horaFinArray[0]
  minutoFin = horaFinArray[1]

  minutosTotalesInicio = (parseInt(horaInicio) * 60) + parseInt(minutoInicio)
  minutosTotalesFin = (parseInt(horaFin) * 60) + parseInt(minutoFin)

  numMinutos = parseInt(minutosTotalesFin) - parseInt(minutosTotalesInicio)

  numHoras = parseInt(numMinutos)/60

  if ( numHoras > 1 ) {
    $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val() * numHoras).toFixed(2) )
  }else {
    $("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()).toFixed(2) )
  }

}

$("#txthorarioInicioC1").on('input', function(){
  if ($("#optTipoServicio").val()== 1 || $("#optTipoServicio").val()== 2) {
    calcularHoras()
  }

})

$("#txthorarioFinC1").on('input', function(){
  if ($("#optTipoServicio").val()== 1 || $("#optTipoServicio").val()== 2) {
    calcularHoras()
  }
})

var ValAnterior, idAnterior, id;
$("#txtFechaReservaC1, #txtFechaReservaC2, #txtFechaReservaC3, #txtFechaReservaC4, #txtFechaReservaC5, #txtFechaReservaC6, #txtFechaReservaC7, #txtFechaReservaC8").on('input', function(e){
  id = $(this).attr('id')

  if ( $(this).val() != ValAnterior || id != idAnterior) {
    ValAnterior = $(this).val()
    idAnterior = id

    if (id == "txtFechaReservaC1") {
      console.log("c1")
      fecha_reservada = $("#txtFechaReservaC1").val()
      cancha_reservada = $("#optCanchaAsignada1").val()
      clase = 1
    }else if (id == "txtFechaReservaC2") {
      console.log("c2")
      fecha_reservada = $("#txtFechaReservaC2").val()
      cancha_reservada = $("#optCanchaAsignada2").val()
      clase = 2
    }else if (id == "txtFechaReservaC3") {
      console.log("c3")
      fecha_reservada = $("#txtFechaReservaC3").val()
      cancha_reservada = $("#optCanchaAsignada3").val()
      clase = 3
    }else if (id == "txtFechaReservaC4") {
      console.log("c4")
      fecha_reservada = $("#txtFechaReservaC4").val()
      cancha_reservada = $("#optCanchaAsignada4").val()
      clase = 4
    }else if (id == "txtFechaReservaC5") {
      console.log("c5")
      fecha_reservada = $("#txtFechaReservaC5").val()
      cancha_reservada = $("#optCanchaAsignada5").val()
      clase = 5
    }else if (id == "txtFechaReservaC6") {
      console.log("c6")
      fecha_reservada = $("#txtFechaReservaC6").val()
      cancha_reservada = $("#optCanchaAsignada6").val()
      clase = 6
    }else if (id == "txtFechaReservaC7") {
      console.log("c7")
      fecha_reservada = $("#txtFechaReservaC7").val()
      cancha_reservada = $("#optCanchaAsignada7").val()
      clase = 7
    }else if (id == "txtFechaReservaC8") {
      console.log("c8")
      fecha_reservada = $("#txtFechaReservaC8").val()
      cancha_reservada = $("#optCanchaAsignada8").val()
      clase = 8
    }


    buscarReservaciones(fecha_reservada, cancha_reservada, clase)
  }

})


var reservaciones=""

function buscarReservaciones(fechaReservada, canchaReservada, clase){
  $("#DivReservaciones1, #DivReservaciones2, #DivReservaciones3, #DivReservaciones4, #DivReservaciones5, #DivReservaciones6, #DivReservaciones7, #DivReservaciones8").hide()
  $("#ListaReservaciones1, #ListaReservaciones2, #ListaReservaciones3, #ListaReservaciones4, #ListaReservaciones5, #ListaReservaciones6, #ListaReservaciones7, #ListaReservaciones8").html("")
  $("#ListaReservaciones"+clase).html("")
  $("#DivReservaciones"+clase).show()
  reservaciones = ""

  $.ajax({
      url: "scripts/asp/admin_capturarAgenda.asp",
      cache:false,
      dataType:"json",
      data: {	comm: "buscarReservacion",
          txtFechaReservaC1: fechaReservada,
          optCanchaAsignada1: canchaReservada
        },
      method: "POST"
    }).done(function(rest){
       $.each(rest.data, function (i, item) {
        if (item.ok=="ok") {
          reservaciones  = reservaciones + '<a class="list-group-item ml-3 mr-3 p-0 pl-3" style="cursor:default">\
          '+item.nombre_cliente+" - "+" horario: "+item.hora_inicio+" a "+item.hora_fin+'\
          <span class="float-right text-primary"><i class="fa fa-circle text-xs"></i></span></a>'
        }else{
          reservaciones =  "<p class='list-group-item warning ml-3 mr-3 p-0 pl-3'>SIN RESERVACIONES PARA ESTE DÍA...</p>"
        }
       })

       $("#ListaReservaciones"+clase).html(reservaciones)


    }).fail(function(jqXHR,estado,error){
      console.log(estado);
      console.log(error);
    })
}
