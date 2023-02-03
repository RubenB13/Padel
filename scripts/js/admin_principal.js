//obtener mes actual
var mesActual = new Date();
var meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Setiembre", "Octubre", "Noviembre", "Diciembre"];
$("#fecha-actual").text('Mes actual: '+meses[mesActual.getMonth()])
$("#MesActuaLT").text('Resumen del Mes de : '+meses[mesActual.getMonth()])

console.log(meses[mesActual.getMonth()]);

var DiaActual= new Date();
fechaFormato = DiaActual.getFullYear() + "/" +(DiaActual.getMonth() + 1) + "/" + DiaActual.getDate()
console.log('imprimir fecha funcion '+fechaFormato);

obtenerAgendas()
obtenerEgresosDia()
obtenerIngresoRenta()
obtenerIngresoVenta()
tabla_mensual()
tabla_Anual()
obtenerResumenAnual()


function obtenerIngresoRenta(){
 $.ajax({
    url:"scripts/asp/admin_datosPrincipal.asp",
    cache: false,
    data: {comm:"ingresosRenta", fecha_actual:fechaFormato},
    dataType: "json",
    method: "POST"
  }).done(function(rest){
      $.each(rest.data,  function(i,item) {
        if (item.ingreso_total == "") {
          $("#IngEstimadosRenta").text('$0.00')
        }else {
          $("#IngEstimadosRenta").text(item.ingresos_renta)
        }
      });

    })
}
function obtenerIngresoVenta(){
 $.ajax({
    url:"scripts/asp/admin_datosPrincipal.asp",
    cache: false,
    data: {comm:"ingresosVenta", fecha_actual:fechaFormato},
    dataType: "json",
    method: "POST"
  }).done(function(rest){
      $.each(rest.data,  function(i,item) {
        if (item.ingreso_total == "") {
          $("#IngEstimadosVenta").text('$0.00')
        }else {
          $("#IngEstimadosVenta").text(item.ingreso_total)
        }
      });

    })
}

function obtenerAgendas(){
 $.ajax({
    url:"scripts/asp/admin_datosPrincipal.asp",
    cache: false,
    data: {comm:"agendaPordia", fecha_actual:fechaFormato},
    dataType: "json",
    method: "POST"
  }).done(function(rest){
      $.each(rest.data,  function(i,item) {
        $("#agendaDia").text(item.fecha_renta+' registros en total')
      });

    })
}

function obtenerEgresosDia(){
 $.ajax({
    url:"scripts/asp/admin_datosPrincipal.asp",
    cache: false,
    data: {comm:"egresosDia", fecha_actual:fechaFormato},
    dataType: "json",
    method: "POST"
  }).done(function(rest){
      $.each(rest.data,  function(i,item) {
        if (item.egreso_total == "") {
          $("#EgresosDia").text('$0.00')
        }else {
          $("#EgresosDia").text(item.egreso_total)
        }
      //  console.log('imprimir rest '+ rest.data);
      });
      //console.log('imprimir rest '+ rest.data);
    })
}

function tabla_mensual(){
  $('#tblResumenGral').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/admin_datosPrincipal.asp?com=resumenMensual&fecha_mes='+fechaFormato,
      processing: true,
      type: 'POST',
        "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
    },
      columns: [
        { data: "ingreso_cancha"},
        { data: "ingreso_total"},
        { data: "egreso_total"},
        {data: "egreso_maestros"},
        {data: "balance"}

      ],
       order:[[1,"desc"]],
    });

}

function tabla_Anual(){
  $('#tblResumenAnual').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/admin_datosPrincipal.asp?com=resumenAnual',
      processing: true,
      type: 'POST',
        "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
    },
      columns: [
        {data: "mes"},
        {data: "ingreso_cancha"},
        {data: "descuento"},
        {data: "ingreso_total"},
        {data: "egreso_total"},
        {data: "egreso_maestros"},
        {data: "balance"}


      ],
       order:[[1,"desc"]],
    });

}

  var meses = new Array();
  var balanceMensual = new Array();

function obtenerResumenAnual() {

    $.ajax({
      url:"scripts/asp/admin_datosPrincipal.asp?com=resumenAnual",
      method: "POST",
      cache: false,
      dataType: "json"
    }).done(function(rest){
      
      $.each(rest.data, function(i, item){
        if(rest.data != ""){
          
          meses.push(item.mes)
          balanceMensual.push(item.balance1)            
        }else{
            
        }
      })
      graficarAnioBalance(meses, balanceMensual)
      
    })     
  }


function graficarAnioBalance(mes, balanceMensual){
      console.log(mes)
      console.log(balanceMensual)

      $('#chart-anual').chart(
      {
        type: 'line',
        data: {
            labels: mes,
            datasets: [
                {
                    label: 'Resumen Mensual',
                    data: balanceMensual,
                    fill: true,
                    lineTension: 0.4,
                    backgroundColor: hexToRGB(app.color.primary, 0.2),
                    borderColor: app.color.primary,
                    borderWidth: 2,
                    borderCapStyle: 'butt',
                    borderDash: [],
                    borderDashOffset: 0.0,
                    borderJoinStyle: 'miter',
                    pointBorderColor: app.color.primary,
                    pointBackgroundColor: '#fff',
                    pointBorderWidth: 2,
                    pointHoverRadius: 4,
                    pointHoverBackgroundColor: app.color.primary,
                    pointHoverBorderColor: '#fff',
                    pointHoverBorderWidth: 2,
                    pointRadius: 4,
                    pointHitRadius: 10,
                    spanGaps: false
                }
            ]
        },
        options: {
        }
      }
    );

}


// function grafica(){
//   const ctx = document.getElementById('grafica');
// const myChart = new Chart(ctx, {
//     type: 'bar',
//     data: {
//         labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
//         datasets: [{
//             label: '# of Votes',
//             data: [12, 19, 3, 5, 2, 3],
//             backgroundColor: [
//                 'rgba(255, 99, 132, 0.2)',
//                 'rgba(54, 162, 235, 0.2)',
//                 'rgba(255, 206, 86, 0.2)',
//                 'rgba(75, 192, 192, 0.2)',
//                 'rgba(153, 102, 255, 0.2)',
//                 'rgba(255, 159, 64, 0.2)'
//             ],
//             borderColor: [
//                 'rgba(255, 99, 132, 1)',
//                 'rgba(54, 162, 235, 1)',
//                 'rgba(255, 206, 86, 1)',
//                 'rgba(75, 192, 192, 1)',
//                 'rgba(153, 102, 255, 1)',
//                 'rgba(255, 159, 64, 1)'
//             ],
//             borderWidth: 1
//         }]
//     },
//     options: {
//         scales: {
//             y: {
//                 beginAtZero: true
//             }
//         }
//     }
// });
// }

/*  $.ajax({
     url:"scripts/asp/admin_datosPrincipal.asp?com=resumenAnual",
     method: "POST"
   }).done(function(resp){
     var data  = resp;
     var mes = []
     var balance = []
     for (var i = 0; i < data.length; i++) {
       mes.push(data[i][1]);;
       balance.push(data[i][5]);
     }
     var ctx = document.getElementById('grafica');
     var grafica = new Chart(ctx,{
       type: 'line'
       data: {
         labels: mes,
         datasets:[{
           data: balance,
           borderColor:['rgba(255, 99, 132, 1)'],
           borderWidth:1
         }]

       }

     })
      console.log(data[0]);
    })*/
