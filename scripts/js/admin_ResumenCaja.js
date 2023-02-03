

  var fechaInicial, fechaFin

  var DiaActual= new Date();
  fechaFormato = DiaActual.getFullYear() + "/" +(DiaActual.getMonth() + 1) + "/" + DiaActual.getDate()
  console.log('imprimir fecha funcion '+fechaFormato);

  function tablaResumen(){
    fechaInicial = $("#date_from").val()
    fechaFin = $("#date_to").val()
    console.log(fechaInicial + "  -  " + fechaFin)

    $('#tblResCaja').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/admin_ResumenCaja.asp?com=ConsultaCaja&de='+fechaInicial+'&a='+fechaFin,
      processing: true,
      type: 'POST',
        "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
    },
      columns: [
        { data: "Concepto"},
        { data: "Total_de_Entrada"},
        { data: "Total_de_Salida"},
        { data: "Balance_en_caja"}
         ]
    });
 
    

  }

  function CasillaMesCaja(){
    fechaInicial = $("#date_from").val()
    fechaFin = $("#date_to").val()
  
     $.ajax({
         url:'scripts/asp/admin_ResumenCaja.asp?com=ConsultaCaja&de='+fechaInicial+'&a='+fechaFin,
         method: "POST",
         cache: false,
           dataType: "json"
     }).done(function(rest){
        $.each(rest.data, function (i, item) {
          if(item.ok == 'ok'){
            $("#EstCaja").text(item.Balance_en_caja)
          }else{
            $("#EstCaja").text("Sin Resultados")
          }
        })
  
  
     })
    
  }
  
  function CasillaMesCajaAnt(){
    fechaInicial = $("#date_from").val()
    fechaFin = $("#date_to").val()
  
     $.ajax({
         url:'scripts/asp/admin_ResumenCaja.asp?com=ConsultaAnt&de='+fechaInicial+'&a='+fechaFin,
         method: "POST",
         cache: false,
           dataType: "json"
     }).done(function(rest){
        $.each(rest.data, function (i, item) {
          if(item.ok == 'ok'){
            $("#CorteAnterior").text(item.balance_anterior)
          }else{
            $("#CorteAnterior").text("Sin resultados")
          }
        })
  
  
     })
    
  }

    //agrego nuevos datos en tabla nueva 
  function Tabla2(){ 
    fechaInicial = $("#date_from").val()
    fechaFin = $("#date_to").val()
  

     $('#tblTransCaja').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/admin_ResumenCaja.asp?com=datosCajas&de='+fechaInicial+'&a='+fechaFin,
      processing: true,
      type: 'POST',
        "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
    },
      columns: [
        { data: "Concepto"},
        { data: "Pago de servicios"},
        { data: "Pago Parciales"},
        { data: "Pagos Adelantados"},
        { data: "Ventas"},
        { data: "Otros"}
      ]
    });
  }

  function HistorialCaja(){ 
    fechaInicial = $("#date_from").val()
    fechaFin = $("#date_to").val()
  

     $('#tblHistCaja').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/admin_ResumenCaja.asp?com=ConsultarHistoriaCaja&de='+fechaInicial+'&a='+fechaFin,
      processing: true,
      type: 'POST',
        "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
    },
      columns: [
        { data: "Id"},
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

  var idRegistroEliminar
  var idModificar

  // function eliminarAgenda(IdReg){
  //   // if(confirm("¿Seguro desea borrar esta reservación?")){
  //     $("#txtClave").val("")
  //     $('#modalEliminarRegistro').modal({backdrop: 'static',keyboard: false})
  //     $("#modalEliminarRegistro").modal("show")
  //     idRegistroEliminar = IdReg
  //     console.log(idRegistroEliminar)
  //   // }
  // }
  
  var Clave

  // //BUSCAMOS PRIMERO SI EXISTE EL USUARIO CON ESA CLAVE PARA ELIMINAR
  // $("#btnEliminarRegistro").click(function(e){
  //     e.preventDefault()
  //     e.stopImmediatePropagation()

  //     Clave = $("#txtClave").val()
  //     if (Clave != "") {
  //       $.ajax({
  //          url:"scripts/asp/admin_ResumenCaja.asp",
  //          method: "POST",
  //          cache: false,
  //          data: {idReg:Clave,comm:'buscaUsuarioParaEliminarRegistro'},
  //          dataType: "json"
  //       }).done(function(rest){
  //         $.each(rest.data, function (i, item) {
  //           if(item.ok == 'ok'){
  //             borrarRegistro()
  //             $("#txtClave").val("")
  //           }else{
  //             alert("Clave incorrecta")
  //             $("#modalEliminarRegistro").modal("hide")            
  //             $("#txtClave").val("")
  //           } 
  //         })
  //       })     
  //     }else{
  //       alert("Debe agregar una clave...")
  //     }
      
  // })


  function borrarRegistro(idrr){

idRegistroEliminar = idrr

if(confirm("¿Desea eliminar Registro?")){
    $.ajax({
       url:"scripts/asp/admin_ResumenCaja.asp",
       method: "POST",
       cache: false,
       data: {idReg:idRegistroEliminar,comm:'eliminar_trans'},
       dataType: "json"
    }).done(function(rest){
      console.log(rest)
      $.each(rest.data, function (i, item) {
        if(item.ok == 'ok'){
          alert("Se elimino correctamente...")
          $('#tblHistCaja').DataTable().ajax.reload();
          $('#tblResCaja').DataTable().ajax.reload();
          $('#tblTransCaja').DataTable().ajax.reload();
          CasillaMesCaja()
          CasillaMesCajaAnt()
          $("#modalEliminarRegistro").modal("hide")                   
          
        }else{
          alert("No se borro el registro, consulte al administrador del sistema")
          $("#loading").hide();
          $("#modalEliminarRegistro").modal("hide")
        } 
      })
    })
  }
}

//mostrar modal de contraseña para modificar

function claveModificar(IdReg){
  // if(confirm("¿Seguro desea borrar esta reservación?")){
    $("#txtClave1").val("")
    $('#modaModificarTrans').modal({backdrop: 'static',keyboard: false})
    $("#modaModificarTrans").modal("show")
    idModificar = IdReg
    console.log(idModificar)
  // }
}


//busco clave para modificar
  //BUSCAMOS PRIMERO SI EXISTE EL USUARIO CON ESA CLAVE PARA ELIMINAR
  $("#btnModificar").click(function(e){
    e.preventDefault()
    e.stopImmediatePropagation()
  
    Clave = $("#txtClave1").val()
    if (Clave != "") {
      $.ajax({
         url:"scripts/asp/admin_ResumenCaja.asp",
         method: "POST",
         cache: false,
         data: {idReg:Clave,comm:'buscaUsuarioParaEliminarRegistro'},
         dataType: "json"
      }).done(function(rest){
        $.each(rest.data, function (i, item) {
          if(item.ok == 'ok'){
            verTransModificar(idModificar)
            $("#txtClave1").val("")
            $("#modaModificarTrans").modal("hide")  
          }else{
            alert("Clave incorrecta")
           $("#txtClave1").val("")
          } 
        })
      })     
    }else{
      alert("Debe agregar una clave...")
    }
    
})

//modal ver informacion de transaccion
function verTransModificar(idModificar){
  
  console.log("Modifica item:")
  console.log(idModificar)

  if (idModificar > 0) {
		 
    $.ajax({
       url:"scripts/asp/admin_ResumenCaja.asp",
       method: "POST",
       cache: false,
       data: {idReg:idModificar,comm:'verTrans'},
       dataType: "json"
   }).done(function(rest){
      
      $.each(rest.data, function (i, item) {
      
        if(item.ok == 'ok'){
          console.log("Encontré")
          $("#txtId").val(item.Id)
          $("#txtTrans1").val(item.Descripcion)
          $("#TipoTrans").val(item.Tipo)
          $("#clasTrans").val(item.Clasificacion)
          $("#txtFechatrans").val(item.Fecha)
          $("#txtResponsable").val(item.Responsable)
          $("#txtCantidad").val(item.Cantidad)
               
          $('#modalModificaTrans').modal({backdrop: 'static',keyboard: false})
          $("#modalModificaTrans").modal("show")
        
        }else{
          alert("Ocurrio un problema, consulte al administrador del sistema")
          console.log("no se encontró nada")
        } 
      })
    })
 }
}

// FIN  de ver info

//programa para modificar 

$("#btnModifica").click(function(e){
  e.preventDefault()
  e.stopImmediatePropagation()
  console.log("Entró botón modificar")
  info = $("#frmTransCajaModifica").serialize()
  info =  info + "&comm=modificar_trans&idReg="+idModificar

  console.log(info)
  console.log(idModificar)
  $.ajax({
    url:"scripts/asp/admin_ResumenCaja.asp",
    method: "POST",
    cache: false,
    data:info,
    dataType: "json"
 }).done(function(rest){
   console.log(rest)
   $.each(rest.data, function (i, item) {
     if(item.ok == 'ok'){
       alert("Se Modificó correctamente...")
      $('#tblHistCaja').DataTable().ajax.reload();
      $('#tblResCaja').DataTable().ajax.reload();
      $('#tblTransCaja').DataTable().ajax.reload();
      CasillaMesCaja()
      CasillaMesCajaAnt()
      $("#modalModificaTrans").modal("hide")                   
       
     }else{
       alert("No se borro el registro, consulte al administrador del sistema")
       $("#loading").hide();
       $("#modalModificaTrans").modal("hide")
     } 
   })
 })
  
})

//fin de boton para modificar

  $(".buscarAdmin").click(function(){
    CasillaMesCaja()
    CasillaMesCajaAnt()
    console.log("entro buscar por fecha")
    $('#tblResCaja').DataTable().destroy();
    $('#tblTransCaja').DataTable().destroy();
    $('#tblHistCaja').DataTable().destroy();
    tablaResumen()
    Tabla2()
    HistorialCaja()
    

    
  })
