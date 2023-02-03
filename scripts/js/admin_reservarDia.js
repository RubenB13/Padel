function reservarDia(){
	  	
	  	info = $("#frmReserva").serialize()
	    info =  info + "&comm=nuevaReserva"
	    // console.log(info) 
	  	$.ajax({
			url: "scripts/asp/admin_capturarReserva.asp",
			cache:false,
			dataType:"json",
			data: info,
			method: "POST"
		}).done(function(rest){
			// console.log(rest)
			 $.each(rest.data, function (i, item) {

			 	if (item.ok=="ok") {
			 		alert("Se envió la solicitud correctamente, en breve nos comunicaremos con usted")
			 	}
		 		$("#frmReserva").get(0).reset();
			 })
		}).fail(function(jqXHR,estado,error){
			console.log(estado);
			console.log(error);
		})
	}



	function isMobile() {
	    if (sessionStorage.desktop)
	        return false;
	    else if (localStorage.mobile)
	        return true;
	    var mobile = ['iphone', 'ipad', 'android', 'blackberry', 'nokia', 'opera mini', 'windows mobile', 'windows phone', 'iemobile'];
	    for (var i in mobile)
	        if (navigator.userAgent.toLowerCase().indexOf(mobile[i].toLowerCase()) > 0) return true;
	    return false;
	}

	const urlDesktop = 'https://web.whatsapp.com/';
	const urlMobile = 'whatsapp://';
	const telefono = '5212231317409';
	
	var mensaje = ""

	$("#btnReservar").click(function (e) {
		
		if ( $("#txtNombreCliente").val() == "" || $("#txtFechaReservaC1").val() == "" ) {
			//alert("Faltan datos")
		}else{
			e.preventDefault()
			reservarDia()
			mensaje = "send?phone="+telefono+"&text=Hola soy "+$("#txtNombreCliente").val()+" deseo reservar una "+$("#optTipoServicio option:selected").text()+" para el día "+$("#txtFechaReservaC1").val()+" en el horario "+$("#txthorarioInicioC1").val()+" - "+$("#txthorarioFinC1").val()+" Comentarios: "+$("#txtComentario").val()
			//mensaje = "send?phone="+telefono+"&text=Hola soy "+$("#txtNombreCliente").val()+" deseo reservar "+$("#optTipoServicio option:selected").text()

			// $(this).attr("href", "https://api.whatsapp.com/send?phone=2212020734&text="+mensaje)
			
			if(isMobile()) {
	            window.open(urlMobile + mensaje, '_blank')
	        }else{
	            window.open(urlDesktop + mensaje, '_blank')
	        }

			//console.log(mensaje)	
		}
		
	})


var htmlReservas =""
var numReservaciones = ""

mostrarReservas()
listarReservass = setInterval(mostrarReservas, 60000);

function mostrarReservas(){
	color = ["cyan","brown", "light-blue", "blue-grey", "grey", "success", "info", "danger", "warning", "cyan","brown", "light-blue", "blue-grey", "grey", "success", "info", "danger", "warning"]
	htmlReservas = ""

  	$.ajax({
		url: "scripts/asp/admin_capturarReserva.asp",
		cache:false,
		dataType:"json",
		data: {comm:"listarReservas"},
		method: "POST"
	}).done(function(rest){
		// console.log(rest)
		 $.each(rest.data, function (i, item) {
		 	htmlReservas = htmlReservas + '<div class="list-item " data-id="item-6">\
		 									<span class="w-24 avatar circle '+color[i]+'">\
		 										<span class="fa fa-envelope"></span>\
		 									</span>\
		 									<div class="list-body">\
		 										'+item.nombre+'\
		 										<div class="item-except text-sm text-muted h-1x">'+item.tipo_servicio+'</div>\
		 										<div class="item-except text-sm text-muted h-1x">'+item.fecha_reserva+'</div>\
		 										<span class="item-date text-xs text-muted">'+item.horario+'</span>\
		 										<div class="item-tag tag hide"></div>\
		 									</div>\
		 								</div>'

		 	numReservaciones = item.num_reservas
		 })
		 $("#listReservaciones").html(htmlReservas)
		 $("#spanNumReservaciones").text(numReservaciones)
		 $("#spanNumReservaciones2").text(numReservaciones+" Reservaciones")
	}).fail(function(jqXHR,estado,error){
		console.log(estado);
		console.log(error);
	})
}


var idReserva=""

