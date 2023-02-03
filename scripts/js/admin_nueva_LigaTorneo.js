

buscaLigasyTorneos()

function buscaLigasyTorneos(){
  fechaInicial = $("#date_from").val()
  fechaFin = $("#date_to").val()
  console.log(fechaInicial + "  -  " + fechaFin)

    $('#tblListadoLigas').dataTable({
    destroy: true,
    retrieve: true,
    responsive: true,
    ajax: 'scripts/asp/admin_nueva_LigaTorneo.asp?com=listarTorneos&de='+fechaInicial+'&a='+fechaFin,
    processing: true,
    type: 'POST',
      "oLanguage": {
  "sUrl": "../../libs/datatables/tableLanguaje.txt"
  },
    columns: [
      { data: "id", visible: false},
      { data: "datos_torneo"}
    ],
     order:[[0,"desc"]],
  });
}


$("#btnNuevaLigaTorneo").click(function(){
  $("#divNuevoTorneo").show()
  $("#divListadoTorneos").hide()
})

$("#btnRegresarListadoTorneos").click(function(){
  $("#divNuevoTorneo").hide()
  $("#divListadoTorneos").show()
})



$("#btnGuardarTorneo").click(function(e){
    e.preventDefault()
    e.stopImmediatePropagation()
      //cliente = $("#optCliente option:selected").text();
      //console.log(cliente)
    info = $("#frmNuevoTorneo").serialize()
    info =  info + "&comm=nuevoTorneo"
    console.log(info) 
    $.ajax({
      url: "scripts/asp/admin_nueva_LigaTorneo.asp",
      cache:false,
      dataType:"json",
      data: info,
      method: "POST"
    }).done(function(rest){
       $.each(rest.data, function (i, item) {
        if (item.ok=="ok") {
          alert("Se guardo correctamente")
          $("#divNuevoTorneo").hide()
          $("#divListadoTorneos").show()
          $('#tblListadoLigas').DataTable().ajax.reload();
        }else if (item.ok =='ok1') {
          alert("Se actualizo correctamente")
          $('#tblListadoLigas').DataTable().ajax.reload();
          $("#divNuevoTorneo").hide()
          $("#divListadoTorneos").show()
        }

        $("#frmNuevoTorneo").get(0).reset();
                
       })
    }).fail(function(jqXHR,estado,error){
      console.log(estado);
      console.log(error);
    })
  })
