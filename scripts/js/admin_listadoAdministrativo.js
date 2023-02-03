 //buscarTotalesPorFecha()


  var fechaInicial, fechaFin
  var abc

  function buscarTotalesPorFecha(){
    fechaInicial = $("#date_from").val()
    fechaFin = $("#date_to").val()
    console.log(fechaInicial + "  -  " + fechaFin)

    $('#tblAdministrativo').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/admin_listadoAdministrativo.asp?com=listarAdministrativo&de='+fechaInicial+'&a='+fechaFin,
      processing: true,
      type: 'POST',
        "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
    },
      columns: [
        { data: "renta_normal"},
        { data: "wpt"},
        { data: "particular"},
        { data: "grupal"},
        { data: "academia"},
        { data: "acaddia"},
        { data: "playtomic"},
        { data: "total_reservaciones"},
        { data: "reservaciones_descuento"},
        { data: "ingreso_total"}
      ]
    });
 


  }


  function buscanuevosTotales(){
    fechaInicial = $("#date_from").val()
    fechaFin = $("#date_to").val()
    console.log(fechaInicial + "  -  " + fechaFin)

    $('#tblAdministrativo2').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/admin_listadoAdministrativo.asp?com=horariosconcurridos&de='+fechaInicial+'&a='+fechaFin,
      processing: true,
      type: 'POST',
        "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
    },
      columns: [
        { data: "concurrida"},
        { data: "muerta"},
        { data: "total"},
        { data: "ingreso"}
      ]
    });
 


  }


    //agrego nuevos datos en tabla nueva 
  function tablanueva1(){ 
    fechaInicial = $("#date_from").val()
    fechaFin = $("#date_to").val()
  

     $('#tblnuevoResumen').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/admin_listadoAdministrativo.asp?com=datosnuevos&de='+fechaInicial+'&a='+fechaFin,
      processing: true,
      type: 'POST',
        "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
    },
      columns: [
        { data: "Concepto"},
        { data: "Part 1"},
        { data: "Part 2"},
        { data: "Part 3"},
        { data: "Part 4"},
        { data: "Grup 1"},
        { data: "Grup 2"},
        { data: "Grup 3"},
        { data: "Grup 4"}
      ]
    });
  }

  function tablanuevaAcad(){ 
    fechaInicial = $("#date_from").val()
    fechaFin = $("#date_to").val()
  

     $('#tblresumenAca').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/admin_listadoAdministrativo.asp?com=consultaAcad&de='+fechaInicial+'&a='+fechaFin,
      processing: true,
      type: 'POST',
        "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
    },
      columns: [
        { data: "Concepto"},
        { data: "Academia 1"},
        { data: "Academia 2"},
        { data: "Academia 3"},
        { data: "Academia 4"}
      ]
    });
  }

  function tablanuevaAcad2(){ 
    fechaInicial = $("#date_from").val()
    fechaFin = $("#date_to").val()
  

     $('#tblresumenAca2').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/admin_listadoAdministrativo.asp?com=consultaAcad2&de='+fechaInicial+'&a='+fechaFin,
      processing: true,
      type: 'POST',
        "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
    },
      columns: [
        { data: "Concepto"},
        { data: "Academia 1"},
        { data: "Academia 2"},
        { data: "Academia 3"},
        { data: "Academia 4"}
      ]
    });
  }

  
  function tablaEgIng(){ 
    fechaInicial = $("#date_from").val()
    fechaFin = $("#date_to").val()
  

     $('#tblresumenAdOp').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/admin_listadoAdministrativo.asp?com=consultaAdOp&de='+fechaInicial+'&a='+fechaFin,
      processing: true,
      type: 'POST',
        "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
    },
      columns: [
        { data: "Concepto"},
        { data: "Ingreso por venta"},
        { data: "Egresos Generales"}
      ]
    });
  }



  function consultaporFecha(){
 
    desde = $("#date_from").val()
    hasta = $("#date_to").val()
  
  
  
    $('#resumenPagosAdelantadosConsultado').DataTable().destroy()
    $('#resumenPagosAdelantadosMestipoConsultado').DataTable().destroy()
  
    $('#resumenPagosAdelantadosConsultado').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/resumenPagosAd.asp?com=ConsultarMes&de='+desde+'&a='+hasta,
      processing: true,
      type: 'POST',
        "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
    },
    columns: [
      { data: "totalClases"},
      { data: "totalPagado"},
      { data: "ClasesRestantes"},
      { data: "CapitalRestante"}
       ],
         order: [[0, 'desc']],
    });
  
    $('#resumenPagosAdelantadosMestipoConsultado').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/resumenPagosAd.asp?com=verResumenMesTipoCons&de='+desde+'&a='+hasta,
      processing: true,
      type: 'POST',
        "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
    },
      columns: [
        { data: "tipo"},
        { data: "total"},
        { data: "ingreso"}
         ],
         order: [[0, 'desc']],
         
    });
  
  }
  
  

  // // consulta general

  // function resGeneral(){
 
  
  //   $('#ResumenGeneral').DataTable().destroy()

  //   $('#ResumenGeneral').dataTable({
  //     destroy: true,
  //     retrieve: true,
  //     responsive: true,
  //     ajax: 'scripts/asp/admin_listadoAdministrativo.asp?com=global',
  //     processing: true,
  //     type: 'POST',
  //       "oLanguage": {
  //   "sUrl": "../../libs/datatables/tableLanguaje.txt"
  //   },
  //   columns: [
  //     { data: "resumen"},
  //     { data: "adelantados"},
  //     { data: "ingresos"},
  //     { data: "egresos"}
  //      ],
  //        order: [[0, 'desc']],
  //   });
  

  
  // }
  
  // busqueda en todas las tablas

  $(".buscarAdmin").click(function(){
    desde = $("#date_from").val()
    hasta = $("#date_to").val()
  
  
  if (desde =="" || hasta ==""){
  
    alert("Coloque correctamente las fechas")
  }

  else {
    $('#tblAdministrativo').DataTable().destroy();
    $('#tblnuevoResumen').DataTable().destroy();
    $('#tblresumenAca').DataTable().destroy();
    $('#tblresumenAca2').DataTable().destroy();
    $('#tblresumenAdOp').DataTable().destroy();
    $('#tblAdministrativo2').DataTable().destroy();
    $('#ResumenGeneral').DataTable().destroy();
    verPagos_modalidades()
    buscarTotalesPorFecha()
    tablanueva1()
    tablanuevaAcad()
    tablanuevaAcad2()
    tablaEgIng()
    buscanuevosTotales()
    consultaporFecha()
    verclasesPagadas() 
    // tablafinal()
    setTimeout(() => {
      obtieneValores()
    }, 3000);
  }
  })


