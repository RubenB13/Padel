


function guardaUserPA(){

  nombre = $("#PaNomb").val()
  
  $.ajax({
    url:"scripts/asp/admin_guardaUserpa.asp",
    cache: false,
    data: {comm:"guardarUserPa",nomb:nombre},
    dataType: "json",
    method: "POST"
  }).done(function(rest){
      $.each(rest.data,  function(i,item) {
        if (item.ok == "ok") {
          $("#PaNomb").val("")
          alert("Registrado Correcamente")
          ReiniciarTablas()
        }else {
          alert("Hubo un error, consulte con administracion")
        }
      });

    })  


}


listaUsuarios()

function listaUsuarios(){


  $('#tblusuariosPagosAd').dataTable({
    destroy: true,
    retrieve: true,
    responsive: true,
    ajax: 'scripts/asp/admin_guardaUserpa.asp?com=verUsuarios',
    processing: true,
    type: 'POST',
      "oLanguage": {
  "sUrl": "../../libs/datatables/tableLanguaje.txt"
  },
    columns: [
      { data: "id", visible:false},
      { data: "nombre"},
      { data: "fecha"},
      { data: "accion"}
       ],
       order: [[0, 'desc']],
  });

  

}


function actualizarUser(id) {


$("#mdModifica").modal("show")
$("#iduser").val(id)


}



function borrarUser(id) {

  $.ajax({
    url:"scripts/asp/admin_guardaUserpa.asp",
    cache: false,
    data: {comm:"borrarUser",iduser:id},
    dataType: "json",
    method: "POST"
  }).done(function(rest){
      $.each(rest.data,  function(i,item) {
        if (item.ok == "ok") {
          alert("Se eliminó correctamente")
          ReiniciarTablas()
        }else {
          alert("Hubo un error, consulte con administracion")
        }
      });

    })  
 
  

}



function ReiniciarTablas(){

  $('#tblusuariosPagosAd').DataTable().destroy()
  listaUsuarios()

}

function  modificaUser(){

  id = $("#iduser").val()
  nombre = $("#PaNomb2").val()
  
if (nombre =="") {
 
  alert("llene el campo correctamente")

}

  $.ajax({
    url:"scripts/asp/admin_guardaUserpa.asp",
    cache: false,
    data: {
         comm:"modificarUser",
         iduser:id,
         nomb:nombre},
    dataType: "json",
    method: "POST"
  }).done(function(rest){
      $.each(rest.data,  function(i,item) {
        if (item.ok == "ok") {
          $("#mdModifica").modal("hide")
          alert("Se actualizó correctamente")
          ReiniciarTablas()
        }else {
          alert("Hubo un error, consulte con administracion")
        }
      });

    })  
 

}