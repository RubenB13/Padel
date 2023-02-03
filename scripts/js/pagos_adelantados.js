//llena lista de profesores
$.ajax({
  url:"scripts/asp/admin_capturarProfesor.asp",
  cache: false,
  data: {comm:"profesores"},
  dataType: "json",
  method: "POST"
}).done(function(rest){
  
 $.each(rest.data, function (i, item) {
    $('#optProfesor').append(new Option(item.nombre, item.id));
 });
})

	//llena lista de los tipos de servicios
	$.ajax({
    url:"scripts/asp/admin_capturarTipoServicio.asp",
    cache: false,
    data: {comm:"tipoServiciosPa"},
    dataType: "json",
    method: "POST"
}).done(function(rest){
    
   $.each(rest.data, function (i, item) {
      $('#optTipoServicio').append(new Option(item.tipoServicio, item.id));
   });
})



function verListaUsuarios(){


  $('#tblusuariosPagosAd2').dataTable({
    destroy: true,
    retrieve: true,
    responsive: true,
    ajax: 'scripts/asp/pagos_adelantados.asp?com=verUsuarios',
    processing: true,
    type: 'POST',
      "oLanguage": {
  "sUrl": "../../libs/datatables/tableLanguaje.txt"
  },
    columns: [
      { data: "id", visible:false},
      { data: "nombre"},
      { data: "accion"}
       ],
       order: [[0, 'desc']],
  });

  $("#ModalUsuariospa").modal("show")

}


function agregaUsuariopa(id, nombre) {

  $("#ModalUsuariospa").modal("hide")

document.getElementById("NuevoUser").style.display = "none"
document.getElementById("cambiaUsuario").style.display = "inline"
document.getElementById("formularioAgregarPago").style.display = "inline"


  $("#iduser").val(id)
  $("#PaNomb2").val(nombre)


}

function obtienecosto() {

a = $("#optTipoServicio").val()
b = $("#nuper").val()

$.ajax({
  url:"scripts/asp/pagos_adelantados.asp",
  cache: false,
  data: {comm:"calculocostounitarioPa",idservicio:a},
  dataType: "json",
  method: "POST"
}).done(function(rest){
    $.each(rest.data,  function(i,item) {
      if (item.ok == "ok") {
        if(b==1) { 
        $("#cstservice").val(item.costo1)
        }
        else if(b==2) { 
        $("#cstservice").val(item.costo2)
        }
       else if(b==3) { 
        $("#cstservice").val(item.costo3)
        }
        else if(b==4) { 
        $("#cstservice").val(item.costo4)
        }
        calculaCosto()
      }else {
        alert("Hubo un error, consulte con administracion")
      }
    });

  })  


}

// const selector = document.getElementById('optTipoServicio');
// selector.addEventListener('change', (event) => {
  
//   calculaCosto();
// });


function calculaCosto () {

  tipoclase = $("#cstservice").val()
  totalclases = $("#ttclases").val()


  totalaPagar = tipoclase*totalclases

  $("#ttpago").val(totalaPagar)


}


function GuardarPago() {

id =   $("#iduser").val() 
tserv =    $("#optTipoServicio").val()
profe =    $("#optProfesor").val()
tclases =  $("#ttclases").val()
tpago =    $("#ttpago").val()
fechap =    $("#fpago").val()
numper =  $("#nuper").val()


if (tserv =="" || tserv ==0 || tclases=="" || tclases==0 || tpago =="" || tpago ==0 || fechap =="" || numper==0) {
  alert("llene todos los campos por favor!")
}

else if (profe =="" || profe ==0) {
  alert("Seleccione un profesor por favor")
}
else if (fechap =="") {

  alert("Selecciona una fecha correcta")

}
else {
$.ajax({
  url:"scripts/asp/pagos_adelantados.asp",
  cache: false,
  data: {comm:"guardaPagoAdelantado",
       iduser:id,
       idservicio: tserv,
       prof:profe,
       tcl:tclases,
       tpg:tpago,
       tpr:tpago,
       fdate:fechap,
       nump:numper
        },
  dataType: "json",
  method: "POST"
}).done(function(rest){
    $.each(rest.data,  function(i,item) {
      if (item.ok == "ok") {

      alert("pago adelantado Guardado correctamente")
      reiniciaTabla()
      $("#formularioAgregarPago").get(0).reset()
      document.getElementById("NuevoUser").style.display = "inline"
      document.getElementById("cambiaUsuario").style.display = "none" 
      document.getElementById("formularioAgregarPago").style.display = "none"
  


      }else {
        alert("Hubo un error, consulte con administracion")
      }
    });

  }) 

}
}


