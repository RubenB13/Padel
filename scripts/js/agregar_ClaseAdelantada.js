


verPagosAdelantados()

function verPagosAdelantados(){


  $('#tblTomaClasesAdelantadas').dataTable({
    destroy: true,
    retrieve: true,
    responsive: true,
    ajax: 'scripts/asp/agrega_clase_tomada.asp?com=verPagosAdelantados',
    processing: true,
    type: 'POST',
      "oLanguage": {
  "sUrl": "../../libs/datatables/tableLanguaje.txt"
  },
    columns: [
      { data: "id", visible:false},
      { data: "nombre"},
      { data: "fecha"},
      { data: "clases"},
      { data: "tomadas"},
      { data: "restan"},
      { data: "pago"},
      { data: "resta"},
      { data: "tipo"},
      { data: "profe"},
      { data: "info"},
      { data: "accion"}
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
$('#tblTomaClasesAdelantadas').DataTable().destroy()

  $('#tblTomaClasesAdelantadas').dataTable({
    destroy: true,
    retrieve: true,
    responsive: true,
    ajax: 'scripts/asp/agrega_clase_tomada.asp?com=consultaFecha&de='+desde+'&a='+hasta,
    processing: true,
    type: 'POST',
      "oLanguage": {
  "sUrl": "../../libs/datatables/tableLanguaje.txt"
  },
    columns: [
      { data: "id", visible:false},
      { data: "nombre"},
      { data: "fecha"},
      { data: "clases"},
      { data: "tomadas"},
      { data: "restan"},
      { data: "pago"},
      { data: "resta"},
      { data: "tipo"},
      { data: "profe"},
      { data: "info"},
      { data: "accion"}
       ],
       order: [[0, 'desc']],
  });

}
}




function reiniciaTabla() {

$("#tblusuariosPagosAd").DataTable().destroy()
$("#tblTomaClasesAdelantadas").DataTable().destroy()
$("#tblusuariosPagosAd2").DataTable().destroy()
verPagosAdelantados()

}


var idRegistroClase

function agregamosClase(id,nombre, idRegi){
  idRegistroClase = idRegi
  console.log(idRegistroClase)

 $.ajax({
  url:"scripts/asp/agrega_clase_tomada.asp",
  cache: false,
  data: {comm:"verClasesRestantes",iduser:id, idReg:idRegi},
  dataType: "json",
  method: "POST"
}).done(function(rest){
    $.each(rest.data,  function(i,item) {
      if (item.ok == "ok") {
        $("#ClasesRestan").val(item.resta)

        a = parseInt(item.resta)
        if(a<=0){
          console.log("no quedan clases")
        document.getElementById("agregarClase").style.display = "none"
        document.getElementById("sinClases").style.display = "inline"
        $("#agregaClase").modal("show")
        }
        else if (a>0) {
          console.log("quedan clases")
          document.getElementById("agregarClase").style.display = "inline"
          document.getElementById("sinClases").style.display = "none"
          $("#agregaClase").modal("show")
        }
      }else {
        alert("Hubo un error, consulte con administracion")
      }
    });

  })  

$("#idUser2").val(id)
$("#nombreUser").val(nombre)

}


function agregaClase() {

id =  $("#idUser2").val()  
fuso = $("#fechaUso").val()


console.log(id)
console.log(fuso)
console.log(idRegistroClase)

if(fuso =="") {
  alert("coloque una fecha Correcta")
}

else {
$.ajax({
  url:"scripts/asp/agrega_clase_tomada.asp",
  cache: false,
  data: {comm:"agregaClaseAd",
              iduser:id,
               fechas:fuso,
               idControlPagos: idRegistroClase
             },
  dataType: "json",
  method: "POST"
}).done(function(rest){
    $.each(rest.data,  function(i,item) {
      if (item.ok == "ok") {
        alert("clase Agregada Correctamente")
        $("#agregaClase").modal("hide")
        a = item.usuario
        actualizaTabla(a)
        
      }else {
        alert("Hubo un error, consulte con administracion")
      }
    });

  })  

}
}


function actualizaTabla(a){
  $.ajax({
    url:"scripts/asp/agrega_clase_tomada.asp",
    cache: false,
    data: {comm:"actualizaClases",
                iduser:a,
                 fechas:fuso,
                 idReg: idRegistroClase
               },
    dataType: "json",
    method: "POST"
  }).done(function(rest){
      $.each(rest.data,  function(i,item) {
        if (item.ok == "ok") {
          reiniciaTabla()
          
        }else {
          alert("Hubo un error, consulte con administracion")
        }
      });
  
    })  

}


function verInfo(id,nombre, idRegi) {

 $("#user").val(id)
 $("#usuario").val(nombre)


 $("#infoClasesTomadas").modal("show")

 $("#tblusuariosPagosAd2").DataTable().destroy()
 $('#tblusuariosPagosAd2').dataTable({
  destroy: true,
  retrieve: true,
  responsive: true,
  ajax: 'scripts/asp/agrega_clase_tomada.asp?com=listaClasesTomadas&id_ControlPagos='+idRegi,
  processing: true,
  type: 'POST',
    "oLanguage": {
"sUrl": "../../libs/datatables/tableLanguaje.txt"
},
  columns: [
    { data: "id", visible:false},
    { data: "fecha"},
    { data: "accion"}
     ],
     order: [[0, 'desc']],
});
 
 }

 
 inciatabla()

 function inciatabla() {
   id = 0
 $('#tblusuariosPagosAd2').dataTable({
  destroy: true,
  retrieve: true,
  responsive: true,
  ajax: 'scripts/asp/agrega_clase_tomada.asp?com=listaClasesTomadas&id_ControlPagos='+id,
  processing: true,
  type: 'POST',
    "oLanguage": {
"sUrl": "../../libs/datatables/tableLanguaje.txt"
},
  columns: [
    { data: "id", visible:false},
    { data: "fecha"},
    { data: "accion"}
     ],
     order: [[0, 'desc']],
});


 }


 function borrarClase(id) {
  
  $("#modalBorrarclase").modal("show")
  $("#ids").val(id)

 }


 function borraClase() {
id =   $("#ids").val()
a =   $("#user").val()


$.ajax({
  url:"scripts/asp/agrega_clase_tomada.asp",
  cache: false,
  data: {comm:"borrarClase",
              iduser:id,
              },
  dataType: "json",
  method: "POST"
}).done(function(rest){
    $.each(rest.data,  function(i,item) {
      if (item.ok == "ok") {
        actualizaTabla(a)
        alert("clase Borrada Correctamente")
        $("#infoClasesTomadas").modal("hide")
        $("#modalBorrarclase").modal("hide")
        }else {
        alert("Hubo un error, consulte con administracion")
      }
    });

  })  

 
 }