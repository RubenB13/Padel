//Llamamos el nombre del usuario logeado
	function buscaUsuarioRegistrado(iduser){
    
    $.ajax({
      url: "scripts/asp/admin_consultaUsuarios.asp",
      cache:false,
      dataType:"json",
      data: {comm:"buscaUsuario", id:iduser},
      method: "POST"
    }).done(function(rest){
       $.each(rest.data, function (i, item) {
        if (item.ok=="ok") {
          $("#txtUsuario").text(item.nombre)
        }
       })
    })
  }