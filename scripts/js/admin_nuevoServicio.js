	//llena lista de los tipos de servicios
	$.ajax({
	    url:"scripts/asp/admin_capturarTipoServicio.asp",
	    cache: false,
	    data: {comm:"tipoServicios"},
	    dataType: "json",
	    method: "POST"
	}).done(function(rest){
	    
	   $.each(rest.data, function (i, item) {
		    $('#optTipoServicio').append(new Option(item.tipoServicio, item.id));
	   });
	})