// var valores = [ ['10','11','12','13']] 


// function tablafinal () { 

//   $('#ResumenGeneral').DataTable({
//     destroy: true,
//     retrieve: true,
//     responsive: true,
//       data: valores,
//       columns: [
//       { title: 'Ingreso Total'},
//       { title: 'Pagos Adelantados'},
//       { title: 'Ventas'},
//       { title: 'Gastos'}
//         ]
      
//   });



// }



function obtieneValores(){

  let oTable = document.getElementById('tblAdministrativo');
  let data = [...oTable.rows].map(t => [...t.children].map(u => u.innerText))

  let Table2 = document.getElementById('tblAdministrativo2');
  let data4 = [...Table2.rows].map(t => [...t.children].map(u => u.innerText))
   
  let Table = document.getElementById('resumenPagosAdelantadosConsultado');
  let data2 = [...Table.rows].map(t => [...t.children].map(u => u.innerText))

  let Table3 = document.getElementById('tblresumenAdOp');
  let data3 = [...Table3.rows].map(t => [...t.children].map(u => u.innerText))

  // consultamos los pagos de profesor grupal y particular
  

  let tablaprofes  = document.getElementById('tblnuevoResumen')
  let datosprofe = [...tablaprofes.rows].map(t => [...t.children].map(u => u.innerText))

  let tablaprofes2  = document.getElementById('tblresumenAca')
  let datosprofe2 = [...tablaprofes2.rows].map(t => [...t.children].map(u => u.innerText))

  let tablaprofes3  = document.getElementById('tblresumenAca2')
  let datosprofe3 = [...tablaprofes3.rows].map(t => [...t.children].map(u => u.innerText))


 var det = []
 var sum1 = 0

 var det2 = []
 var sum2 = 0

 var det3 = []
 var sum3 = 0

//  arreglo clase particular y grupal

  for (let i = 1; i <9;i++) {
   det.push(parseFloat( datosprofe[2][i] 
    .replace('$','')
    .replace(',','')))
  }

  // arreglo academia mes

  for (let i = 1; i <5;i++) {
   det2.push(parseFloat( datosprofe2[2][i] 
    .replace('$','')
    .replace(',','')))
  }

  // arreglo academia dia 

  for (let i = 1; i <5;i++) {
   det3.push(parseFloat( datosprofe3[2][i] 
    .replace('$','')
    .replace(',','')))
  }

  // sumas en orden de arreglos 
  
for (let j = 0; j <=7; j++) {
  sum1 += parseInt(det[j]) 
}

for (let j = 0; j <=3; j++) {
  sum2 += parseInt(det2[j]) 
}

for (let j = 0; j <=3; j++) {
  sum3 += parseInt(det3[j]) 
}



  valor1 = data[1][9]
  v2 = data4[1][3]
  valor2 = data2[1][1]
  restan = data2[1][3]
  valor3 = data3[1][1]
  valor4 = data3[1][2]

  ing = valor1
      .replace('$','')
      .replace(',','')
  pa = v2
      .replace('$','')
      .replace(',','')
igt = parseFloat(ing)+ parseFloat(pa)

totalpagoprofesores = '$' +(sum1+ sum2+ sum3).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');

tt = '$'+(igt).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');

pa =  valor2
.replace('$','')
.replace(',','')
tva =  valor3
.replace('$','')
.replace(',','')
mtc = montoDeclases
  .replace('$','')
  .replace(',','')
tingresos = '$'+(igt + parseFloat(pa) + parseFloat(tva)- parseFloat(mtc)).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
tingresos2 = igt + parseFloat(pa) + parseFloat(tva)- parseFloat(mtc)

eg = valor4 
.replace('$','')
.replace(',','')
ppfroser =sum1+ sum2+ sum3

tegresos = '$'+(parseFloat(eg)+ parseFloat(ppfroser)).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
tegresos2 = parseFloat(eg)+ parseFloat(ppfroser)
balance = '$'+ (tingresos2 - tegresos2).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
// valores de tabla = ['Ingreso Total','clasesYa pagadas' , 'Pagos Adelantados', 'Pago a Profesores', 'Ventas', 'Gastos' ]
  var valores = [ [tt, montoDeclases ,valor2, restan, totalpagoprofesores, valor3, valor4],['total Ingresos:', tingresos, 'total Egresos',tegresos, 'Balance:', balance, '']] 


  $('#ResumenGeneral').DataTable({
    destroy: true,
    retrieve: true,
    responsive: true,
      data: valores,
      columns: [
      { title: 'Ingreso Total'},
      { title: '$ Clases Pagadas'},
      { title: 'Pagos Adelantados'},
      { title: '$ restante Pa'},
      { title: 'Pago a Profesores'},
      { title: 'Ventas'},
      { title: 'Gastos'}
        ]
      
  });

}



