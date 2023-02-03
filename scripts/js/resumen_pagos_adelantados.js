
vemosMesActual()

function vemosMesActual(){

  const date = new Date(); 
  const month = date.toLocaleString('default', { month: 'long' });
 
  $("#mesPagoAdelantado").text(month)
}



resumenMesPagosAd()

function resumenMesPagosAd(){


  $('#resumenPagosAdelantadosMes').dataTable({
    destroy: true,
    retrieve: true,
    responsive: true,
    ajax: 'scripts/asp/resumenPagosAd.asp?com=verResumenMes',
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

  

}

resumentipoMes()
function resumentipoMes() {
 
  $('#resumenPagosAdelantadosMestipo').dataTable({
    destroy: true,
    retrieve: true,
    responsive: true,
    ajax: 'scripts/asp/resumenPagosAd.asp?com=verResumenMesTipo',
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

resumenglobalPagosAd()

function resumenglobalPagosAd(){


  $('#resumenGlobalPagosAdelantados').dataTable({
    destroy: true,
    retrieve: true,
    responsive: true,
    ajax: 'scripts/asp/resumenPagosAd.asp?com=verResumenGlobal',
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

  

}

function consultaporFecha(){
 
  desde = $("#desde").val()
  hasta = $("#hasta").val()


if (desde =="" || hasta ==""){

  alert("Coloque correctamente las fechas")
}

else {
 
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
}


iniciaTabladeConsulta()

function iniciaTabladeConsulta(){
 
  $('#resumenPagosAdelantadosConsultado').DataTable({

  });
  $('#resumenPagosAdelantadosMestipoConsultado').DataTable({

  });

}