function verReserva(id){
	idReserva = id
  	$.ajax({
		url: "scripts/asp/admin_capturarReserva.asp",
		cache:false,
		dataType:"json",
		data: {comm:"verReserva", idReg:id},
		method: "POST"
	}).done(function(rest){
		 $.each(rest.data, function (i, item) {
		 	$("#lblNombre").text(item.nombre)
		 	$("#lblTipoServicio").text(item.tipo_servicio)
		 	$("#lblFechaReserva").text(item.fecha_reserva)
		 	$("#lblHorario").text(item.horario)
		 	$("#lblTelefono").text(item.telefono)
		 	$("#lblComentarios").text(item.comentarios)
		 })
		 $("#modalVerReservacion").modal("show")
		 
	}).fail(function(jqXHR,estado,error){
		console.log(estado);
		console.log(error);
	})
}

$("#btnAtenderReserva").click(function () {
	$.ajax({
		url: "scripts/asp/admin_capturarReserva.asp",
		cache:false,
		dataType:"json",
		data: {comm:"atenderReserva", idReg:idReserva},
		method: "POST"
	}).done(function(rest){
		 
		 $.each(rest.data, function (i, item) {
		 	if (item.ok = "ok") {
		 		$("#modalVerReservacion").modal("hide")	
		 		mostrarReservas()	
		 	}
		 })
		 		 
	}).fail(function(jqXHR,estado,error){
		console.log(estado);
		console.log(error);
	})	
})



//******** RESERVA CLASES ACADEMIA, GRUPAL Y PARTICULAR ***********

$("#btnReservarClase").click(function (e) {
		
	if ( $("#txtNombreAcademia").val() == "" || $("#txtTelefonoAcademia").val() == "" ) {
		//alert("Faltan datos")
	}else{
		e.preventDefault()
		reservarClase()
		mensaje = "send?phone="+telefono+"&text=Hola soy "+$("#txtNombreAcademia").val()+" y deseo inscribirme a una clase "+$("#optTipoClase option:selected").text()+" ,tengo "+$("#txtEdad").val()+" años, y mi experiencia es: "+$("#optExperiencia option:selected").text()
		
		if(isMobile()) {
            window.open(urlMobile + mensaje, '_blank')
        }else{
            window.open(urlDesktop + mensaje, '_blank')
        }

		//console.log(mensaje)	
	}
	
})


function reservarClase(){  	
  	info = $("#frmAcademia").serialize()
    info =  info + "&comm=nuevaReservaClase"
    // console.log(info) 
  	$.ajax({
		url: "scripts/asp/admin_capturarReserva.asp",
		cache:false,
		dataType:"json",
		data: info,
		method: "POST"
	}).done(function(rest){
		// console.log(rest)
		 $.each(rest.data, function (i, item) {

		 	if (item.ok=="ok") {
		 		alert("Se envió la solicitud correctamente, en breve nos comunicaremos con usted")
		 	}
	 		$("#frmAcademia").get(0).reset();
		 })
	}).fail(function(jqXHR,estado,error){
		console.log(estado);
		console.log(error);
	})
}


var idReservaClase=""

function verReservaClase(id){
	idReservaClase = id
  	$.ajax({
		url: "scripts/asp/admin_capturarReserva.asp",
		cache:false,
		dataType:"json",
		data: {comm:"verReserva", idReg:idReservaClase},
		method: "POST"
	}).done(function(rest){
		 $.each(rest.data, function (i, item) {
		 	$("#lblNombreAcademia").text(item.nombre)
		 	$("#lblTipoClase").text(item.tipo_servicio)
		 	$("#lblTelefonoAcademia").text(item.telefono)
		 	$("#lblGenero").text(item.genero)
		 	$("#lblEdad").text(item.edad)
		 	$("#lblExperiencia").text(item.experiencia)
		 })
		 $("#modalVerReservacionClase").modal("show")
		 
	}).fail(function(jqXHR,estado,error){
		console.log(estado);
		console.log(error);
	})
}

$("#btnAtenderReservaClase").click(function () {
	$.ajax({
		url: "scripts/asp/admin_capturarReserva.asp",
		cache:false,
		dataType:"json",
		data: {comm:"atenderReserva", idReg:idReservaClase},
		method: "POST"
	}).done(function(rest){
		 
		 $.each(rest.data, function (i, item) {
		 	if (item.ok = "ok") {
		 		$("#modalVerReservacionClase").modal("hide")	
		 		mostrarReservas()	
		 	}
		 })
		 		 
	}).fail(function(jqXHR,estado,error){
		console.log(estado);
		console.log(error);
	})	
})