// **************************************************************
// ******* lista los pagos en sus diferentes modalidades ********

function verPagos_modalidades(){
  fechaInicial = $("#date_from").val()
  fechaFin = $("#date_to").val()

  $.ajax({
     url:"scripts/asp/admin_listadoAdministrativo.asp",
     method: "POST",
     cache: false,
     data: { 
             comm:'verPagos_modalidades',
             fi:fechaInicial,
             ff:fechaFin
           },
     dataType: "json"
  }).done(function(rest){
    $.each(rest.data, function (i, item) {
      if (item.ok == 'ok'){
        $("#spanIngresoTotal").text("Total Ingreso Real: "+item.total)
        
        $("#txtPlaytomic").text(item.playtomic)
        // porcentajePlaytomic = (parseFloat(item.playtomic)*100)/parseFloat(item.total)
        $("#spanPlaytomic").text(item.p_playtomic+"%")

        $("#txtTransferencia").text(item.transferencia)
        // porcentajeTransferencia = (parseFloat(item.transferencia)*100)/parseFloat(item.total)
        $("#spanTransferencia").text(item.p_transferencia+"%")

        $("#txtTarjeta").text(item.tarjeta)
        // porcentajeTarjeta = (parseFloat(item.tarjeta)*100)/parseFloat(item.total)
        $("#spanTarjeta").text(item.p_tarjeta+"%")

        $("#txtDeposito").text(item.deposito)
        // porcentajeDeposito = (parseFloat(item.deposito)*100)/parseFloat(item.total)
        $("#spanDeposito").text(item.p_deposito+"%")

        $("#txtEfectivo").text(item.efectivo)
        // porcentajeEfectivo = (parseFloat(item.efectivo)*100)/parseFloat(item.total)
        $("#spanEfectivo").text(item.p_efectivo+"%")

        $("#txtDescuento").text(item.descuento)
      } 
    })
  })
}


