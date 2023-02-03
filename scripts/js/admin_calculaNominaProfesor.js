
var academia, particular, grupal, nomina_profesor, total_clases_grupal, total_clases_academia, total_clases_particular

function calularNomina(fechaInicio, fechaFin, idProfe){
	academia = ""
	academiaDia = ""
	particular = ""
	grupal = ""
	nomina_profesor = 0.00
	total_clases_particular = 0
	total_clases_grupal = 0
	total_clases_academia = 0
	total_clases_academiaDia = 0
	
	$("#ListaAcademia, #ListaParticular, #ListaGrupal").html("")

	color = ["b-info","b-success", "b-primary", "b-info", "b-success"]

	console.log("calcular: "+fechaInicio+ " - " +fechaFin+ " - "+idProfe)

	$.ajax({
	    url:"scripts/asp/admin_calculaNominaProfesor.asp",
	    cache: false,
	    data: {comm:"calculaNomina", txtfechaInicio:fechaInicio, txtfechaFin:fechaFin, idProfesor:idProfe},
	    dataType: "json",
	    method: "POST"
	}).done(function(rest){
	   console.log("rest")
	   $.each(rest.data, function (i, item) {
		    if (item.id != "") {
		    	if (item.tipo_servicioNum==3) {
		    		academia  = academia + '<div class="sl-item '+color[i]+' ">\
							              <div class="sl-content">\
							                <div class="sl-date text-muted">Cliente: '+item.nombre_cliente+' - Num. personas: '+item.num_personas+'</div>\
							                <div class="sl-date text-muted">Profesor: '+item.profesor+' - Cancha: '+item.cancha_asignada+'</div>\
							                <p style="margin-bottom: auto;">'+item.fecha_renta+ ' Horario: '+item.hora_inicio+' - '+item.hora_fin+'</p>\
							                <small>'+item.tipo_servicio+'</small>\
							              </div>\
							            </div>'
							            total_clases_academia = parseInt(total_clases_academia) + parseInt(1)
		    	}else if (item.tipo_servicioNum==4) {
		    		grupal  = grupal + '<div class="sl-item '+color[i]+' ">\
							              <div class="sl-content">\
							                <div class="sl-date text-muted">Cliente: '+item.nombre_cliente+' - Num. personas: '+item.num_personas+'</div>\
							                <div class="sl-date text-muted">Profesor: '+item.profesor+' - Cancha: '+item.cancha_asignada+'</div>\
							                <p style="margin-bottom: auto;">'+item.fecha_renta+ ' Horario: '+item.hora_inicio+' - '+item.hora_fin+'</p>\
							                <small>'+item.tipo_servicio+'</small>\
							              </div>\
							            </div>'	
							            total_clases_grupal = parseInt(total_clases_grupal) + parseInt(1)
		    	}else if (item.tipo_servicioNum==5) {
		    		particular  = particular + '<div class="sl-item '+color[i]+' ">\
							              <div class="sl-content">\
							                <div class="sl-date text-muted">Cliente: '+item.nombre_cliente+' - Num. personas: '+item.num_personas+'</div>\
							                <div class="sl-date text-muted">Profesor: '+item.profesor+' - Cancha: '+item.cancha_asignada+'</div>\
							                <p style="margin-bottom: auto;">'+item.fecha_renta+ ' Horario: '+item.hora_inicio+' - '+item.hora_fin+'</p>\
							                <small>'+item.tipo_servicio+'</small>\
							              </div>\
							            </div>'
							            total_clases_particular = parseInt(total_clases_particular) + parseInt(1)
		    	}else if (item.tipo_servicioNum==8) {
		    		academiaDia  = academiaDia + '<div class="sl-item '+color[i]+' ">\
							              <div class="sl-content">\
							                <div class="sl-date text-muted">Cliente: '+item.nombre_cliente+' - Num. personas: '+item.num_personas+'</div>\
							                <div class="sl-date text-muted">Profesor: '+item.profesor+' - Cancha: '+item.cancha_asignada+'</div>\
							                <p style="margin-bottom: auto;">'+item.fecha_renta+ ' Horario: '+item.hora_inicio+' - '+item.hora_fin+'</p>\
							                <small>'+item.tipo_servicio+'</small>\
							              </div>\
							            </div>'
							            total_clases_academiaDia = parseInt(total_clases_academiaDia) + parseInt(1)
		    	}
		    	nomina_profesor = item.nomina_profesor
		    }
	   });
	   $("#ListaAcademia").html(academia)
	   $("#ListaAcademiaDia").html(academiaDia)
	   $("#ListaParticular").html(particular)
	   $("#ListaGrupal").html(grupal)
	   $("#nomina_profesor").text(nomina_profesor)

	   $("#totalClasesAcademia").text(total_clases_academia)
	   $("#totalClasesAcademiaDia").text(total_clases_academiaDia)
	   $("#totalClasesGrupal").text(total_clases_grupal)
	   $("#totalClasesParticular").text(total_clases_particular)

	})
}
	
	
	var fi, ff, idProfesor

	$(".buscarNominaProfesor").click(function(){
	    // console.log("entro buscar por fecha")
	    // $('#tblReservacionesAcademia').DataTable().destroy();
	   	fi = $("#fecha_inicial").val()
	   	ff = $("#fecha_final").val()
	   	idProfesor = $("#optProfesor").val()
	   	console.log(idProfesor)
	    calularNomina(fi, ff, idProfesor)
	    // if ( $("#date_from").val() != "" && $("#date_to").val() != "") {
	    //   rowDetailsTable.api().ajax.reload();  
	    // }else{
	    //   $('#tblIncidencias').DataTable().ajax.reload();
	    // }
	    
	})



	$(".buscarAgendaProfesor").click(function(){

		$.ajax({
		    url:"scripts/asp/admin_capturarProfesor.asp",
		    cache: false,
		    data: {comm:"buscaProfesor"},
		    dataType: "json",
		    method: "POST"
		}).done(function(rest){
			 $.each(rest.data, function (i, item) {
			 	idProfesor = item.id
			 })

			 fi = $("#fecha_inicial").val()
		   	ff = $("#fecha_final").val()
		   	console.log("IdProfe: "+idProfesor)
		   	calularNomina(fi, ff, idProfesor)
		})



	    
	})

	