verPagosAdelantados()

function verPagosAdelantados(){


  $('#tblusuariosPagosAd').dataTable({
    destroy: true,
    retrieve: true,
    responsive: true,
    ajax: 'scripts/asp/pagos_adelantados.asp?com=verPagosAdelantados',
    processing: true,
    type: 'POST',
      "oLanguage": {
  "sUrl": "../../libs/datatables/tableLanguaje.txt"
  },
    columns: [
      { data: "id", visible:false},
      { data: "nombre"},
      { data: "numper"},
      { data: "fecha"},
      { data: "clases"},
      { data: "pago"},
      { data: "tipo"},
      { data: "profe"},
      { data: "accion"}
       ],
       order: [[0, 'desc']],
  });


}


todospagosadelantados()

function todospagosadelantados(){


  $('#todospagosadelantados').dataTable({
    destroy: true,
    retrieve: true,
    responsive: true,
    ajax: 'scripts/asp/pagos_adelantados.asp?com=verTodosPagosAdelantados',
    processing: true,
    type: 'POST',
      "oLanguage": {
  "sUrl": "../../libs/datatables/tableLanguaje.txt"
  },
    columns: [
      { data: "id", visible:false},
      { data: "nombre"},
      { data: "numper"},
      { data: "fecha"},
      { data: "clases"},
      { data: "pago"},
      { data: "tipo"},
      { data: "profe"},
      { data: "accion"}
       ],
       order: [[0, 'desc']],
  });


}

 
function cancelaPago () {


  $("#formularioAgregarPago").get(0).reset()
  document.getElementById("NuevoUser").style.display = "inline"
  document.getElementById("cambiaUsuario").style.display = "none" 
  document.getElementById("formularioAgregarPago").style.display = "none"
}


function borrarPagoAdelantado(id) {
 
  $("#modalBorrarPago").modal("show")
  $("#idUser2").val(id)


}

// abre modal para modificar 
function modalModificaInfo(id,f) {
 
  $("#modalModificaInfo").modal("show")
  $("#idmodifica").val(id)
  $("#fechaAnt").val(f)
document.getElementById('newf').value = ""


}


 function modificarPago(){
  id =$("#idmodifica").val()
  x = $("#newf").val()

if (x ==0 || x =="") {
    alert("Llena correctamente el campo")
  
 }
 else {
  $.ajax({
    url:"scripts/asp/pagos_adelantados.asp",
    cache: false,
    data: {comm:"modificaPago",
         iduser:id,
         nf:x
          },
    dataType: "json",
    method: "POST"
  }).done(function(rest){
      $.each(rest.data,  function(i,item) {
        if (item.ok == "ok") {
  
        alert("Modificado Correctamente")
        $("#modalModificaInfo").modal("hide")
        document.getElementById("NuevoUser").style.display = "inline"
        document.getElementById("cambiaUsuario").style.display = "none" 
        document.getElementById("formularioAgregarPago").style.display = "none"

        reiniciaTabla()
    
  
  
        }else {
          alert("Hubo un error, consulte con administracion")
        }
      });
  
    }) 
 }

}

function borrarPago() { 

  id = $("#idUser2").val()

  $.ajax({
    url:"scripts/asp/pagos_adelantados.asp",
    cache: false,
    data: {comm:"borraPagoAdelantado",
         iduser:id
          },
    dataType: "json",
    method: "POST"
  }).done(function(rest){
      $.each(rest.data,  function(i,item) {
        if (item.ok == "ok") {
  
        alert("Pago Borrado Correctamente")
        $("#modalBorrarPago").modal("hide")
        document.getElementById("NuevoUser").style.display = "inline"
        document.getElementById("cambiaUsuario").style.display = "none" 
        document.getElementById("formularioAgregarPago").style.display = "none"

        reiniciaTabla()
    
  
  
        }else {
          alert("Hubo un error, consulte con administracion")
        }
      });
  
    }) 

}


function reiniciaTabla() {

$("#tblusuariosPagosAd").DataTable().destroy()
$("#todospagosadelantados").DataTable().destroy()
verPagosAdelantados()
todospagosadelantados()

}
