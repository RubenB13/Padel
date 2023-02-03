verMesActual()

function verMesActual() { 

  const date = new Date(); 
  const month = date.toLocaleString('default', { month: 'long' });

  $("#tituloTabla").text("Mes Actual: "+month)
}

function guardaTransCaja(){
    info = $("#frmTransCaja").serialize()
    info =  info + "&comm=NuevaTransCaja&idReg=0"
    console.log(info)
    $.ajax({
    url: "scripts/asp/admin_guardaTransCaja.asp",
    cache:false,
    dataType:"json",
    data: info,
    method: "POST"
  }).done(function(rest){
    $.each(rest.data, function (i, item) {
     if (item.ok=="ok") {
       $("#frmTransCaja").get(0).reset();
       reiniciaTabla()
      alert("Transacción de caja guardada")
      }
     })
     console.log(rest);
  }).fail(function(jqXHR,estado,error){
    console.log(estado);
    console.log(error);
  })
}


HistorialCaja()
function HistorialCaja(){ 

   $('#tablaTransaccionesCaja').dataTable({
    destroy: true,
    retrieve: true,
    responsive: true,
    ajax: 'scripts/asp/admin_ResumenCaja.asp?com=consultaMes',
    processing: true,
    type: 'POST',
      "oLanguage": {
  "sUrl": "../../libs/datatables/tableLanguaje.txt"
  },
    columns: [
      { data: "Id", visible:false},
      { data: "Descripcion"},
      { data: "Tipo"},
      { data: "Clasificacion"},
      { data: "Fecha realizada"},
      { data: "Responsable"},
      { data: "Cantidad"},
      { data: "Accion"}
    ]
  });
}
function consultaporFecha(){ 
  de = $("#desde").val()
  a = $("#hasta").val()

  $('#tablaCajaConsultado').DataTable().destroy()

   $('#tablaCajaConsultado').dataTable({
    destroy: true,
    retrieve: true,
    responsive: true,
    ajax: 'scripts/asp/admin_ResumenCaja.asp?com=consultaCaja&de='+de+'&a='+a,
    processing: true,
    type: 'POST',
      "oLanguage": {
  "sUrl": "../../libs/datatables/tableLanguaje.txt"
  },
    columns: [
      { data: "Id", visible:false},
      { data: "Descripcion"},
      { data: "Tipo"},
      { data: "Clasificacion"},
      { data: "Fecha realizada"},
      { data: "Responsable"},
      { data: "Cantidad"},
      { data: "Accion"}
    ]
  });
}

function reiniciaTabla() {
  $('#tablaTransaccionesCaja').DataTable().destroy()
  HistorialCaja()
}

function eliminarTransaccionCaja(idTra){
  if (confirm("Esta acción elimanará el registro, ¿Estas seguro?")) {
    $.ajax({
      url: "scripts/asp/admin_ResumenCaja.asp",
      cache:false,
      dataType:"json",
      data: {comm:"eliminar_trans", idReg:idTra},
      method: "POST"
    }).done(function(rest){
      $.each(rest.data, function (i, item) {
       if (item.ok=="ok") {

         $('#tablaTransaccionesCaja').DataTable().ajax.reload();
         consultaporFecha()    
        }
       })
       console.log(rest);
    }).fail(function(jqXHR,estado,error){
      console.log(estado);
      console.log(error);
    }) 
  }
}

function ModificarTransaccionCaja(id) {

  $.ajax({
    url: "scripts/asp/admin_ResumenCaja.asp",
    cache:false,
    dataType:"json",
    data: {comm:"vertransCaja", idReg:id},
    method: "POST"
  }).done(function(rest){
    $.each(rest.data, function (i, item) {
     if (item.ok=="ok") {
      
        $("#mdModifica").modal("show")
        $("#idtrans").val(id)
        $("#descripAnt").val(item.desc)
        $("#cantidadAnt").val(item.cant)
        $("#fechaAnt").val(item.fech)
      }
     })
     console.log(rest);
  }).fail(function(jqXHR,estado,error){
    console.log(estado);
    console.log(error);
  }) 
}

function modificaTransaccion() {

 id= $("#idtrans").val()
 desc =  $("#nd").val()
 canti =  $("#nc").val()
 fechn = $("#nf").val()

 if (id =="" || desc =="" || canti=="" || fechn == "" ){
alert("no deje campos vacios")
 } 
 else {
  $.ajax({
    url: "scripts/asp/admin_ResumenCaja.asp",
    cache:false,
    dataType:"json",
    data: {comm:"modificar_trans", 
            idReg:id,
            txtFechatrans:fechn,
            txtTrans1: desc,
            txtCantidad: canti
          },
    method: "POST"
  }).done(function(rest){
    $.each(rest.data, function (i, item) {
     if (item.ok=="ok") {
      
      alert("Modificación realizada correctamente")
        $("#mdModifica").modal("hide")
        $('#tablaTransaccionesCaja').DataTable().ajax.reload();
        consultaporFecha()    

      }
     })
     console.log(rest);
  }).fail(function(jqXHR,estado,error){
    console.log(estado);
    console.log(error);
  }) 

 }

}