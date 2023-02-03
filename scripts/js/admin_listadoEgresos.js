//$(document).ready(function(){

// muestra todas las incidencas

buscarPorFecha()
buscarSaldoEgresos()
var fechaInicial, fechaFin
function buscarPorFecha(){
  fechaInicial = $("#date_from").val()
  fechaFin = $("#date_to").val()
  console.log(fechaInicial + "  -  " + fechaFin)

  $('#tblEgresos').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/admin_guardaEgreso.asp?com=listarEgresos&de='+fechaInicial+'&a='+fechaFin,
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
        { data: "tipo_egreso"},
        { data: "frecuencia_egreso"},
        { data: "justificacion"},
        { data: "responsable"},
        { data: "costo_unitario"},
        { data: "cantidad_total"},
        { data: "egreso_total"},
        { data: "eliminar"}
        // { data: "tarea"}
      ],
       order:[[1,"desc"]],
    });
}


$(".buscar").click(function(){
  console.log("entro buscar por fecha")
  $('#tblEgresos').DataTable().destroy();
  // $('#tblIncidencias').DataTable().draw();
  buscarPorFecha()
  buscarSaldoEgresos()
})


function buscarSaldoEgresos(){
  fechaInicial = $("#date_from").val()
  fechaFin = $("#date_to").val()

   $.ajax({
       url:'scripts/asp/admin_guardaEgreso.asp?com=listarEgresos&de='+fechaInicial+'&a='+fechaFin,
       method: "POST",
       cache: false,
       // data: {idReg:IdReg,comm:'eliminarRegistro'},
       dataType: "json"
   }).done(function(rest){
      $.each(rest.data, function (i, item) {
        if(item.ok == 'ok'){
          $("#lblSaldoEgresos").text(item.egresoTotal)
        }else{
          $("#lblSaldoEgresos").text("0.00")
        }
      })


   })
  
}


function eliminarRegistro(IdReg){
      if(confirm("¿Seguro desea borrar este registro?")){
         $.ajax({
             url:"scripts/asp/admin_guardaEgreso.asp",
             method: "POST",
             cache: false,
             data: {idReg:IdReg,comm:'eliminarRegistro'},
             dataType: "json"
         }).done(function(rest){
            $.each(rest.data, function (i, item) {
              if(item.ok == 'ok'){
                alert("Se elimino correctamente...")
                $('#tblEgresos').DataTable().ajax.reload();
              }else{
                alert("No se borro el registro, consulte al administrador del sistema")
              }
            })


         })
      }
   }
