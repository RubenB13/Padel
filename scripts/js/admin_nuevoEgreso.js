function guardarEgresos(){
    //cliente = $("#optCliente option:selected").text();
    //console.log(cliente)
  //  total_Ingreso = $("15").text()
    info = $("#frmEgresos").serialize()
    info =  info + "&comm=nuevoEgreso&idReg=0"
    console.log(info)
    $.ajax({
    url: "scripts/asp/admin_guardaEgreso.asp",
    cache:false,
    dataType:"json",
    data: info,
    method: "POST"
  }).done(function(rest){
     $.each(rest.data, function (i, item) {
      if (item.ok=="ok") {
        $("#frmEgresos").get(0).reset();
        $("#txtEgTotal").text("")
        // $('#tblAgenda').DataTable().ajax.reload();
        alert("Se guardo correctamente")
      }
     })
  }).fail(function(jqXHR,estado,error){
    console.log(estado);
    console.log(error);
  })
}

function multiEgresos(){
  costo_unitario = $("#txtEgCosto").val()
  cantidad = $("#txtEgConceptoTotal").val()
  egreso_total = costo_unitario * cantidad ;
//  resultado = "$ " + egreso_total
  document.getElementById('txtEgTotal').value = egreso_total

}
