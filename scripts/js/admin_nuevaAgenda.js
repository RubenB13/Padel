	

	function guardarAgenda(){
	  	//cliente = $("#optCliente option:selected").text();
	  	//console.log(cliente)
	  	precio_renta = $("#txtPrecioFinalTipoServicio").text()
	  	info = $("#frmAgenda").serialize()
	    info =  info + "&comm=nuevaAgenda&txtPrecioFinalTipoServicio="+precio_renta
	    console.log(info) 
	  	$.ajax({
			url: "scripts/asp/admin_capturarAgenda.asp",
			cache:false,
			dataType:"json",
			data: info,
			method: "POST"
		}).done(function(rest){
			 $.each(rest.data, function (i, item) {
			 	if (item.ok=="ok") {
			 		alert("Se agendo correctamente")
			 	}else if (item.ok =='ok1') {
			 		alert("Se actualizo correctamente")
			 		$("#modalReservacion").modal("hide")
			 		$('#tblIncidencias').DataTable().ajax.reload();
			 	}

		 		$("#frmAgenda").get(0).reset();
		 		$("#txtPrecioFinalTipoServicio").text("")
		 		
				
				$("#divDatosAcademia").hide()
				$("#divClasesAcademia").hide()
				$("#DivReservaciones1, #DivReservaciones2, #DivReservaciones3, #DivReservaciones4, #DivReservaciones5, #DivReservaciones6, #DivReservaciones7, #DivReservaciones8").hide()
				
			 })
		}).fail(function(jqXHR,estado,error){
			console.log(estado);
			console.log(error);
		})
	}

	function revisarHorario(){
		if ( $("#optTipoServicio").val() == 1 || $("#optTipoServicio").val() == 2 || $("#optTipoServicio").val() == 4 || $("#optTipoServicio").val() == 5 || $("#optTipoServicio").val() == 8 ) {
			console.log("entro verficar")
			$.ajax({
				url: "scripts/asp/admin_capturarAgenda.asp",
				cache:false,
				dataType:"json",
				data: {	comm: "verificarHorario", 
						txtFechaReservaC1: $("#txtFechaReservaC1").val(),
						optCanchaAsignada1: $("#optCanchaAsignada1").val(), 
						txthorarioInicioC1: $("#txthorarioInicioC1").val(), 
						txthorarioFinC1: $("#txthorarioFinC1").val(),
						idReg: $("#idReg").val()
					},
				method: "POST"
			}).done(function(rest){

				 $.each(rest.data, function (i, item) {
				 	if (item.ok=="ok") {
				 		guardarAgenda()
				 	}else{
						console.log("Encontro agendao para este dia: " +rest.data)
				 		alert("Horario no disponible para este día")
				 	}	
				 })
			}).fail(function(jqXHR,estado,error){
				console.log(estado);
				console.log(error);
			})

		}else if ($("#optTipoServicio").val() == 3) {
			//revisamos todos los dias para ver si no se empalma el horario
			$.ajax({
				url: "scripts/asp/admin_capturarAgenda.asp",
				cache:false,
				dataType:"json",
				data: {	comm: "verificarHorariosAcademia", 
						txtFechaReservaC1: $("#txtFechaReservaC1").val(),
						optCanchaAsignada1: $("#optCanchaAsignada1").val(), 
						txthorarioInicioC1: $("#txthorarioInicioC1").val(), 
						txthorarioFinC1: $("#txthorarioFinC1").val(),
						txtFechaReservaC2: $("#txtFechaReservaC2").val(),
						optCanchaAsignada2: $("#optCanchaAsignada2").val(), 
						txthorarioInicioC2: $("#txthorarioInicioC2").val(), 
						txthorarioFinC2: $("#txthorarioFinC2").val(),
						txtFechaReservaC3: $("#txtFechaReservaC3").val(),
						optCanchaAsignada3: $("#optCanchaAsignada3").val(), 
						txthorarioInicioC3: $("#txthorarioInicioC3").val(), 
						txthorarioFinC3: $("#txthorarioFinC3").val(),
						txtFechaReservaC4: $("#txtFechaReservaC4").val(),
						optCanchaAsignada4: $("#optCanchaAsignada4").val(), 
						txthorarioInicioC4: $("#txthorarioInicioC4").val(), 
						txthorarioFinC4: $("#txthorarioFinC4").val(),
						txtFechaReservaC5: $("#txtFechaReservaC5").val(),
						optCanchaAsignada5: $("#optCanchaAsignada5").val(), 
						txthorarioInicioC5: $("#txthorarioInicioC5").val(), 
						txthorarioFinC5: $("#txthorarioFinC5").val(),
						txtFechaReservaC6: $("#txtFechaReservaC6").val(),
						optCanchaAsignada6: $("#optCanchaAsignada6").val(), 
						txthorarioInicioC6: $("#txthorarioInicioC6").val(), 
						txthorarioFinC6: $("#txthorarioFinC6").val(),
						txtFechaReservaC7: $("#txtFechaReservaC7").val(),
						optCanchaAsignada7: $("#optCanchaAsignada7").val(), 
						txthorarioInicioC7: $("#txthorarioInicioC7").val(), 
						txthorarioFinC7: $("#txthorarioFinC7").val(),
						txtFechaReservaC8: $("#txtFechaReservaC8").val(),
						optCanchaAsignada8: $("#optCanchaAsignada8").val(),
						txthorarioInicioC8: $("#txthorarioInicioC8").val(), 
						txthorarioFinC8: $("#txthorarioFinC8").val(),
						idReg: $("#idReg").val()
					},
				method: "POST"
			}).done(function(rest){
				$("#nodisponibleClase1, #nodisponibleClase2, #nodisponibleClase3, #nodisponibleClase4, #nodisponibleClase5, #nodisponibleClase6, #nodisponibleClase7, #nodisponibleClase8").text("")
				$("#divNoDisponibleClase1, #divNoDisponibleClase2, #divNoDisponibleClase3, #divNoDisponibleClase4, #divNoDisponibleClase5, #divNoDisponibleClase6, #divNoDisponibleClase7, #divNoDisponibleClase8").hide()
				$.each(rest.data, function (i, item) {
				 	if (item.ok=="ok") {
				 		guardarAgenda()
				 	}else{
				 		
				 		alert("Horario no disponible, revisar fecha y hora...")
				 		if (item.clase == 1) {
				 			$("#divNoDisponibleClase1").show()
				 			$("#nodisponibleClase1").text("Revisar fecha y horario disponible para la clase no. 1")
				 		}else if (item.clase == 2) {
				 			$("#divNoDisponibleClase2").show()
				 			$("#nodisponibleClase2").text("Revisar fecha y horario disponible para la clase no. 2")
				 		}else if (item.clase == 3) {
				 			$("#divNoDisponibleClase3").show()
				 			$("#nodisponibleClase3").text("Revisar fecha y horario disponible para la clase no. 3")
				 		}else if (item.clase == 4) {
				 			$("#divNoDisponibleClase4").show()
				 			$("#nodisponibleClase4").text("Revisar fecha y horario disponible para la clase no. 4")
				 		}else if (item.clase == 5) {
				 			$("#divNoDisponibleClase5").show()
				 			$("#nodisponibleClase5").text("Revisar fecha y horario disponible para la clase no. 5")
				 		}else if (item.clase == 6) {
				 			$("#divNoDisponibleClase6").show()
				 			$("#nodisponibleClase6").text("Revisar fecha y horario disponible para la clase no. 6")
				 		}else if (item.clase == 7) {
				 			$("#divNoDisponibleClase7").show()
				 			$("#nodisponibleClase7").text("Revisar fecha y horario disponible para la clase no. 7")
				 		}else if (item.clase == 8) {
				 			$("#divNoDisponibleClase8").show()
				 			$("#nodisponibleClase8").text("Revisar fecha y horario disponible para la clase no. 8")
				 		}
				 	}	
				})
			}).fail(function(jqXHR,estado,error){
				console.log(estado);
				console.log(error);
			})
					
		}else if ( $("#optTipoServicio").val() == 6 || $("#optTipoServicio").val() == 7 ){
			// entramos a renta horario muerto y concurrido
			$.ajax({
				url: "scripts/asp/admin_capturarAgenda.asp",
				cache:false,
				dataType:"json",
				data: {	comm: "verificarHorario", 
						txtFechaReservaC1: $("#txtFechaReservaC1").val(),
						optCanchaAsignada1: $("#optCanchaAsignada1").val(), 
						txthorarioInicioC1: $("#txthorarioInicioC1").val(), 
						txthorarioFinC1: $("#txthorarioFinC1").val(),
						idReg: $("#idReg").val()
					},
				method: "POST"
			}).done(function(rest){

				 $.each(rest.data, function (i, item) {

				 	if (item.ok=="ok") {
				 		// si no existe horario ocupado, verifcamos que el horario que selecciono sea el correcto en horaioMuerto
				 		if ( $("#optTipoServicio").val() == 6 ) {
				 			verificaHorarioPermitido_HoraMuerta()
				 		}else if ( $("#optTipoServicio").val() == 7 ){
				 			// si no existe horario ocupado, verifcamos que el horario que selecciono sea el correcto en horaioConcurrido
				 			verificaHorarioPermitido_HoraConcurrida()
				 		}
				 		
				 	}else{
						console.log("Encontro agendado para este dia: " +rest.data)
				 		alert("Horario no disponible para este día")
				 	}	
				 })
			}).fail(function(jqXHR,estado,error){
				console.log(estado);
				console.log(error);
			})

			
		}
	}

	function verificaHorarioPermitido_HoraMuerta(){
		horaIniciaAgenda = $("#txthorarioInicioC1").val().split(":")
		horaFinAgenda = $("#txthorarioFinC1").val().split(":")

		minutosInicioAgenda = (parseInt(horaIniciaAgenda[0])*60) + parseInt(horaIniciaAgenda[1])
		minutosFinAgenda = (parseInt(horaFinAgenda[0])*60) + parseInt(horaFinAgenda[1])

		horaInicioBD = hora_inicio.split(":")
		horaFinBD = hora_fin.split(":")

		minutosInicioBD = (parseInt(horaInicioBD[0])*60) + parseInt(horaInicioBD[1])
		minutosFinBD = (parseInt(horaFinBD[0])*60) + parseInt(horaFinBD[1])

		// console.log("hi: "+minutosInicioAgenda+" hf: "+minutosFinAgenda)
		// console.log("hiBD: "+minutosInicioBD+"  hfBD: "+minutosFinBD)

		if ( minutosInicioAgenda >= minutosInicioBD && minutosFinAgenda <= minutosFinBD  ) {
			// alert("CORRECTO!!, si esta dentro del horario permitido")
			guardarAgenda()
		}else if (confirm("estas fuera del horario, deseas Agendar?")){
			guardarAgenda()
		}
	}


	function verificaHorarioPermitido_HoraConcurrida(){
		horaIniciaAgenda = $("#txthorarioInicioC1").val().split(":")
		horaFinAgenda = $("#txthorarioFinC1").val().split(":")

		minutosInicioAgenda = (parseInt(horaIniciaAgenda[0])*60) + parseInt(horaIniciaAgenda[1])
		minutosFinAgenda = (parseInt(horaFinAgenda[0])*60) + parseInt(horaFinAgenda[1])

		horaInicioBD = hora_inicio_muerto.split(":")
		horaFinBD = hora_fin_muerto.split(":")

		minutosInicioBD = (parseInt(horaInicioBD[0])*60) + parseInt(horaInicioBD[1])
		minutosFinBD = (parseInt(horaFinBD[0])*60) + parseInt(horaFinBD[1])


		// console.log("hi: "+minutosInicioAgenda+" hf: "+minutosFinAgenda)
		// console.log("hiBD: "+minutosInicioBD+"  hfBD: "+minutosFinBD)

		if ( minutosInicioAgenda <= minutosInicioBD && minutosFinAgenda <= minutosInicioBD  ) {
			// alert("CORRECTO!!, si esta dentro del horario permitido antes de las 11")
			guardarAgenda()
		}else {
			if( minutosInicioAgenda >= minutosFinBD && minutosFinAgenda >= minutosFinBD ) {
				// alert("CORRRECTO!!, si esta dentro del horario permitido despues de las 5")
				guardarAgenda()
			}else{
				if (confirm("¿ Deseas agendar esta cancha aun estando fuera de horario permitido ?")) {
					guardarAgenda()
				}else{
					alert("Horario concurrido incorrecto")	
				}
				
			}
		}
	}




	//esta condicion se pone en caso de que quieran actualizar una reservacion
	//para que busque el precio por X personas

	
		
	$("#optTipoServicio").change(function(){
		console.log("Entro tipo servicio")
        if($(this).val()!=""){
        	idTipoServicio = $(this).val()
            buscaPrecioTipoServicio(idTipoServicio)

            if ($(this).val()==3) {
            	$("#txtNivel").attr("required", "required")
            	$("#optTipoPago").attr("required", "required")
            	$("#optEstatus").attr("required", "required")
            }else{
            	$("#txtNivel").removeAttr("required", "required")
            	$("#optTipoPago").removeAttr("required", "required")
            	$("#optEstatus").removeAttr("required", "required")
            }
        }
	})  


	var hora_inicio, hora_fin, hora_inicio2, hora_fin2

	function buscaPrecioTipoServicio(idTipoServicio){
		//busca los precios del tipo de servicio
		$.ajax({
		    url:"scripts/asp/admin_capturarTipoServicio.asp",
		    cache: false,
		    data: {comm:"precioServicios", idTipoServicio:idTipoServicio},
		    dataType: "json",
		    method: "POST"
		}).done(function(rest){
			console.log(rest)
		    $.each(rest.data, function (i, item) {
		    	$("#txtprecioCancha").val(item.precio_hora)
		    	$("#txtdosPersonas").val(item.dos_personas)
		    	$("#txttresPersonas").val(item.tres_personas)
		    	$("#txtcuatroPersonas").val(item.cuatro_personas)
		    	$("#txtinscripcion").val(item.inscripcion)
		    	hora_inicio = item.hora_inicio
		    	hora_fin = item.hora_fin
		    	hora_inicio2 = item.hora_inicio2
		    	hora_fin2 = item.hora_fin2
		    	hora_inicio_muerto = item.horario_inicio_muerto
		    	hora_fin_muerto = item.horario_fin_Muerto
		    });
		   calculaPrecioFinalTipoServicio()
		})
	}

	function calculaPrecioFinalTipoServicio(){
		if ( $("#optTipoServicio").val()== 1 ) {
			
			//renta cancha normal
			$("#divDatosAcademia").hide()
			$("#divClasesAcademia").hide()
			$("#divHorarioPermitido").hide()
			limpiarDatosAcademia()

			if ( numHoras > 1 ) {
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val() * numHoras).toFixed(2) )
			}else {
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()).toFixed(2) )	
			}


		}else if ( $("#optTipoServicio").val()== 2 ) {
			
			//renta cancha WPT
			$("#divDatosAcademia").hide()
			$("#divClasesAcademia").hide()
			$("#divHorarioPermitido").hide()
			limpiarDatosAcademia()

			if ( numHoras > 1 ) {
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val() * numHoras).toFixed(2) )
			}else {
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()).toFixed(2) )	
			}


		}else if ( $("#optTipoServicio").val()== 3 ) {
			
			//renta cancha academia
			$("#divDatosAcademia").show()
			$("#divClasesAcademia").show()
			$("#divHorarioPermitido").hide()
			limpiarDatosAcademia()
			$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()).toFixed(2) )

			if ( $("#optTipoPago").val() == 1 ) { //Mensual
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()* 1 ).toFixed(2) )					
			}else if ( $("#optTipoPago").val() == 2 ) { //Bimestral
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtdosPersonas").val()* 2 ).toFixed(2) )
			}else if ( $("#optTipoPago").val() == 3 ) { //Trimestral
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txttresPersonas").val()* 3 ).toFixed(2) )
			}else if ( $("#optTipoPago").val() == 4 ) { //Anual
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtcuatroPersonas").val()* 12).toFixed(2)  )
			}

		}else if ( $("#optTipoServicio").val()== 4 || $("#optTipoServicio").val()== 8 ) {
			
			//renta cancha Clase Grupal
			if ( $("#optNumPersonas").val() > 1) {
				if ( $("#optNumPersonas").val() == 2 ) {
					$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtdosPersonas").val()).toFixed(2) )	
				}else if ( $("#optNumPersonas").val() == 3 ) {
					$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txttresPersonas").val()).toFixed(2) )
				}else if ( $("#optNumPersonas").val() == 4 ) {
					$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtcuatroPersonas").val()).toFixed(2) )
				}
			}else{
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()).toFixed(2) )
			}

			$("#divDatosAcademia").hide()
			$("#divClasesAcademia").hide()
			$("#divHorarioPermitido").hide()
			limpiarDatosAcademia()
			
		}else if ( $("#optTipoServicio").val()== 5 ) {
			
			//renta cancha Clase Particular
			if ( $("#optNumPersonas").val() > 1) {
				if ( $("#optNumPersonas").val() == 2 ) {
					$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtdosPersonas").val()).toFixed(2) )	
				}else if ( $("#optNumPersonas").val() == 3 ) {
					$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txttresPersonas").val()).toFixed(2) )
				}else if ( $("#optNumPersonas").val() == 4 ) {
					$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtcuatroPersonas").val()).toFixed(2) )
				}
			}else{
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()).toFixed(2) )
			}
			$("#divDatosAcademia").hide()
			$("#divClasesAcademia").hide()
			$("#divHorarioPermitido").hide()
			limpiarDatosAcademia()
		}else if ( $("#optTipoServicio").val()== 6 ) {
			
			//renta cancha normal
			$("#divDatosAcademia").hide()
			$("#divClasesAcademia").hide()
			limpiarDatosAcademia()

			if ( numHoras > 1 ) {
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val() * numHoras).toFixed(2) )
			}else {
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()).toFixed(2) )	
			}

			$("#divHorarioPermitido").show()
			$("#lblHorarioPermitido").html("Horario permitido: "+hora_inicio+" A "+hora_fin)


		}else if ( $("#optTipoServicio").val()== 7 ) {
			
			//renta cancha normal
			$("#divDatosAcademia").hide()
			$("#divClasesAcademia").hide()
			limpiarDatosAcademia()

			if ( numHoras > 1 ) {
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val() * numHoras).toFixed(2) )
			}else {
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()).toFixed(2) )	
			}

			$("#divHorarioPermitido").show()
			$("#lblHorarioPermitido").html("Horario permitido: "+hora_inicio+" A "+hora_fin+ " y de "+hora_inicio2+" A "+hora_fin2)

		}
	}


	//Calculamos el precio por el numero de personas, solo para la clase particular, Clase grupal y Academia
	$("#optNumPersonas").change(function() {
		console.log("Entro num personas")
		if ( $("#optTipoServicio").val() == 4 || $("#optTipoServicio").val() == 5 || $("#optTipoServicio").val() == 3 || $("#optTipoServicio").val() == 8) {

			// buscaPrecioTipoServicio($("#optTipoServicio").val())//si entra para actualizar buscamos antes los precios por personas	
	
			if ( $("#optNumPersonas").val() == 1 ) {
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()).toFixed(2) )
			}else if ( $("#optNumPersonas").val() == 2 ) {
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtdosPersonas").val()).toFixed(2) )	
			}else if ( $("#optNumPersonas").val() == 3 ) {
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txttresPersonas").val()).toFixed(2) )
			}else if ( $("#optNumPersonas").val() == 4 ) {
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtcuatroPersonas").val()).toFixed(2) )
			}
		}
	})
	

	//calculamos la fecha del proximo pago del tipo ACADEMIA
	$("#optTipoPago").change(function(){
		console.log("Entro tipo pago")
		if ( $("#txtfechaInscrpcion").val() != '' ) {
			fechaInscripcion = $("#txtfechaInscrpcion").val().split("/")
			dia = fechaInscripcion[1]
			mes = fechaInscripcion[0]
			anio = fechaInscripcion[2]
			f = anio+"/"+mes+"/"+dia
			var fechaIns = new Date(f)
			console.log(fechaIns)

			if ( $("#optTipoPago").val()== 1 ) {
				//Mensual, sumamos 30 dias
				$("#txtUltimaFechadePago").val( sumarDias( fechaIns, 30 ) )
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val() * 1).toFixed(2) )		
			}else if ( $("#optTipoPago").val()== 2 ) {
				//Bimestral, sumamos 60 dias
				$("#txtUltimaFechadePago").val( sumarDias( fechaIns, 60 ) )
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val() * 2).toFixed(2) )		
			}else if ( $("#optTipoPago").val()== 3 ) {
				//Trimestral, sumamos 90 dias
				$("#txtUltimaFechadePago").val( sumarDias( fechaIns, 90 ) )
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val() * 3).toFixed(2) )		
			}else if ( $("#optTipoPago").val()== 4 ) {
				//Semestral, sumamos 182 dias
				$("#txtUltimaFechadePago").val( sumarDias( fechaIns, 182 ) )
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val() * 6).toFixed(2) )		
			}else if ( $("#optTipoPago").val()== 5 ) {
				//Anual, sumamos 365 dias
				$("#txtUltimaFechadePago").val( sumarDias( fechaIns, 365 ) )
				$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val() * 12).toFixed(2) )
			}	
		}	
	})

	//funcion para sumar los dias del proximo pago en tipo servico ACADEMIA
	function sumarDias(fecha, dias){
		fecha.setDate(fecha.getDate() + dias)
		let formatted_date = (fecha.getMonth() + 1) + "/" + fecha.getDate() + "/" + fecha.getFullYear()
		return formatted_date
	}

	function limpiarDatosAcademia(){
		$("#txtNivel").val('')
		$("#txtGrupoAsignado").val('')
		$("#txtfechaInscrpcion").val('')
		$("#txtUltimaFechadePago").val('')
		$("#optTipoPago").val('')
		$("#optEstatus").val('')

		$("#optCanchaAsignada2").val("")
		$("#txtFechaReservaC2").val("")
		$("#txthorarioInicioC2").val("")
		$("#txthorarioFinC2").val("")

		$("#optCanchaAsignada3").val("")
		$("#txtFechaReservaC3").val("")
		$("#txthorarioInicioC3").val("")
		$("#txthorarioFinC3").val("")

		$("#optCanchaAsignada4").val("")
		$("#txtFechaReservaC4").val("")
		$("#txthorarioInicioC4").val("")
		$("#txthorarioFinC4").val("")

		$("#optCanchaAsignada5").val("")
		$("#txtFechaReservaC5").val("")
		$("#txthorarioInicioC5").val("")
		$("#txthorarioFinC5").val("")

		$("#optCanchaAsignada6").val("")
		$("#txtFechaReservaC6").val("")
		$("#txthorarioInicioC6").val("")
		$("#txthorarioFinC6").val("")

		$("#optCanchaAsignada7").val("")
		$("#txtFechaReservaC7").val("")
		$("#txthorarioInicioC7").val("")
		$("#txthorarioFinC7").val("")

		$("#optCanchaAsignada8").val("")
		$("#txtFechaReservaC8").val("")
		$("#txthorarioInicioC8").val("")
		$("#txthorarioFinC8").val("")
	}
	
	var numHoras;

	function calcularHoras(){
		horaInicioArray = $("#txthorarioInicioC1").val().split(":")
		horaFinArray = $("#txthorarioFinC1").val().split(":")

		horaInicio = horaInicioArray[0]
		minutoInicio = horaInicioArray[1]
		
		horaFin = horaFinArray[0]
		minutoFin = horaFinArray[1]

		minutosTotalesInicio = (parseInt(horaInicio) * 60) + parseInt(minutoInicio)
		minutosTotalesFin = (parseInt(horaFin) * 60) + parseInt(minutoFin)

		numMinutos = parseInt(minutosTotalesFin) - parseInt(minutosTotalesInicio)

		numHoras = parseInt(numMinutos)/60

		if ( numHoras > 1 ) {
			$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val() * numHoras).toFixed(2) )
		}else {
			$("#txtPrecioFinalTipoServicio").text( parseFloat($("#txtprecioCancha").val()).toFixed(2) )	
		}

	}

	var horaInicioAnterior

	$("#txthorarioInicioC1").on('input', function(){
		if ( $(this).val() != horaInicioAnterior) {
			horaInicioAnterior = $(this).val()
			if ($("#optTipoServicio").val()== 1 || $("#optTipoServicio").val()== 2 || $("#optTipoServicio").val()== 6 || $("#optTipoServicio").val()== 7 )  {
				console.log("cambio hora inicio")
				calcularHoras()
			}	
		}
		
	})

	var horaFinAnterior

	$("#txthorarioFinC1").on('input', function(){
		if ( $(this).val() != horaFinAnterior) {
			horaFinAnterior = $(this).val()
			if ($("#optTipoServicio").val()== 1 || $("#optTipoServicio").val()== 2 || $("#optTipoServicio").val()== 6 || $("#optTipoServicio").val()== 7) {
				console.log("cambio hora fin")
				calcularHoras()
			}
		}
		
	})

	var idCancha, ValAnteriorCancha, idAnteriorCancha, fecha_reservada, cancha_reservada, clase
	$("#optCanchaAsignada1, #optCanchaAsignada2, #optCanchaAsignada3, #optCanchaAsignada4, #optCanchaAsignada5, #optCanchaAsignada6, #optCanchaAsignada7, #optCanchaAsignada8").on('input', function(){
		idCancha = $(this).attr('id')

		if ( $(this).val() != ValAnteriorCancha || idCancha != idAnteriorCancha) {
			ValAnteriorCancha = $(this).val()
			idAnteriorCancha = idCancha

			if (idCancha == "optCanchaAsignada1") {
				console.log("Cancha1")
				fecha_reservada = $("#txtFechaReservaC1").val()
				cancha_reservada = $("#optCanchaAsignada1").val()
				clase = 1 
			}else if (idCancha == "optCanchaAsignada2") {
				console.log("cancha2")
				fecha_reservada = $("#txtFechaReservaC2").val()
				cancha_reservada = $("#optCanchaAsignada2").val()
				clase = 2
			}else if (idCancha == "optCanchaAsignada3") {
				console.log("cancha3")
				fecha_reservada = $("#txtFechaReservaC3").val()
				cancha_reservada = $("#optCanchaAsignada3").val()
				clase = 3
			}else if (idCancha == "optCanchaAsignada4") {
				console.log("cancha4")
				fecha_reservada = $("#txtFechaReservaC4").val()
				cancha_reservada = $("#optCanchaAsignada4").val()
				clase = 4
			}else if (idCancha == "optCanchaAsignada5") {
				console.log("cancha5")
				fecha_reservada = $("#txtFechaReservaC5").val()
				cancha_reservada = $("#optCanchaAsignada5").val()
				clase = 5
			}else if (idCancha == "optCanchaAsignada6") {
				console.log("cancha6")
				fecha_reservada = $("#txtFechaReservaC6").val()
				cancha_reservada = $("#optCanchaAsignada6").val()
				clase = 6
			}else if (idCancha == "optCanchaAsignada7") {
				console.log("cancha7")
				fecha_reservada = $("#txtFechaReservaC7").val()
				cancha_reservada = $("#optCanchaAsignada7").val()
				clase = 7
			}else if (idCancha == "optCanchaAsignada8") {
				console.log("cancha8")
				fecha_reservada = $("#txtFechaReservaC8").val()
				cancha_reservada = $("#optCanchaAsignada8").val()
				clase = 8
			}
			buscarReservaciones(fecha_reservada, cancha_reservada, clase)
		}
	})


	var ValAnterior, idAnterior, id;
	$("#txtFechaReservaC1, #txtFechaReservaC2, #txtFechaReservaC3, #txtFechaReservaC4, #txtFechaReservaC5, #txtFechaReservaC6, #txtFechaReservaC7, #txtFechaReservaC8").on('input', function(e){
		id = $(this).attr('id')
		
		if ( $(this).val() != ValAnterior || id != idAnterior) {
			ValAnterior = $(this).val()
			idAnterior = id

			if (id == "txtFechaReservaC1") {
				console.log("c1")
				fecha_reservada = $("#txtFechaReservaC1").val()
				cancha_reservada = $("#optCanchaAsignada1").val()
				clase = 1
			}else if (id == "txtFechaReservaC2") {
				console.log("c2")
				fecha_reservada = $("#txtFechaReservaC2").val()
				cancha_reservada = $("#optCanchaAsignada2").val()
				clase = 2
			}else if (id == "txtFechaReservaC3") {
				console.log("c3")
				fecha_reservada = $("#txtFechaReservaC3").val()
				cancha_reservada = $("#optCanchaAsignada3").val()
				clase = 3
			}else if (id == "txtFechaReservaC4") {
				console.log("c4")
				fecha_reservada = $("#txtFechaReservaC4").val()
				cancha_reservada = $("#optCanchaAsignada4").val()
				clase = 4
			}else if (id == "txtFechaReservaC5") {
				console.log("c5")
				fecha_reservada = $("#txtFechaReservaC5").val()
				cancha_reservada = $("#optCanchaAsignada5").val()
				clase = 5
			}else if (id == "txtFechaReservaC6") {
				console.log("c6")
				fecha_reservada = $("#txtFechaReservaC6").val()
				cancha_reservada = $("#optCanchaAsignada6").val()
				clase = 6
			}else if (id == "txtFechaReservaC7") {
				console.log("c7")
				fecha_reservada = $("#txtFechaReservaC7").val()
				cancha_reservada = $("#optCanchaAsignada7").val()
				clase = 7
			}else if (id == "txtFechaReservaC8") {
				console.log("c8")
				fecha_reservada = $("#txtFechaReservaC8").val()
				cancha_reservada = $("#optCanchaAsignada8").val()
				clase = 8
			}

			if ($("#optCanchaAsignada"+clase).val() != "" && $("#optCanchaAsignada"+clase).val() != null ) {
				buscarReservaciones(fecha_reservada, cancha_reservada, clase)
			}
			
		}
		
	})


	var reservaciones=""

	function buscarReservaciones(fechaReservada, canchaReservada, claseReserva){
		$("#DivReservaciones1, #DivReservaciones2, #DivReservaciones3, #DivReservaciones4, #DivReservaciones5, #DivReservaciones6, #DivReservaciones7, #DivReservaciones8").hide()
		$("#ListaReservaciones1, #ListaReservaciones2, #ListaReservaciones3, #ListaReservaciones4, #ListaReservaciones5, #ListaReservaciones6, #ListaReservaciones7, #ListaReservaciones8").html("")
		$("#ListaReservaciones"+clase).html("")
		$("#DivReservaciones"+clase).show()
		reservaciones = ""

		console.log("entro busca reservaciones: fecha: "+fechaReservada + " - Cancha: "+ canchaReservada + " - Clase: "+ claseReserva)

		$.ajax({
				url: "scripts/asp/admin_capturarAgenda.asp",
				cache:false,
				dataType:"json",
				data: {	comm: "buscarReservacion", 
						txtFechaReservaC1: fechaReservada,
						optCanchaAsignada1: canchaReservada,
						idReg: $("#idReg").val()
					},
				method: "POST"
			}).done(function(rest){
				 $.each(rest.data, function (i, item) {
				 	if (item.ok=="ok") {
				 		reservaciones  = reservaciones + '<a class="list-group-item ml-3 mr-3 p-0 pl-3" style="cursor:default">\
				 		'+item.nombre_cliente+" - "+" horario: "+item.hora_inicio+" a "+item.hora_fin+'\
				 		<span class="float-right text-primary"><i class="fa fa-circle text-xs"></i></span></a>'
				 	}else{
				 		reservaciones =  "<p class='list-group-item warning ml-3 mr-3 p-0 pl-3'>SIN RESERVACIONES PARA ESTE DÍA...</p>"
				 	}	
				 })

				 $("#ListaReservaciones"+clase).html(reservaciones)


			}).fail(function(jqXHR,estado,error){
				console.log(estado);
				console.log(error);
			})
	}


	function number_format(amount, decimals) {

	    amount += ''; // por si pasan un numero en vez de un string
	    amount = parseFloat(amount.replace(/[^0-9\.-]/g, '')); // elimino cualquier cosa que no sea numero o punto

	    decimals = decimals || 0; // por si la variable no fue fue pasada

	    // si no es un numero o es igual a cero retorno el mismo cero
	    if (isNaN(amount) || amount === 0) 
	        return parseFloat(0).toFixed(decimals);

	    // si es mayor o menor que cero retorno el valor formateado como numero
	    amount = '' + amount.toFixed(decimals);

	    var amount_parts = amount.split('.'),
	        regexp = /(\d+)(\d{3})/;

	    while (regexp.test(amount_parts[0]))
	        amount_parts[0] = amount_parts[0].replace(regexp, '$1' + ',' + '$2');

	    return amount_parts.join('.');
	}
