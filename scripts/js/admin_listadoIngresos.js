//$(document).ready(function(){

var fechaInicial, fechaFin



buscarPorFecha()
buscarSaldoIngresos()



function buscarPorFecha(){
  fechaInicial = $("#date_from").val()
  fechaFin = $("#date_to").val()

  $('#tblIngresos').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/admin_guardaIngreso.asp?com=listarIngresos&de='+fechaInicial+'&a='+fechaFin,
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
        { data: "ingreso_total"},
        { data: "eliminar"}
        // { data: "tarea"}
      ],
       order:[[0,"desc"]],
    });
}

$(".buscar").click(function(){
  console.log("entro buscar por fecha")
  $('#tblIngresos').DataTable().destroy();
  buscarPorFecha()
  buscarSaldoIngresos()
})


function buscarSaldoIngresos(){
  fechaInicial = $("#date_from").val()
  fechaFin = $("#date_to").val()

   $.ajax({
       url:'scripts/asp/admin_guardaIngreso.asp?com=listarIngresos&de='+fechaInicial+'&a='+fechaFin,
       method: "POST",
       cache: false,
       // data: {idReg:IdReg,comm:'eliminarRegistro'},
       dataType: "json"
   }).done(function(rest){
      $.each(rest.data, function (i, item) {
        if(item.ok == 'ok'){
          $("#lblSaldoIngresos").text(item.ingresoTotal)
        }else{
          $("#lblSaldoIngresos").text("0.00")
        }
      })


   })
  
}


function eliminarRegistro(IdReg){
  if(confirm("¿Seguro desea borrar este registro?")){
     $.ajax({
         url:"scripts/asp/admin_guardaIngreso.asp",
         method: "POST",
         cache: false,
         data: {idReg:IdReg,comm:'eliminarRegistro'},
         dataType: "json"
     }).done(function(rest){
        $.each(rest.data, function (i, item) {
          if(item.ok == 'ok'){
            alert("Se elimino correctamente...")
            $('#tblIngresos').DataTable().ajax.reload();
          }else{
            alert("No se borro el registro, consulte al administrador del sistema")
          }
        })


     })
  }
}
