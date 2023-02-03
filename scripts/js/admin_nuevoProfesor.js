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


	var htmlProfesores = ""

	$("#btnNuevoProfesor").click(function(){
		verProfesor()
	})

	function verProfesor(){
		htmlProfesores =""

		$.ajax({
		    url:"scripts/asp/admin_capturarProfesor.asp",
		    cache: false,
		    data: {comm:"listaProfesores"},
		    dataType: "json",
		    method: "POST"
		}).done(function(rest){
		    
		   $.each(rest.data, function (i, item) {
			    if (item.ok == 'ok'){
		            htmlProfesores += '<tr><td>'+item.id+'</td><td>'+item.nombre+'</td><td>'+item.telefono+'</td><td>'+item.accion+'</td></tr>'
		        }
		   });
		    $("#tblProfesores tbody").html(htmlProfesores)
      		$('#modalNuevoProfesor').modal({backdrop: 'static',keyboard: false})
     		$("#modalNuevoProfesor").modal("show")
		})		
	}



function actualizarProfesor(idRegis){
    $("#idReg").val(idRegis)

    $.ajax({
       url:"scripts/asp/admin_capturarProfesor.asp",
       method: "POST",
       cache: false,
       data: {comm:"get", idReg: idRegis},
       dataType:"json"
    }).done(function(rest){
      
      	 $.each(rest.data, function (i, item) {
      	 	if (item.ok = "ok") {
      	 		$("#idReg").val(item.id)
          		$("#txtNombreProfesor").val(item.nombre)
          		$("#txtTelefono").val(item.telefono) 
          		$("#btnGuardarProfesor").text("Actualizar")
      	 	}else{
        		alert("Ocurrio un problema, consulte al administrador del sistema")
       		}
      	 })       
    })
  }


  function guardarProfesor(){
    IDRegistro = $("#idReg").val()

    info = $("#frmProfesor").serialize()
    info =  info + "&comm=save"
    console.log(info)

    $.ajax({
       url:"scripts/asp/admin_capturarProfesor.asp",
       method: "POST",
       cache: false,
       data: info,
       dataType: "json"
    }).done(function(rest){
      
       	$.each(rest.data, function (i, item) {
       		if (item.ok = "ok") {
       			if(IDRegistro > 0){
	                alert("Se actualizo correctamente")
	                limpiaFormularioProfesor()
	                verProfesor()
	                $("#btnGuardarProfesor").text("Guardar")
	            }else{
	                alert("Se registro correctamente")
	                limpiaFormularioProfesor()
	                verProfesor()               
	            }	
       		}else{
       			alert("no se guardo, favor de comunicarse con el administrador del sistema")
       		}
       		
       	})      	
    })
  }

  function limpiaFormularioProfesor(){
    $("#txtNombreProfesor").val("") 
    $("#txtTelefono").val("")
    $("#idReg").val(0)
  }


  function eliminarProfesor(idRegis){
   	if (confirm("¿Deseas eliminar este resgistro?")) {
   		$.ajax({
	       url:"scripts/asp/admin_capturarProfesor.asp",
	       method: "POST",
	       cache: false,
	       data: {comm:"eliminar", idReg: idRegis},
	       dataType:"json"
	    }).done(function(rest){
	      
	      	$.each(rest.data, function (i, item) {
	      	 	if (item.ok = "ok") {
	      	 		verProfesor()
	      	 		// alert("Profesor eliminado correctamente")
	      	 	}else{
	        		alert("Ocurrio un problema, consulte al administrador del sistema")
	       		}
	      	})       
	    })	
   	}
    
  }


  $("#btnCerrarModalProfesores").click(function(){
  	limpiaFormularioProfesor()
  	$("#btnGuardarProfesor").text("Guardar")
  })