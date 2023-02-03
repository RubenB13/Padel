
var idRegistro

verMesActual()


function verMesActual() { 

  const date = new Date(); 
  const month = date.toLocaleString('default', { month: 'long' });

  $("#tituloTabla").text("Mes Actual: "+month)

}

function guardaTransBanco(){
    idRegistro = $("#idReg").val()
    info = $("#frmTransBanco").serialize()
    info =  info + "&comm=NuevaTransBanco&idReg="+idRegistro
    console.log(info)
    $.ajax({
      url: "scripts/asp/admin_guardaTransBanco.asp",
      cache:false,
      dataType:"json",
      data: info,
      method: "POST"
    }).done(function(rest){
      $.each(rest.data, function (i, item) {
       if (item.ok=="ok") {
         $("#frmTransBanco").get(0).reset();
         $('#tablaBanco').DataTable().ajax.reload();

         if ( idRegistro == 0 ) {
            alert("Transacción de banco guardada")  
         }else if ( idRegistro > 0 ) {
            alert("Transacción de banco actualizada")
            $("#idReg").val(0)
         }
        
        }
       })
       console.log(rest);
    }).fail(function(jqXHR,estado,error){
      console.log(estado);
      console.log(error);
    })
}


function listarHistorialBancoMes(){
  
  $('#tablaBanco').dataTable({
        destroy: true,
        retrieve: true,
        responsive: true,
        pageLenght:10,
        lengthMenu: [[10, 20, 30, -1], [10, 20, 30, 'Todos']],
        ajax: 'scripts/asp/admin_guardaTransBanco.asp?com=listarHistorialBancoMes',
        processing: true,
        type: 'POST',
          "oLanguage": {
      "sUrl": "../../libs/datatables/tableLanguaje.txt"
      },
        columns: [
          { data: "id", visible:false},
          { data: "descripcion"},
          { data: "tipo"},
          { data: "clasificacion"},
          { data: "tipo_transaccion"},
          { data: "fecha"},
          { data: "responsable"},
          { data: "monto"},
          { data: "accion"}
        ],
         order:[[0,"desc"]],
    });
}

function consultaporFecha(){

  de = $("#desde").val()
  a = $("#hasta").val()

  $('#tablaBancoConsultado').DataTable().destroy()

  $('#tablaBancoConsultado').dataTable({
        destroy: true,
        retrieve: true,
        responsive: true,
        pageLenght:10,
        lengthMenu: [[10, 20, 30, -1], [10, 20, 30, 'Todos']],
        ajax: 'scripts/asp/admin_guardaTransBanco.asp?com=listarHistorialBanco&de='+de+'&a='+a,
        processing: true,
        type: 'POST',
          "oLanguage": {
      "sUrl": "../../libs/datatables/tableLanguaje.txt"
      },
        columns: [
          { data: "id", visible:false},
          { data: "descripcion"},
          { data: "tipo"},
          { data: "clasificacion"},
          { data: "tipo_transaccion"},
          { data: "fecha"},
          { data: "responsable"},
          { data: "monto"},
          { data: "accion"}
        ],
         order:[[0,"desc"]],
    });
}

listarHistorialBancoMes()



function eliminarTransaccion(idTra){
  if (confirm("Esta acción elimanará el registro, ¿Estas seguro?")) {
    $.ajax({
      url: "scripts/asp/admin_guardaTransBanco.asp",
      cache:false,
      dataType:"json",
      data: {comm:"eliminarTransaccion", idReg:idTra},
      method: "POST"
    }).done(function(rest){
      $.each(rest.data, function (i, item) {
       if (item.ok=="ok") {
         // $("#frmTransBanco").get(0).reset();
         $('#tablaBanco').DataTable().ajax.reload();
         consultaporFecha()
        // alert("Transacción de banco eliminada")
        }
       })
       console.log(rest);
    }).fail(function(jqXHR,estado,error){
      console.log(estado);
      console.log(error);
    }) 
  }
  
}


function verTransaccion(idTra){
 
    $.ajax({
      url: "scripts/asp/admin_guardaTransBanco.asp",
      cache:false,
      dataType:"json",
      data: {comm:"verTransaccion", idReg:idTra},
      method: "POST"
    }).done(function(rest){
      $.each(rest.data, function (i, item) {
       if (item.ok=="ok") {
          $("#idReg").val(item.id)
          $("#txtTrans").val(item.descripcion)
          $("#TipoTrans").val(item.tipo)
          $("#clasTrans").val(item.clasificacion)
          $("#cboTipoTransaccion").val(item.tipo_transaccion)
          $("#txtFechatrans").val(item.fecha)
          $("#txtResponsable").val(item.responsable)
          $("#cantidad_trans").val(item.monto)
          // $("#frmTransBanco").get(0).reset();
          // $('#tablaBanco').DataTable().ajax.reload();
          // alert("Transacción de banco actualizada")
        }
       })
       console.log(rest);
    }).fail(function(jqXHR,estado,error){
      console.log(estado);
      console.log(error);
    }) 
  
  
}

function ModificarTransaccionCaja(idrr) {


  id = idrr
  $.ajax({
    url: "scripts/asp/admin_guardaTransBanco.asp",
    cache:false,
    dataType:"json",
    data: {comm:"verTransaccion", idReg:id},
    method: "POST"
  }).done(function(rest){
    $.each(rest.data, function (i, item) {
     if (item.ok=="ok") {
      
        $("#mdModifica").modal("show")
        $("#idtrans").val(id)
        $("#descripAnt").val(item.descripcion)
        $("#cantidadAnt").val(item.monto)
        $("#fechaAnt").val(item.fecha)
      }
     })
     console.log(rest);
  }).fail(function(jqXHR,estado,error){
    console.log(estado);
    console.log(error);
  }) 
}


function modificaTransaccionBanco() {

  id= $("#idtrans").val()
  desc =  $("#nd").val()
  canti =  $("#nc").val()
  fechn = $("#nf").val()
 
  if (id =="" || desc =="" || canti=="" || fechn == "" ){
 alert("no deje campos vacios")
  } 
  else {
   $.ajax({
     url: "scripts/asp/admin_guardaTransBanco.asp",
     cache:false,
     dataType:"json",
     data: {comm:"modificartransbanco", 
             idReg:id,
             txtFechatrans:fechn,
             txtTrans: desc,
             cantidad_trans: canti
           },
     method: "POST"
   }).done(function(rest){
     $.each(rest.data, function (i, item) {
      if (item.ok=="ok") {
       
       alert("Modificación realizada correctamente")
         $("#mdModifica").modal("hide")
         $('#tablaBanco').DataTable().ajax.reload();
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