var montoDeclases = 0

function verclasesPagadas() {

  $.ajax({
    url:"scripts/asp/admin_listadoAdministrativo.asp",
    method: "POST",
    cache: false,
    data: { 
            comm:'verClasesPagadas',
            fi:fechaInicial,
            ff:fechaFin
          },
    dataType: "json"
 }).done(function(rest){
   $.each(rest.data, function (i, item) {
     if (item.ok == 'ok'){
      
    montoDeclases = item.total
     } 
   })
 })

}



document.getElementById("btnDetallePa").addEventListener("click", function() {

  desde = $("#date_from").val()
  hasta = $("#date_to").val()

if (desde =="" || hasta =="") {
  alert("por favor coloque una fecha para consultar!")
}
else {

$("#detallePagoAdelantado").modal("show")

DetalleClases()
$('#pagosRealizados').DataTable().destroy()
$('#clasesTomadas').DataTable().destroy()
DetalleClases()
}
})


function DetalleClases(){
 
  desde = $("#date_from").val()
  hasta = $("#date_to").val()


  $('#pagosRealizados').dataTable({
    destroy: true,
    retrieve: true,
    responsive: true,
    ajax: 'scripts/asp/resumenPagosAd.asp?com=VerDetallePa&de='+desde+'&a='+hasta,
    processing: true,
    type: 'POST',
      "oLanguage": {
  "sUrl": "../../libs/datatables/tableLanguaje.txt"
  },
  columns: [
    { data: "usuario"},
    { data: "fechaPago"},
    { data: "Cantidad"}
     ],
       order: [[0, 'desc']],
  });

  $('#clasesTomadas').dataTable({
    destroy: true,
    retrieve: true,
    responsive: true,
    ajax: 'scripts/asp/resumenPagosAd.asp?com=DetalleClases&de='+desde+'&a='+hasta,
    processing: true,
    type: 'POST',
      "oLanguage": {
  "sUrl": "../../libs/datatables/tableLanguaje.txt"
  },
    columns: [
      { data: "usuario"},
      { data: "fecha"},
      { data: "monto"}
       ],
       order: [[0, 'desc']],
       
  });


}




