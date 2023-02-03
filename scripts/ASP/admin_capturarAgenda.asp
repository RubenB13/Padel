<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="BD.asp"-->


<%
Response.Expires = 0
LServerName = Request.ServerVariables("SERVER_NAME")
valSpl = split(LServerName,".")
dominio = "db_a8638d_bdupadel" 'valSpl(0)


idUser =  Request.Cookies ("kkii124655")("id")
nombreUser = Request.Cookies ("kkii124655")("nom")
tipoUser =  Request.Cookies ("kkii124655")("tipo")

 'idUser = request.form("idUsuario")
 txtNombreCliente  = Request.form("txtNombreCliente")
 txtTelefono  = request.form("txtTelefono")
 optTipoServicio = request.form("optTipoServicio")
 optProfesor = request.form("optProfesor")
 optNumPersonas = request.form("optNumPersonas")
 optCanchaAsignada1 = request.form("optCanchaAsignada1")
 txtFechaReservaC1 = request.form("txtFechaReservaC1")
 txthorarioInicioC1 = request.form("txthorarioInicioC1")
 txthorarioFinC1 =  request.form("txthorarioFinC1")
 txtPrecioRenta = request.form("txtPrecioFinalTipoServicio")

 txtNivel = request.form("txtNivel")
 txtGrupoAsignado = request.form("txtGrupoAsignado")
 txtfechaInscrpcion = request.form("txtfechaInscrpcion")
 txtUltimaFechadePago = request.form("txtUltimaFechadePago")
 optTipoPago = request.form("optTipoPago")
 optEstatus = request.form("optEstatus")

 optCanchaAsignada2 = request.form("optCanchaAsignada2")
 txtFechaReservaC2 = request.form("txtFechaReservaC2")
 txthorarioInicioC2 = request.form("txthorarioInicioC2")
 txthorarioFinC2 = request.form("txthorarioFinC2")

 optCanchaAsignada3 = request.form("optCanchaAsignada3")
 txtFechaReservaC3 = request.form("txtFechaReservaC3")
 txthorarioInicioC3 = request.form("txthorarioInicioC3")
 txthorarioFinC3 = request.form("txthorarioFinC3")

 optCanchaAsignada4 = request.form("optCanchaAsignada4")
 txtFechaReservaC4 = request.form("txtFechaReservaC4")
 txthorarioInicioC4 = request.form("txthorarioInicioC4")
 txthorarioFinC4 = request.form("txthorarioFinC4")

 optCanchaAsignada5 = request.form("optCanchaAsignada5")
 txtFechaReservaC5 = request.form("txtFechaReservaC5")
 txthorarioInicioC5 = request.form("txthorarioInicioC5")
 txthorarioFinC5 = request.form("txthorarioFinC5")

 optCanchaAsignada6 = request.form("optCanchaAsignada6")
 txtFechaReservaC6 = request.form("txtFechaReservaC6")
 txthorarioInicioC6 = request.form("txthorarioInicioC6")
 txthorarioFinC6 = request.form("txthorarioFinC6")

 optCanchaAsignada7 = request.form("optCanchaAsignada7")
 txtFechaReservaC7 = request.form("txtFechaReservaC7")
 txthorarioInicioC7 = request.form("txthorarioInicioC7")
 txthorarioFinC7 = request.form("txthorarioFinC7")

 optCanchaAsignada8 = request.form("optCanchaAsignada8")
 txtFechaReservaC8 = request.form("txtFechaReservaC8")
 txthorarioInicioC8 = request.form("txthorarioInicioC8")
 txthorarioFinC8 = request.form("txthorarioFinC8")

 minutosTotalesInicio = request.form("minutoInicio")
 minutosTotalesFin = request.form("minutoFin")
 txtDescuento =  request.form("txtDescuento")
 txtPlayTomic = request.form("txtPlayTomic")
 txtTransferencia = request.form("txtTransferencia")
 txtTarjeta = request.form("txtTarjeta")
 txtDeposito = request.form("txtDeposito")
 txtEfectivo = request.form("txtEfectivo")

 txtObservaciones =  request.form("txtObservaciones")

 	periodoDesde = request.QueryString("de")
	periodoA = request.QueryString("a")


 comm = request.form("comm")
 idRegistro = request.form("idReg")
 com = request.queryString("com")


camposs = "nombre_cliente, telefono, tipo_servicio, profesor_asignado, numero_personas, cancha_asignada, fecha_renta, hora_inicio, hora_fin, fecha_registro, precio_renta, pagado, fecha_pago, id_usuario, nivel_academia, grupo_asignado, fecha_inscripcion, ultima_fecha_pago, tipo_pago_academia, estatus_academia, fecha_reservaC2, hora_inicioC2, hora_finC2, fecha_reservaC3, hora_inicioC3, hora_finC3, fecha_reservaC4, hora_inicioC4, hora_finC4, fecha_reservaC5, hora_inicioC5, hora_finC5, fecha_reservaC6, hora_inicioC6, hora_finC6, fecha_reservaC7, hora_inicioC7, hora_finC7, fecha_reservaC8, hora_inicioC8, hora_finC8, cancha_asignada2, cancha_asignada3, cancha_asignada4, cancha_asignada5, cancha_asignada6, cancha_asignada7, cancha_asignada8, estado, observaciones "

datoss = " '"&txtNombreCliente&"', '"&txtTelefono&"', '"&optTipoServicio&"', '"&optProfesor&"', '"&optNumPersonas&"', '"&optCanchaAsignada1&"', '"&txtFechaReservaC1&"','"&txthorarioInicioC1&"', '"&txthorarioFinC1&"', getDate(),'"&txtPrecioRenta&"', 0, '','"&idUser&"', '"&txtNivel&"', '"&txtGrupoAsignado&"', '"&txtfechaInscrpcion&"', '"&txtUltimaFechadePago&"', '"&optTipoPago&"', '"&optEstatus&"', '"&txtFechaReservaC2&"','"&txthorarioInicioC2&"', '"&txthorarioFinC2&"', '"&txtFechaReservaC3&"','"&txthorarioInicioC3&"', '"&txthorarioFinC3&"', '"&txtFechaReservaC4&"','"&txthorarioInicioC4&"', '"&txthorarioFinC4&"', '"&txtFechaReservaC5&"','"&txthorarioInicioC5&"', '"&txthorarioFinC5&"', '"&txtFechaReservaC6&"','"&txthorarioInicioC6&"', '"&txthorarioFinC6&"', '"&txtFechaReservaC7&"','"&txthorarioInicioC7&"', '"&txthorarioFinC7&"', '"&txtFechaReservaC8&"','"&txthorarioInicioC8&"', '"&txthorarioFinC8&"', '"&optCanchaAsignada2&"', '"&optCanchaAsignada3&"', '"&optCanchaAsignada4&"', '"&optCanchaAsignada5&"', '"&optCanchaAsignada6&"', '"&optCanchaAsignada7&"', '"&optCanchaAsignada8&"', '1', '"&txtObservaciones&"' "

camposAct = "nombre_cliente='"&txtNombreCliente&"', telefono='"&txtTelefono&"', tipo_servicio='"&optTipoServicio&"', profesor_asignado='"&optProfesor&"', numero_personas='"&optNumPersonas&"', cancha_asignada='"&optCanchaAsignada1&"', fecha_renta='"&txtFechaReservaC1&"', hora_inicio='"&txthorarioInicioC1&"', hora_fin='"&txthorarioFinC1&"', precio_renta='"&txtPrecioRenta&"', nivel_academia='"&txtNivel&"', grupo_asignado='"&txtGrupoAsignado&"', fecha_inscripcion='"&txtfechaInscrpcion&"', ultima_fecha_pago='"&txtUltimaFechadePago&"', tipo_pago_academia='"&optTipoPago&"', estatus_academia='"&optEstatus&"', fecha_reservaC2='"&txtFechaReservaC2&"', hora_inicioC2='"&txthorarioInicioC2&"', hora_finC2='"&txthorarioFinC2&"', fecha_reservaC3='"&txtFechaReservaC3&"', hora_inicioC3='"&txthorarioInicioC3&"', hora_finC3='"&txthorarioFinC3&"', fecha_reservaC4='"&txtFechaReservaC4&"', hora_inicioC4='"&txthorarioInicioC4&"', hora_finC4='"&txthorarioFinC4&"', fecha_reservaC5='"&txtFechaReservaC5&"', hora_inicioC5='"&txthorarioInicioC5&"', hora_finC5='"&txthorarioFinC5&"', fecha_reservaC6='"&txtFechaReservaC6&"', hora_inicioC6='"&txthorarioInicioC6&"', hora_finC6='"&txthorarioFinC6&"', fecha_reservaC7='"&txtFechaReservaC7&"', hora_inicioC7='"&txthorarioInicioC7&"', hora_finC7='"&txthorarioFinC7&"', fecha_reservaC8='"&txtFechaReservaC8&"', hora_inicioC8='"&txthorarioInicioC8&"', hora_finC8='"&txthorarioFinC8&"', cancha_asignada2='"&optCanchaAsignada2&"', cancha_asignada3='"&optCanchaAsignada3&"', cancha_asignada4='"&optCanchaAsignada4&"', cancha_asignada5='"&optCanchaAsignada5&"', cancha_asignada6='"&optCanchaAsignada6&"', cancha_asignada7='"&optCanchaAsignada7&"', cancha_asignada8='"&optCanchaAsignada8&"', observaciones='"&txtObservaciones&"' "


tabla = "agenda"

'nueva agenda
if comm = "nuevaAgenda" then

	if idRegistro = 0 then 'nueva agenda'
		guardarDatos tabla, camposs, datoss, dominio
		info = "{'ok':'ok'}"
	elseif idRegistro > 0 then 'actualizammos agenda'
		ActualizarDatos tabla, camposAct, "id='"&idRegistro&"' ", dominio
		info = "{'ok':'ok1'}"
		' titulo = "Incidencia: "&cliente
		' mensaje = "Se ha generado una incidencia..."

		' enviarNotificacion titulo, mensaje, dominio

	end if
end if


if comm = "verReservacion" and idRegistro > 0 then
	sql = "select id, nombre_cliente, telefono, tipo_servicio, profesor_asignado, numero_personas, cancha_asignada, CONVERT(VARCHAR,fecha_renta,101), CONVERT(VARCHAR,hora_inicio,108), CONVERT(VARCHAR,hora_fin,108), fecha_registro, precio_renta, pagado, fecha_pago, id_usuario, nivel_academia, grupo_asignado, fecha_inscripcion, ultima_fecha_pago, tipo_pago_academia, estatus_academia, fecha_reservaC2, CONVERT(VARCHAR,hora_inicioC2,108), CONVERT(VARCHAR,hora_finC2,108), fecha_reservaC3, CONVERT(VARCHAR,hora_inicioC3,108), CONVERT(VARCHAR,hora_finC3,108), fecha_reservaC4, CONVERT(VARCHAR,hora_inicioC4,108), CONVERT(VARCHAR,hora_finC4,108), fecha_reservaC5, CONVERT(VARCHAR,hora_inicioC5,108), CONVERT(VARCHAR,hora_finC5,108), fecha_reservaC6, CONVERT(VARCHAR,hora_inicioC6,108), CONVERT(VARCHAR,hora_finC6,108), fecha_reservaC7, CONVERT(VARCHAR,hora_inicioC7,108), CONVERT(VARCHAR,hora_finC7,108), fecha_reservaC8, CONVERT(VARCHAR,hora_inicioC8,108), CONVERT(VARCHAR,hora_finC8,108), cancha_asignada2, cancha_asignada3, cancha_asignada4, cancha_asignada5, cancha_asignada6, cancha_asignada7, cancha_asignada8, estado from agenda where id='"&idRegistro&"' "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = "{'ok':'ok',  'id':'"&datos(0,l)&"', 'nombre_cliente':'"&datos(1,l)&"', 'telefono':'"&datos(2,l)&"', 'tipo_servicio':'"&datos(3,l)&"', 'profesor_asignado':'"&datos(4,l)&"', 'numero_personas':'"&datos(5,l)&"', 'cancha_asignada':'"&datos(6,l)&"', 'fecha_renta':'"&datos(7,l)&"', 'hora_inicio':'"&datos(8,l)&"', 'hora_fin':'"&datos(9,l)&"', 'fecha_registro':'"&datos(10,l)&"', 'precio_renta':'"&formatcurrency(datos(11,l),2)&"', 'pagado':'"&datos(12,l)&"', 'fecha_pago':'"&datos(13,l)&"', 'id_usuario':'"&datos(14,l)&"', 'nivel_academia':'"&datos(15,l)&"', 'grupo_asignado':'"&datos(16,l)&"', 'fecha_inscripcion':'"&datos(17,l)&"', 'ultima_fecha_pago':'"&datos(18,l)&"', 'tipo_pago_academia':'"&datos(19,l)&"', 'estatus_academia':'"&datos(20,l)&"', 'fecha_reservaC2':'"&datos(21,l)&"', 'hora_inicioC2':'"&datos(22,l)&"', 'hora_finC2':'"&datos(23,l)&"', 'fecha_reservaC3':'"&datos(24,l)&"', 'hora_inicioC3':'"&datos(25,l)&"', 'hora_finC3':'"&datos(26,l)&"', 'fecha_reservaC4':'"&datos(27,l)&"', 'hora_inicioC4':'"&datos(28,l)&"', 'hora_finC4':'"&datos(29,l)&"', 'fecha_reservaC5':'"&datos(30,l)&"', 'hora_inicioC5':'"&datos(31,l)&"', 'hora_finC5':'"&datos(32,l)&"', 'fecha_reservaC6':'"&datos(33,l)&"', 'hora_inicioC6':'"&datos(34,l)&"', 'hora_finC6':'"&datos(35,l)&"', 'fecha_reservaC7':'"&datos(36,l)&"', 'hora_inicioC7':'"&datos(37,l)&"', 'hora_finC7':'"&datos(38,l)&"', 'fecha_reservaC8':'"&datos(39,l)&"', 'hora_inicioC8':'"&datos(40,l)&"', 'hora_finC8':'"&datos(41,l)&"', 'cancha_asignada2':'"&datos(42,l)&"', 'cancha_asignada3':'"&datos(43,l)&"', 'cancha_asignada4':'"&datos(44,l)&"', 'cancha_asignada5':'"&datos(45,l)&"', 'cancha_asignada6':'"&datos(46,l)&"', 'cancha_asignada7':'"&datos(47,l)&"', 'cancha_asignada8':'"&datos(48,l)&"'}"	
		next

	end if
end if

if comm = "eliminarAgenda" and idRegistro > 0 then
	ActualizarDatos tabla, "estado=0, fecha_baja=getdate(), id_usuario_baja="&idUser&" ", "id='"&idRegistro&"' ", dominio
	info = "{'ok':'ok'}"
end if

' listar agenda
if com = "listarAgenda" then
	On Error Resume Next
	if periodoDesde <> "" and periodoA <> "" then
		tipo_busqueda = 2
		ss = " and ( cast(ag.fecha_renta as date) >= '"&periodoDesde&"' and cast(ag.fecha_renta as date) <= '"&periodoA&"' ) "&_
			" or ( cast(ag.fecha_reservaC2 as date) >= '"&periodoDesde&"' and cast(ag.fecha_reservaC2 as date) <= '"&periodoA&"' and ag.tipo_servicio = 3 )"&_
			" or ( cast(ag.fecha_reservaC3 as date) >= '"&periodoDesde&"' and cast(ag.fecha_reservaC3 as date) <= '"&periodoA&"' and ag.tipo_servicio = 3 )"&_
			" or ( cast(ag.fecha_reservaC4 as date) >= '"&periodoDesde&"' and cast(ag.fecha_reservaC4 as date) <= '"&periodoA&"' and ag.tipo_servicio = 3 )"&_
			" or ( cast(ag.fecha_reservaC5 as date) >= '"&periodoDesde&"' and cast(ag.fecha_reservaC5 as date) <= '"&periodoA&"' and ag.tipo_servicio = 3 )"&_
			" or ( cast(ag.fecha_reservaC6 as date) >= '"&periodoDesde&"' and cast(ag.fecha_reservaC6 as date) <= '"&periodoA&"' and ag.tipo_servicio = 3 )"&_
			" or ( cast(ag.fecha_reservaC7 as date) >= '"&periodoDesde&"' and cast(ag.fecha_reservaC7 as date) <= '"&periodoA&"' and ag.tipo_servicio = 3 )"&_
			" or ( cast(ag.fecha_reservaC8 as date) >= '"&periodoDesde&"' and cast(ag.fecha_reservaC8 as date) <= '"&periodoA&"' and ag.tipo_servicio = 3 )"
	else
		tipo_busqueda = 1
		ss = " and cast(ag.fecha_renta as date) = cast(getDate() as date) or "&_
			" ( cast(ag.fecha_reservaC2 as date) = cast(getDate() as date) and ag.tipo_servicio = 3 ) or "&_
			" ( cast(ag.fecha_reservaC3 as date) = cast(getDate() as date) and ag.tipo_servicio = 3 ) or "&_
			" ( cast(ag.fecha_reservaC4 as date) = cast(getDate() as date) and ag.tipo_servicio = 3 ) or "&_
			" ( cast(ag.fecha_reservaC5 as date) = cast(getDate() as date) and ag.tipo_servicio = 3 ) or "&_
			" ( cast(ag.fecha_reservaC6 as date) = cast(getDate() as date) and ag.tipo_servicio = 3 ) or "&_
			" ( cast(ag.fecha_reservaC7 as date) = cast(getDate() as date) and ag.tipo_servicio = 3 ) or "&_
			" ( cast(ag.fecha_reservaC8 as date) = cast(getDate() as date) and ag.tipo_servicio = 3) "
	end if

     
	sql = "select ag.id, CONVERT(VARCHAR,ag.fecha_renta,101), ag.nombre_cliente, prof.nombre, ag.cancha_asignada, CONVERT(VARCHAR,ag.hora_inicio,108), CONVERT(VARCHAR,ag.hora_fin,108), ag.tipo_servicio, ag.cancha_asignada2, CONVERT(VARCHAR,ag.fecha_reservaC2,101), CONVERT(VARCHAR,ag.hora_inicioC2,108), CONVERT(VARCHAR,ag.hora_finC2,108), ag.cancha_asignada3, CONVERT(VARCHAR,ag.fecha_reservaC3,101), CONVERT(VARCHAR,ag.hora_inicioC3,108), CONVERT(VARCHAR,ag.hora_finC3,108), ag.cancha_asignada4, CONVERT(VARCHAR,ag.fecha_reservaC4,101), CONVERT(VARCHAR,ag.hora_inicioC4,108), CONVERT(VARCHAR,ag.hora_finC4,108), ag.cancha_asignada5, CONVERT(VARCHAR,ag.fecha_reservaC5,101), CONVERT(VARCHAR,ag.hora_inicioC5,108), CONVERT(VARCHAR,ag.hora_finC5,108), ag.cancha_asignada6, CONVERT(VARCHAR,ag.fecha_reservaC6,101), CONVERT(VARCHAR,ag.hora_inicioC6,108), CONVERT(VARCHAR,ag.hora_finC6,108), ag.cancha_asignada7, CONVERT(VARCHAR,ag.fecha_reservaC7,101), CONVERT(VARCHAR,ag.hora_inicioC7,108), CONVERT(VARCHAR,ag.hora_finC7,108), ag.cancha_asignada8, CONVERT(VARCHAR,ag.fecha_reservaC8,101), CONVERT(VARCHAR,ag.hora_inicioC8,108), CONVERT(VARCHAR,ag.hora_finC8,108), ag.precio_renta, ag.observaciones, ag.pagado, isnull(ag.descuento,0), ag.numero_personas from agenda ag left join admin_profesores prof on ag.profesor_asignado = prof.id where ag.estado = 1 "&ss&" order by ag.fecha_renta desc "
	'sql = "select id, fecha_renta, nombre_cliente, telefono, cancha_asignada, CONVERT(VARCHAR,hora_inicio,108), CONVERT(VARCHAR,hora_fin,108), tipo_servicio from agenda where estado = 1 "&ss&" order by fecha_renta desc "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			tipo_servicio = datos(7,l)
			numClaseSPAN =""
			if tipo_servicio =  1 then
				tipoServicio = "Renta normal"
				color  = "success"
			elseif tipo_servicio = 2 then
				tipoServicio = "Cancha WPT"
				color = "primary"
			elseif tipo_servicio = 3 then
				tipoServicio = "Academia-mes"
				color = "warning"
				numClaseSPAN = "<span class=//badge blue-grey// title=//1ra Clase//>1</span>"
			elseif tipo_servicio = 4 then
				tipoServicio = "Clase grupal"
				color = "purple"
			elseif tipo_servicio = 5 then
				tipoServicio = "Clase particular"
				color = "orange"
			elseif tipo_servicio = 6 then
				tipoServicio = "Hora Muerta"
				color = "pink"
			elseif tipo_servicio = 7 then
				tipoServicio = "Hora concurrida"
				color = "cyan"
			elseif tipo_servicio = 8 then
				tipoServicio = "Academia-dia"
				color = "deep-orange"
			end if
			descuento = datos(39,l)
			pagado = datos(38,l)
			if CInt(pagado) = 0 then 'aun no esta pagado
				estaPagado = "<button class=//md-btn md-raised mb-2 red// onclick=javascript:verPago("&datos(0,l)&","&pagado&")><i class=//fa fa-dollar//></i></button>"				
			elseif CInt(pagado) = 1 then 'ya esta pagado
				if descuento <> "" then 'si no aplicaron descuento mandamos el boton en verde'
					if CInt(descuento) > 0 then 'si aplicaron descuento pero es mayor a 0 aplicamos color amarillo'
						estaPagado = "<button class=//md-btn md-raised mb-2 warning// onclick=javascript:verPago("&datos(0,l)&","&pagado&")><i class=//fa fa-check//></i></button>"
					else 'en caso de que tenga algo el campo descuento y no sea mayor a 0 pintamos de verde
						estaPagado = "<button class=//md-btn md-raised mb-2 green// onclick=javascript:verPago("&datos(0,l)&","&pagado&")><i class=//fa fa-check//></i></button>"
					end if
				else
					estaPagado = "<button class=//md-btn md-raised mb-2 green// onclick=javascript:verPago("&datos(0,l)&","&pagado&")><i class=//fa fa-check//></i></button>"
				end if
				
			end if



			tipo_servicioSPAN = "<span class=//badge "&color&"//>"&tipoServicio&"</span>"

			eliminarAgenda = "<button class=//md-btn md-raised mb-2 blue// onclick=javascript:eliminarAgenda("&datos(0,l)&")><i class=//fa fa-trash//></i></button>&nbsp"

			actualizarAgenda = "<button class=//md-btn md-raised mb-2 indigo// onclick=javascript:verReservacion("&datos(0,l)&")><i class=//fa fa-refresh//></i></button>"

			
			' fecha_renta = datos(1,l)
			' fecha_renta = split(fecha_renta,":")
			' fr = fecha_renta(1)&"/"&fecha_renta(0)&"/"&fecha_renta(2)

			

			if tipo_busqueda = 2 then 'si viene de una busqueda comparamos la fecha de la 1ra clase para ver si la agregamos al listado
				if CDate(datos(1,l)) >= CDate(periodoDesde) and CDate(datos(1,l)) <= CDate(periodoA) then
				 	info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'profesor':'"&datos(3,l)&"', 'cancha_asignada':'"&datos(4,l)&"', 'hora_inicio':'"&datos(5,l)&"', 'hora_fin':'"&datos(6,l)&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'eliminar':'"&eliminarAgenda&actualizarAgenda&"', 'pagado':'"&estaPagado&"' , 'numero_personas':'"&datos(40,l)&"', 'precio_renta':'"&formatcurrency(datos(36,l),2)&"'},"
				end if
			else 'si no viene de una busqueda agregamos todos los registros al listado
				info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'profesor':'"&datos(3,l)&"', 'cancha_asignada':'"&datos(4,l)&"', 'hora_inicio':'"&datos(5,l)&"', 'hora_fin':'"&datos(6,l)&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'eliminar':'"&eliminarAgenda&actualizarAgenda&"', 'pagado':'"&estaPagado&"', 'numero_personas':'"&datos(40,l)&"', 'precio_renta':'"&formatcurrency(datos(36,l),2)&"'},"
			end if

				
			

			'Si es tipo_servicio=3 (Academia) ponemos la info de las 8 clases
			if tipo_servicio = 3 then

				cancha2 = datos(8,l)
				horaInicio2 = datos(10,l)
				horaFin2 = datos(11,l)
				fechaReserva2 = datos(9,l)
				
				'Clase no. 2
				if fechaReserva2 <> "1/1/1900" and cancha2 <> 0 and horaInicio2 <> "00:00:00" and horaFin2 <> "00:00:00" then
					numClaseSPAN = "<span class=//badge blue-grey// title=//2da Clase//>2</span>"
					if ss <> "" then
						if CDate(fechaReserva2) >= CDate(periodoDesde) and CDate(fechaReserva2) <= CDate(periodoA) then
							info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva2&"', 'nombre_cliente':'"&datos(2,l)&"', 'profesor':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha2&"', 'hora_inicio':'"&horaInicio2&"', 'hora_fin':'"&horaFin2&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'eliminar':'"&eliminarAgenda&actualizarAgenda&"', 'pagado':'"&estaPagado&"', 'numero_personas':'"&datos(40,l)&"', 'precio_renta':'"&formatcurrency(datos(36,l),2)&"'},"
						end if
					else
						info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva2&"', 'nombre_cliente':'"&datos(2,l)&"', 'profesor':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha2&"', 'hora_inicio':'"&horaInicio2&"', 'hora_fin':'"&horaFin2&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'eliminar':'"&eliminarAgenda&actualizarAgenda&"', 'pagado':'"&estaPagado&"', 'numero_personas':'"&datos(40,l)&"', 'precio_renta':'"&formatcurrency(datos(36,l),2)&"'},"
					end if
				end if

				cancha3 = datos(12,l)
				horaInicio3 = datos(14,l)
				horaFin3 = datos(15,l)
				fechaReserva3 = datos(13,l)

				'Clase no. 3
				if fechaReserva3 <> "1/1/1900" and cancha3 <> 0 and horaInicio3 <> "00:00:00" and horaFin3 <> "00:00:00" then
					numClaseSPAN = "<span class=//badge blue-grey// title=//3ra Clase//>3</span>"
					if ss <> "" then
						if CDate(fechaReserva3) >= CDate(periodoDesde) and CDate(fechaReserva3) <= CDate(periodoA) then
							info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva3&"', 'nombre_cliente':'"&datos(2,l)&"', 'profesor':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha3&"', 'hora_inicio':'"&horaInicio3&"', 'hora_fin':'"&horaFin3&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'eliminar':'"&eliminarAgenda&actualizarAgenda&"', 'pagado':'"&estaPagado&"', 'numero_personas':'"&datos(40,l)&"', 'precio_renta':'"&formatcurrency(datos(36,l),2)&"'},"
						end if
					else
						info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva3&"', 'nombre_cliente':'"&datos(2,l)&"', 'profesor':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha3&"', 'hora_inicio':'"&horaInicio3&"', 'hora_fin':'"&horaFin3&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'eliminar':'"&eliminarAgenda&actualizarAgenda&"', 'pagado':'"&estaPagado&"', 'numero_personas':'"&datos(40,l)&"', 'precio_renta':'"&formatcurrency(datos(36,l),2)&"'},"
					end if
				end if

				cancha4 = datos(16,l)
				horaInicio4 = datos(18,l)
				horaFin4 = datos(19,l)
				fechaReserva4 = datos(17,l)

				'Clase no. 4
				if fechaReserva4 <> "1/1/1900" and cancha4 <> 0 and horaInicio4 <> "00:00:00" and horaFin4 <> "00:00:00" then
					numClaseSPAN = "<span class=//badge blue-grey// title=//4ta Clase//>4</span>"
					if ss <> "" then
						if CDate(fechaReserva4) >= CDate(periodoDesde) and CDate(fechaReserva4) <= CDate(periodoA) then
							info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva4&"', 'nombre_cliente':'"&datos(2,l)&"', 'profesor':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha4&"', 'hora_inicio':'"&horaInicio4&"', 'hora_fin':'"&horaFin4&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'eliminar':'"&eliminarAgenda&actualizarAgenda&"', 'pagado':'"&estaPagado&"', 'numero_personas':'"&datos(40,l)&"', 'precio_renta':'"&formatcurrency(datos(36,l),2)&"'},"
						end if
					else
						info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva4&"', 'nombre_cliente':'"&datos(2,l)&"', 'profesor':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha4&"', 'hora_inicio':'"&horaInicio4&"', 'hora_fin':'"&horaFin4&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'eliminar':'"&eliminarAgenda&actualizarAgenda&"', 'pagado':'"&estaPagado&"', 'numero_personas':'"&datos(40,l)&"', 'precio_renta':'"&formatcurrency(datos(36,l),2)&"'},"
					end if
				end if

				cancha5 = datos(20,l)
				horaInicio5 = datos(22,l)
				horaFin5 = datos(23,l)
				fechaReserva5 = datos(21,l)

				'Clase no. 5
				if fechaReserva5 <> "1/1/1900" and cancha5 <> 0 and horaInicio5 <> "00:00:00" and horaFin5 <> "00:00:00" then
					numClaseSPAN = "<span class=//badge blue-grey// title=//5ta Clase//>5</span>"
					if ss <> "" then
						if CDate(fechaReserva5) >= CDate(periodoDesde) and CDate(fechaReserva5) <= CDate(periodoA) then
							info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva5&"', 'nombre_cliente':'"&datos(2,l)&"', 'profesor':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha5&"', 'hora_inicio':'"&horaInicio5&"', 'hora_fin':'"&horaFin5&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'eliminar':'"&eliminarAgenda&actualizarAgenda&"', 'pagado':'"&estaPagado&"', 'numero_personas':'"&datos(40,l)&"', 'precio_renta':'"&formatcurrency(datos(36,l),2)&"'},"
						end if
					else
						info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva5&"', 'nombre_cliente':'"&datos(2,l)&"', 'profesor':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha5&"', 'hora_inicio':'"&horaInicio5&"', 'hora_fin':'"&horaFin5&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'eliminar':'"&eliminarAgenda&actualizarAgenda&"', 'pagado':'"&estaPagado&"', 'numero_personas':'"&datos(40,l)&"', 'precio_renta':'"&formatcurrency(datos(36,l),2)&"'},"
					end if
				end if

				cancha6 = datos(24,l)
				horaInicio6 = datos(26,l)
				horaFin6 = datos(27,l)
				fechaReserva6 = datos(25,l)

				'Clase no. 6
				if fechaReserva6 <> "1/1/1900" and cancha6 <> 0 and horaInicio6 <> "00:00:00" and horaFin6 <> "00:00:00" then
					numClaseSPAN = "<span class=//badge blue-grey// title=//6ta Clase//>6</span>"
					if ss <> "" then
						if CDate(fechaReserva6) >= CDate(periodoDesde) and CDate(fechaReserva6) <= CDate(periodoA) then
							info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva6&"', 'nombre_cliente':'"&datos(2,l)&"', 'profesor':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha6&"', 'hora_inicio':'"&horaInicio6&"', 'hora_fin':'"&horaFin6&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'eliminar':'"&eliminarAgenda&actualizarAgenda&"', 'pagado':'"&estaPagado&"', 'numero_personas':'"&datos(40,l)&"', 'precio_renta':'"&formatcurrency(datos(36,l),2)&"'},"
						end if
					else
						info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva6&"', 'nombre_cliente':'"&datos(2,l)&"', 'profesor':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha6&"', 'hora_inicio':'"&horaInicio6&"', 'hora_fin':'"&horaFin6&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'eliminar':'"&eliminarAgenda&actualizarAgenda&"', 'pagado':'"&estaPagado&"', 'numero_personas':'"&datos(40,l)&"', 'precio_renta':'"&formatcurrency(datos(36,l),2)&"'},"
					end if
				end if

				cancha7 = datos(28,l)
				horaInicio7 = datos(30,l)
				horaFin7 = datos(31,l)
				fechaReserva7 = datos(29,l)

				'Clase no. 7
				if fechaReserva7 <> "1/1/1900" and cancha7 <> 0 and horaInicio7 <> "00:00:00" and horaFin7 <> "00:00:00" then
					numClaseSPAN = "<span class=//badge blue-grey// title=//7ma Clase//>7</span>"
					if ss <> "" then
						if CDate(fechaReserva7) >= CDate(periodoDesde) and CDate(fechaReserva7) <= CDate(periodoA) then
							info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva7&"', 'nombre_cliente':'"&datos(2,l)&"', 'profesor':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha7&"', 'hora_inicio':'"&horaInicio7&"', 'hora_fin':'"&horaFin7&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'eliminar':'"&eliminarAgenda&actualizarAgenda&"', 'pagado':'"&estaPagado&"', 'numero_personas':'"&datos(40,l)&"', 'precio_renta':'"&formatcurrency(datos(36,l),2)&"'},"
						end if
					else
						info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva7&"', 'nombre_cliente':'"&datos(2,l)&"', 'profesor':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha7&"', 'hora_inicio':'"&horaInicio7&"', 'hora_fin':'"&horaFin7&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'eliminar':'"&eliminarAgenda&actualizarAgenda&"', 'pagado':'"&estaPagado&"', 'numero_personas':'"&datos(40,l)&"', 'precio_renta':'"&formatcurrency(datos(36,l),2)&"'},"
					end if
				end if


				cancha8 = datos(32,l)
				horaInicio8 = datos(34,l)
				horaFin8 = datos(35,l)
				fechaReserva8 = datos(33,l)

				'Clase no. 8
				if fechaReserva8 <> "1/1/1900" and cancha8 <> 0 and horaInicio8 <> "00:00:00" and horaFin8 <> "00:00:00" then
					numClaseSPAN = "<span class=//badge blue-grey// title=//8va Clase//>8</span>"
					if ss <> "" then
						if CDate(fechaReserva8) >= CDate(periodoDesde) and CDate(fechaReserva8) <= CDate(periodoA) then
							info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva8&"', 'nombre_cliente':'"&datos(2,l)&"', 'profesor':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha8&"', 'hora_inicio':'"&horaInicio8&"', 'hora_fin':'"&horaFin8&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'eliminar':'"&eliminarAgenda&actualizarAgenda&"', 'pagado':'"&estaPagado&"', 'numero_personas':'"&datos(40,l)&"', 'precio_renta':'"&formatcurrency(datos(36,l),2)&"'},"
						end if
					else
						info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva8&"', 'nombre_cliente':'"&datos(2,l)&"', 'profesor':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha8&"', 'hora_inicio':'"&horaInicio8&"', 'hora_fin':'"&horaFin8&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'eliminar':'"&eliminarAgenda&actualizarAgenda&"', 'pagado':'"&estaPagado&"', 'numero_personas':'"&datos(40,l)&"', 'precio_renta':'"&formatcurrency(datos(36,l),2)&"'},"
					end if
				end if
			end if 
			'Cierro el if tiposervicio = 3

		next

		info = left(info, len(info)-1)


	end if

	if Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
	On Error GoTo 0
   
end if

if comm = "cambiarEstatusAcademia" and idRegistro > 0 then
	ActualizarDatos tabla, "estatus_academia='"&optEstatus&"' ", "id='"&idRegistro&"' ", dominio
	info = "{'ok':'ok'}"
end if


' listar academia
if com = "listarAcademia" then
	
	if periodoDesde <> "" and periodoA <> "" then
		ss = " and ( cast(fecha_renta as date) >= '"&periodoDesde&"' and cast(fecha_renta as date) <= '"&periodoA&"' ) "&_
		" or ( cast(fecha_reservaC2 as date) >= '"&periodoDesde&"' and cast(fecha_reservaC2 as date) <= '"&periodoA&"' )"&_
		" or ( cast(fecha_reservaC3 as date) >= '"&periodoDesde&"' and cast(fecha_reservaC3 as date) <= '"&periodoA&"' )"&_
		" or ( cast(fecha_reservaC4 as date) >= '"&periodoDesde&"' and cast(fecha_reservaC4 as date) <= '"&periodoA&"' )"&_
		" or ( cast(fecha_reservaC5 as date) >= '"&periodoDesde&"' and cast(fecha_reservaC5 as date) <= '"&periodoA&"' )"&_
		" or ( cast(fecha_reservaC6 as date) >= '"&periodoDesde&"' and cast(fecha_reservaC6 as date) <= '"&periodoA&"' )"&_
		" or ( cast(fecha_reservaC7 as date) >= '"&periodoDesde&"' and cast(fecha_reservaC7 as date) <= '"&periodoA&"' )"&_
		" or ( cast(fecha_reservaC8 as date) >= '"&periodoDesde&"' and cast(fecha_reservaC8 as date) <= '"&periodoA&"' )"
	else
		ss = ""
	end if

     
	sql = "select id, estatus_academia, nombre_cliente, telefono, nivel_academia, grupo_asignado, fecha_inscripcion, ultima_fecha_pago, tipo_pago_academia, precio_renta, CONVERT(VARCHAR,fecha_renta,101), cancha_asignada2, CONVERT(VARCHAR,fecha_reservaC2,101), CONVERT(VARCHAR,hora_inicioC2,108), CONVERT(VARCHAR,hora_finC2,108), cancha_asignada3, CONVERT(VARCHAR,fecha_reservaC3,101), CONVERT(VARCHAR,hora_inicioC3,108), CONVERT(VARCHAR,hora_finC3,108), cancha_asignada4, CONVERT(VARCHAR,fecha_reservaC4,101), CONVERT(VARCHAR,hora_inicioC4,108), CONVERT(VARCHAR,hora_finC4,108), cancha_asignada5, CONVERT(VARCHAR,fecha_reservaC5,101), CONVERT(VARCHAR,hora_inicioC5,108), CONVERT(VARCHAR,hora_finC5,108), cancha_asignada6, CONVERT(VARCHAR,fecha_reservaC6,101), CONVERT(VARCHAR,hora_inicioC6,108), CONVERT(VARCHAR,hora_finC6,108), cancha_asignada7, CONVERT(VARCHAR,fecha_reservaC7,101), CONVERT(VARCHAR,hora_inicioC7,108), CONVERT(VARCHAR,hora_finC7,108), cancha_asignada8, CONVERT(VARCHAR,fecha_reservaC8,101), CONVERT(VARCHAR,hora_inicioC8,108), CONVERT(VARCHAR,hora_finC8,108) from agenda where estado = 1 and tipo_servicio=3 "&ss&" order by fecha_renta desc "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			estatus_academia = datos(1,l)
			if estatus_academia =  1 then
				estatus = "Activo"
				color  = "success"
			elseif estatus_academia = 2 then
				estatus = "Pendiente"
				color = "warning"
			end if

			tipo_pago = datos(8,l)
			if tipo_pago =  1 then
				tipoPago = "Mensual"
			elseif tipo_pago = 2 then
				tipoPago = "Bimestral"
			elseif tipo_pago = 3 then
				tipoPago = "Trimestral"
			elseif tipo_pago = 4 then
				tipoPago = "Semestral"
			elseif tipo_pago = 5 then
				tipoPago = "Anual"
			end if

			nivel_academia = datos(4,l)
			if nivel_academia = 1 then
				nivel_academia = "Básico"
			elseif nivel_academia = 2 then
				nivel_academia = "Intermendio"
			elseif nivel_academia = 3 then
				nivel_academia = "Avanzado"
			end if

			estatusSPAN = "<a onclick=javascript:cambiarEstatusAcademia("&datos(0,l)&","&datos(1,l)&")><span class=//badge "&color&"//>"&estatus&"</span></a>"

			verReservacionAcademia = "<a onclick=javascript:verAcademiaAgenda("&datos(0,l)&")><i class=//fa fa-calendar//></i></a>"

			

			numClaseSPAN = "<span class=//badge blue-grey// title=//1ra Clase//>1</span>"
			
			if ss <> "" then 'si viene de una busqueda comparamos la fecha de la 1ra clase para ver si la agregamos al listado
				if CDate(datos(10,l)) >= CDate(periodoDesde) and CDate(datos(10,l)) <= CDate(periodoA) then
				 	info = info & "{'id':'"&datos(0,l)&"', 'estatus_academia':'"&numClaseSPAN&estatusSPAN&"', 'nombre_cliente':'"&datos(2,l)&"', 'telefono':'"&datos(3,l)&"', 'nivel_academia':'"&nivel_academia&"', 'grupo_asignado':'"&datos(5,l)&"', 'fecha_inscripcion':'"&datos(6,l)&"', 'ultima_fecha_pago':'"&datos(7,l)&"', 'tipo_pago_academia':'"&tipoPago&"', 'precio_renta':'"&formatcurrency(datos(9,l),2)&"', 'verReservacionAcademia':'"&verReservacionAcademia&"', 'fecha_renta':'"&datos(10,l)&"'},"	
				end if
			else 'si no viene de una busqueda agregamos todos los registros al listado
				info = info & "{'id':'"&datos(0,l)&"', 'estatus_academia':'"&numClaseSPAN&estatusSPAN&"', 'nombre_cliente':'"&datos(2,l)&"', 'telefono':'"&datos(3,l)&"', 'nivel_academia':'"&nivel_academia&"', 'grupo_asignado':'"&datos(5,l)&"', 'fecha_inscripcion':'"&datos(6,l)&"', 'ultima_fecha_pago':'"&datos(7,l)&"', 'tipo_pago_academia':'"&tipoPago&"', 'precio_renta':'"&formatcurrency(datos(9,l),2)&"', 'verReservacionAcademia':'"&verReservacionAcademia&"', 'fecha_renta':'"&datos(10,l)&"'},"	
			end if




			cancha2 = datos(11,l)
			horaInicio2 = datos(13,l)
			horaFin2 = datos(14,l)
			fechaReserva2 = datos(12,l)
			
			'Clase no. 2
			if fechaReserva2 <> "1/1/1900" and cancha2 <> 0 and horaInicio2 <> "00:00:00" and horaFin2 <> "00:00:00" then
				numClaseSPAN = "<span class=//badge blue-grey// title=//2da Clase//>2</span>"
				if ss <> "" then
					if CDate(fechaReserva2) >= CDate(periodoDesde) and CDate(fechaReserva2) <= CDate(periodoA) then
						info = info & "{'id':'"&datos(0,l)&"', 'estatus_academia':'"&numClaseSPAN&estatusSPAN&"', 'nombre_cliente':'"&datos(2,l)&"', 'telefono':'"&datos(3,l)&"', 'nivel_academia':'"&nivel_academia&"', 'grupo_asignado':'"&datos(5,l)&"', 'fecha_inscripcion':'"&datos(6,l)&"', 'ultima_fecha_pago':'"&datos(7,l)&"', 'tipo_pago_academia':'"&tipoPago&"', 'precio_renta':'"&formatcurrency(datos(9,l),2)&"', 'verReservacionAcademia':'"&verReservacionAcademia&"', 'fecha_renta':'"&fechaReserva2&"'},"
					end if
				else
					info = info & "{'id':'"&datos(0,l)&"', 'estatus_academia':'"&numClaseSPAN&estatusSPAN&"', 'nombre_cliente':'"&datos(2,l)&"', 'telefono':'"&datos(3,l)&"', 'nivel_academia':'"&nivel_academia&"', 'grupo_asignado':'"&datos(5,l)&"', 'fecha_inscripcion':'"&datos(6,l)&"', 'ultima_fecha_pago':'"&datos(7,l)&"', 'tipo_pago_academia':'"&tipoPago&"', 'precio_renta':'"&formatcurrency(datos(9,l),2)&"', 'verReservacionAcademia':'"&verReservacionAcademia&"', 'fecha_renta':'"&fechaReserva2&"'},"
				end if
			end if

			cancha3 = datos(15,l)
			horaInicio3 = datos(17,l)
			horaFin3 = datos(18,l)
			fechaReserva3 = datos(16,l)

			'Clase no. 3
			if fechaReserva3 <> "1/1/1900" and cancha3 <> 0 and horaInicio3 <> "00:00:00" and horaFin3 <> "00:00:00" then
				numClaseSPAN = "<span class=//badge blue-grey// title=//3ra Clase//>3</span>"
				if ss <> "" then
					if CDate(fechaReserva3) >= CDate(periodoDesde) and CDate(fechaReserva3) <= CDate(periodoA) then
						info = info & "{'id':'"&datos(0,l)&"', 'estatus_academia':'"&numClaseSPAN&estatusSPAN&"', 'nombre_cliente':'"&datos(2,l)&"', 'telefono':'"&datos(3,l)&"', 'nivel_academia':'"&nivel_academia&"', 'grupo_asignado':'"&datos(5,l)&"', 'fecha_inscripcion':'"&datos(6,l)&"', 'ultima_fecha_pago':'"&datos(7,l)&"', 'tipo_pago_academia':'"&tipoPago&"', 'precio_renta':'"&formatcurrency(datos(9,l),2)&"', 'verReservacionAcademia':'"&verReservacionAcademia&"', 'fecha_renta':'"&fechaReserva3&"'},"	
					end if
				else
					info = info & "{'id':'"&datos(0,l)&"', 'estatus_academia':'"&numClaseSPAN&estatusSPAN&"', 'nombre_cliente':'"&datos(2,l)&"', 'telefono':'"&datos(3,l)&"', 'nivel_academia':'"&nivel_academia&"', 'grupo_asignado':'"&datos(5,l)&"', 'fecha_inscripcion':'"&datos(6,l)&"', 'ultima_fecha_pago':'"&datos(7,l)&"', 'tipo_pago_academia':'"&tipoPago&"', 'precio_renta':'"&formatcurrency(datos(9,l),2)&"', 'verReservacionAcademia':'"&verReservacionAcademia&"', 'fecha_renta':'"&fechaReserva3&"'},"
				end if
			end if

			cancha4 = datos(19,l)
			horaInicio4 = datos(21,l)
			horaFin4 = datos(22,l)
			fechaReserva4 = datos(20,l)

			'Clase no. 4
			if fechaReserva4 <> "1/1/1900" and cancha4 <> 0 and horaInicio4 <> "00:00:00" and horaFin4 <> "00:00:00" then
				numClaseSPAN = "<span class=//badge blue-grey// title=//4ta Clase//>4</span>"
				if ss <> "" then
					if CDate(fechaReserva4) >= CDate(periodoDesde) and CDate(fechaReserva4) <= CDate(periodoA) then
						info = info & "{'id':'"&datos(0,l)&"', 'estatus_academia':'"&numClaseSPAN&estatusSPAN&"', 'nombre_cliente':'"&datos(2,l)&"', 'telefono':'"&datos(3,l)&"', 'nivel_academia':'"&nivel_academia&"', 'grupo_asignado':'"&datos(5,l)&"', 'fecha_inscripcion':'"&datos(6,l)&"', 'ultima_fecha_pago':'"&datos(7,l)&"', 'tipo_pago_academia':'"&tipoPago&"', 'precio_renta':'"&formatcurrency(datos(9,l),2)&"', 'verReservacionAcademia':'"&verReservacionAcademia&"', 'fecha_renta':'"&fechaReserva4&"'},"	
					end if
				else
					info = info & "{'id':'"&datos(0,l)&"', 'estatus_academia':'"&numClaseSPAN&estatusSPAN&"', 'nombre_cliente':'"&datos(2,l)&"', 'telefono':'"&datos(3,l)&"', 'nivel_academia':'"&nivel_academia&"', 'grupo_asignado':'"&datos(5,l)&"', 'fecha_inscripcion':'"&datos(6,l)&"', 'ultima_fecha_pago':'"&datos(7,l)&"', 'tipo_pago_academia':'"&tipoPago&"', 'precio_renta':'"&formatcurrency(datos(9,l),2)&"', 'verReservacionAcademia':'"&verReservacionAcademia&"', 'fecha_renta':'"&fechaReserva4&"'},"
				end if
			end if


			cancha5 = datos(23,l)
			horaInicio5 = datos(25,l)
			horaFin5 = datos(26,l)
			fechaReserva5 = datos(24,l)

			'Clase no. 5
			if fechaReserva5 <> "1/1/1900" and cancha5 <> 0 and horaInicio5 <> "00:00:00" and horaFin5 <> "00:00:00" then
				numClaseSPAN = "<span class=//badge blue-grey// title=//5ta Clase//>5</span>"
				if ss <> "" then
					if CDate(fechaReserva5) >= CDate(periodoDesde) and CDate(fechaReserva5) <= CDate(periodoA) then
						info = info & "{'id':'"&datos(0,l)&"', 'estatus_academia':'"&numClaseSPAN&estatusSPAN&"', 'nombre_cliente':'"&datos(2,l)&"', 'telefono':'"&datos(3,l)&"', 'nivel_academia':'"&nivel_academia&"', 'grupo_asignado':'"&datos(5,l)&"', 'fecha_inscripcion':'"&datos(6,l)&"', 'ultima_fecha_pago':'"&datos(7,l)&"', 'tipo_pago_academia':'"&tipoPago&"', 'precio_renta':'"&formatcurrency(datos(9,l),2)&"', 'verReservacionAcademia':'"&verReservacionAcademia&"', 'fecha_renta':'"&fechaReserva5&"'},"	
					end if
				else
					info = info & "{'id':'"&datos(0,l)&"', 'estatus_academia':'"&numClaseSPAN&estatusSPAN&"', 'nombre_cliente':'"&datos(2,l)&"', 'telefono':'"&datos(3,l)&"', 'nivel_academia':'"&nivel_academia&"', 'grupo_asignado':'"&datos(5,l)&"', 'fecha_inscripcion':'"&datos(6,l)&"', 'ultima_fecha_pago':'"&datos(7,l)&"', 'tipo_pago_academia':'"&tipoPago&"', 'precio_renta':'"&formatcurrency(datos(9,l),2)&"', 'verReservacionAcademia':'"&verReservacionAcademia&"', 'fecha_renta':'"&fechaReserva5&"'},"
				end if
			end if

			cancha6 = datos(27,l)
			horaInicio6 = datos(29,l)
			horaFin6 = datos(30,l)
			fechaReserva6 = datos(28,l)

			'Clase no. 6
			if fechaReserva6 <> "1/1/1900" and cancha6 <> 0 and horaInicio6 <> "00:00:00" and horaFin6 <> "00:00:00" then
				numClaseSPAN = "<span class=//badge blue-grey// title=//6ta Clase//>6</span>"
				if ss <> "" then
					if CDate(fechaReserva6) >= CDate(periodoDesde) and CDate(fechaReserva6) <= CDate(periodoA) then
						info = info & "{'id':'"&datos(0,l)&"', 'estatus_academia':'"&numClaseSPAN&estatusSPAN&"', 'nombre_cliente':'"&datos(2,l)&"', 'telefono':'"&datos(3,l)&"', 'nivel_academia':'"&nivel_academia&"', 'grupo_asignado':'"&datos(5,l)&"', 'fecha_inscripcion':'"&datos(6,l)&"', 'ultima_fecha_pago':'"&datos(7,l)&"', 'tipo_pago_academia':'"&tipoPago&"', 'precio_renta':'"&formatcurrency(datos(9,l),2)&"', 'verReservacionAcademia':'"&verReservacionAcademia&"', 'fecha_renta':'"&fechaReserva6&"'},"	
					end if
				else
					info = info & "{'id':'"&datos(0,l)&"', 'estatus_academia':'"&numClaseSPAN&estatusSPAN&"', 'nombre_cliente':'"&datos(2,l)&"', 'telefono':'"&datos(3,l)&"', 'nivel_academia':'"&nivel_academia&"', 'grupo_asignado':'"&datos(5,l)&"', 'fecha_inscripcion':'"&datos(6,l)&"', 'ultima_fecha_pago':'"&datos(7,l)&"', 'tipo_pago_academia':'"&tipoPago&"', 'precio_renta':'"&formatcurrency(datos(9,l),2)&"', 'verReservacionAcademia':'"&verReservacionAcademia&"', 'fecha_renta':'"&fechaReserva6&"'},"
				end if
			end if


			cancha7 = datos(31,l)
			horaInicio7 = datos(33,l)
			horaFin7 = datos(34,l)
			fechaReserva7 = datos(32,l)

			'Clase no. 7
			if fechaReserva7 <> "1/1/1900" and cancha7 <> 0 and horaInicio7 <> "00:00:00" and horaFin7 <> "00:00:00" then
				numClaseSPAN = "<span class=//badge blue-grey// title=//7ma Clase//>7</span>"
				if ss <> "" then
					if CDate(fechaReserva7) >= CDate(periodoDesde) and CDate(fechaReserva7) <= CDate(periodoA) then
						info = info & "{'id':'"&datos(0,l)&"', 'estatus_academia':'"&numClaseSPAN&estatusSPAN&"', 'nombre_cliente':'"&datos(2,l)&"', 'telefono':'"&datos(3,l)&"', 'nivel_academia':'"&nivel_academia&"', 'grupo_asignado':'"&datos(5,l)&"', 'fecha_inscripcion':'"&datos(6,l)&"', 'ultima_fecha_pago':'"&datos(7,l)&"', 'tipo_pago_academia':'"&tipoPago&"', 'precio_renta':'"&formatcurrency(datos(9,l),2)&"', 'verReservacionAcademia':'"&verReservacionAcademia&"', 'fecha_renta':'"&fechaReserva7&"'},"	
					end if
				else
					info = info & "{'id':'"&datos(0,l)&"', 'estatus_academia':'"&numClaseSPAN&estatusSPAN&"', 'nombre_cliente':'"&datos(2,l)&"', 'telefono':'"&datos(3,l)&"', 'nivel_academia':'"&nivel_academia&"', 'grupo_asignado':'"&datos(5,l)&"', 'fecha_inscripcion':'"&datos(6,l)&"', 'ultima_fecha_pago':'"&datos(7,l)&"', 'tipo_pago_academia':'"&tipoPago&"', 'precio_renta':'"&formatcurrency(datos(9,l),2)&"', 'verReservacionAcademia':'"&verReservacionAcademia&"', 'fecha_renta':'"&fechaReserva7&"'},"
				end if
			end if

			cancha8 = datos(35,l)
			horaInicio8 = datos(37,l)
			horaFin8 = datos(38,l)
			fechaReserva8 = datos(36,l)

			'Clase no. 8
			if fechaReserva8 <> "1/1/1900" and cancha8 <> 0 and horaInicio8 <> "00:00:00" and horaFin8 <> "00:00:00" then
				numClaseSPAN = "<span class=//badge blue-grey// title=//8va Clase//>8</span>"
				if ss <> "" then
					if CDate(fechaReserva8) >= CDate(periodoDesde) and CDate(fechaReserva8) <= CDate(periodoA) then
						info = info & "{'id':'"&datos(0,l)&"', 'estatus_academia':'"&numClaseSPAN&estatusSPAN&"', 'nombre_cliente':'"&datos(2,l)&"', 'telefono':'"&datos(3,l)&"', 'nivel_academia':'"&nivel_academia&"', 'grupo_asignado':'"&datos(5,l)&"', 'fecha_inscripcion':'"&datos(6,l)&"', 'ultima_fecha_pago':'"&datos(7,l)&"', 'tipo_pago_academia':'"&tipoPago&"', 'precio_renta':'"&formatcurrency(datos(9,l),2)&"', 'verReservacionAcademia':'"&verReservacionAcademia&"', 'fecha_renta':'"&fechaReserva8&"'},"	
					end if
				else
					info = info & "{'id':'"&datos(0,l)&"', 'estatus_academia':'"&numClaseSPAN&estatusSPAN&"', 'nombre_cliente':'"&datos(2,l)&"', 'telefono':'"&datos(3,l)&"', 'nivel_academia':'"&nivel_academia&"', 'grupo_asignado':'"&datos(5,l)&"', 'fecha_inscripcion':'"&datos(6,l)&"', 'ultima_fecha_pago':'"&datos(7,l)&"', 'tipo_pago_academia':'"&tipoPago&"', 'precio_renta':'"&formatcurrency(datos(9,l),2)&"', 'verReservacionAcademia':'"&verReservacionAcademia&"', 'fecha_renta':'"&fechaReserva8&"'},"
				end if
			end if


			
		next

		info = left(info, len(info)-1)


	end if
   
end if

' buscamos las reservaciones del id registro seleccionado
if comm = "buscarReservacionAcademia" then	    
     
	sql = "select id, fecha_renta, nombre_cliente, cancha_asignada, CONVERT(VARCHAR,hora_inicio,108), CONVERT(VARCHAR,hora_fin,108), cancha_asignada2, fecha_reservaC2, CONVERT(VARCHAR,hora_inicioC2,108), CONVERT(VARCHAR,hora_finC2,108), cancha_asignada3, fecha_reservaC3, CONVERT(VARCHAR,hora_inicioC3,108), CONVERT(VARCHAR,hora_finC3,108), cancha_asignada4, fecha_reservaC4, CONVERT(VARCHAR,hora_inicioC4,108), CONVERT(VARCHAR,hora_finC4,108), cancha_asignada5, fecha_reservaC5, CONVERT(VARCHAR,hora_inicioC5,108), CONVERT(VARCHAR,hora_finC5,108), cancha_asignada6, fecha_reservaC6, CONVERT(VARCHAR,hora_inicioC6,108), CONVERT(VARCHAR,hora_finC6,108), cancha_asignada7, fecha_reservaC7, CONVERT(VARCHAR,hora_inicioC7,108), CONVERT(VARCHAR,hora_finC7,108), cancha_asignada8, fecha_reservaC8, CONVERT(VARCHAR,hora_inicioC8,108), CONVERT(VARCHAR,hora_finC8,108) from agenda where id = '"&idRegistro&"' "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'clase':'1', 'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"	

			cancha2 = datos(6,l)
			horaInicio2 = datos(8,l)
			horaFin2 = datos(9,l)

			'Clase no. 2
			if datos(7,l) <> "1/1/1900" and cancha2 <> 0 and horaInicio2 <> "00:00:00" and horaFin2 <> "00:00:00" then
				info = info & "{'clase':'2', 'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(7,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(6,l)&"', 'hora_inicio':'"&datos(8,l)&"', 'hora_fin':'"&datos(9,l)&"'},"
			end if

			cancha3 = datos(10,l)
			horaInicio3 = datos(12,l)
			horaFin3 = datos(13,l)

			'Clase no. 3
			if datos(11,l) <> "1/1/1900" and cancha3 <> 0 and horaInicio3 <> "00:00:00" and horaFin3 <> "00:00:00" then
				info = info & "{'clase':'3', 'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(11,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(10,l)&"', 'hora_inicio':'"&datos(12,l)&"', 'hora_fin':'"&datos(13,l)&"'},"
			end if

			cancha4 = datos(14,l)
			horaInicio4 = datos(16,l)
			horaFin4 = datos(17,l)
			
			'Clase no. 4
			if datos(15,l) <> "1/1/1900" and cancha4 <> 0 and horaInicio4 <> "00:00:00" and horaFin4 <> "00:00:00" then
				info = info & "{'clase':'4', 'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(15,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(14,l)&"', 'hora_inicio':'"&datos(16,l)&"', 'hora_fin':'"&datos(17,l)&"'},"
			end if

			cancha5 = datos(18,l)
			horaInicio5 = datos(20,l)
			horaFin5 = datos(21,l)

			'Clase no. 5
			if datos(19,l) <> "1/1/1900" and cancha5 <> 0 and horaInicio5 <> "00:00:00" and horaFin5 <> "00:00:00" then
				info = info & "{'clase':'5', 'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(19,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(18,l)&"', 'hora_inicio':'"&datos(20,l)&"', 'hora_fin':'"&datos(21,l)&"'},"
			end if

			cancha6 = datos(22,l)
			horaInicio6 = datos(24,l)
			horaFin6 = datos(25,l)

			'Clase no. 6
			if datos(23,l) <> "1/1/1900" and cancha6 <> 0 and horaInicio6 <> "00:00:00" and horaFin6 <> "00:00:00" then
				info = info & "{'clase':'6', 'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(23,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(22,l)&"', 'hora_inicio':'"&datos(24,l)&"', 'hora_fin':'"&datos(25,l)&"'},"
			end if

			cancha7 = datos(26,l)
			horaInicio7 = datos(28,l)
			horaFin7 = datos(29,l)

			'Clase no. 7
			if datos(27,l) <> "1/1/1900" and cancha7 <> 0 and horaInicio7 <> "00:00:00" and horaFin7 <> "00:00:00" then
				info = info & "{'clase':'7', 'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(27,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(26,l)&"', 'hora_inicio':'"&datos(28,l)&"', 'hora_fin':'"&datos(29,l)&"'},"
			end if

			cancha8 = datos(30,l)
			horaInicio8 = datos(32,l)
			horaFin8 = datos(33,l)

			'Clase no. 8
			if datos(31,l) <> "1/1/1900" and cancha8 <> 0 and horaInicio8 <> "00:00:00" and horaFin8 <> "00:00:00" then
				info = info & "{'clase':'8', 'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(31,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(30,l)&"', 'hora_inicio':'"&datos(32,l)&"', 'hora_fin':'"&datos(33,l)&"'},"
			end if

		next
		info = left(info, len(info)-1)
	else
		info = "{'ok':'noOk'}"
	end if

end if



' obtener calendario
if comm = "getCalendario" then	    
     
	sql = "select id, CONVERT(VARCHAR,fecha_renta,111), nombre_cliente, cancha_asignada, CONVERT(VARCHAR,hora_inicio,100), CONVERT(VARCHAR,hora_fin,100) from agenda where estado = 1 and cancha_asignada=1 order by fecha_renta desc "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)

			horaInicio = datos(4,l)
			hi = replace(horaInicio, "Jan  1 1900  ","") 
			hi = replace(hi, "Jan  1 1900 ","")
			horaFinal = datos(5,l)
			hof = replace(horaFinal, "Jan  1 1900  ","") 
			hof = replace(hof, "Jan  1 1900 ","")
			
			dia = Replace(datos(1,l), "/","-")
			


			info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'description':'"&"Cancha: "&datos(3,l)&"', 'start':'"&dia&" "&hi&"', 'end':'"&dia&" "&hof&"', 'status':'true'},"	
		next

		info = left(info, len(info)-1)

		set fs=Server.CreateObject("Scripting.FileSystemObject") 
        filePath = Server.MapPath("\scripts\plugins\dist\horario.json")
        set f=fs.CreateTextFile(filePath,true)
        info1 = "["&info&"]"
        info1 = Replace(info1, "'", chr(34)) 
        f.write(info1)
        f.close
        set f=nothing
        set fs=nothing 

	end if
   
end if


' buscamos si existe una reservacion para el día, cancha y hora seleccionada
if comm = "verificarHorario" then	
	' response.Write(idRegistro)
	' response.write(txthorarioInicioC1)
	' response.write(txthorarioFinC1)
	' response.write(optCanchaAsignada1)    
     
	sql = "select id, CONVERT(VARCHAR,fecha_renta,101), nombre_cliente, cancha_asignada, CONVERT(VARCHAR,hora_inicio,108), CONVERT(VARCHAR,hora_fin,108) from agenda where cast(fecha_renta as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada = '"&optCanchaAsignada1&"' and estado=1 and id <> '"&idRegistro&"' and "&_
	   " ( (cast('"&txthorarioInicioC1&"' as time) >= cast(hora_inicio as time) and cast('"&txthorarioInicioC1&"' as time) < cast(hora_fin as time) ) "&_
	   "or (cast('"&txthorarioFinC1&"' as time) > cast(hora_inicio as time) and cast('"&txthorarioFinC1&"' as time) < cast(hora_fin as time) )) "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		info = info & "{'ok':'noOk', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"
	' else
	' 	info = "{'ok':'ok'}"
	end if


	'buscamos los horarios del tipo servicio = academia para revisar si no existen fechas y canchas que se buscan
	' ****** CLASE 2 *****
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC2,101), nombre_cliente, cancha_asignada2, CONVERT(VARCHAR,hora_inicioC2,108), CONVERT(VARCHAR,hora_finC2,108) from agenda where cast(fecha_reservaC2 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada2 = '"&optCanchaAsignada1&"' and estado=1 and id <> '"&idRegistro&"' and "&_
		"( (cast('"&txthorarioInicioC1&"' as time) >= cast(hora_inicioC2 as time) and cast('"&txthorarioInicioC1&"' as time) < cast(hora_finC2 as time) ) "&_
	   "or (cast('"&txthorarioFinC1&"' as time) > cast(hora_inicioC2 as time) and cast('"&txthorarioFinC1&"' as time) < cast(hora_finC2 as time) )) "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'noOk', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"	
		next
		'info = left(info, len(info)-1)
	end if

	' ***** CLASE 3 *****
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC3,101), nombre_cliente, cancha_asignada3, CONVERT(VARCHAR,hora_inicioC3,108), CONVERT(VARCHAR,hora_finC3,108) from agenda where cast(fecha_reservaC3 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada3 = '"&optCanchaAsignada1&"' and estado=1 and id <> '"&idRegistro&"' and "&_
		" ( (cast('"&txthorarioInicioC1&"' as time) >= cast(hora_inicioC3 as time) and cast('"&txthorarioInicioC1&"' as time) < cast(hora_finC3 as time) ) "&_
	   "or (cast('"&txthorarioFinC1&"' as time) > cast(hora_inicioC3 as time) and cast('"&txthorarioFinC1&"' as time) < cast(hora_finC3 as time) )) "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'noOk', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"	
		next
		'info = left(info, len(info)-1)
	end if

	'****** CLASE 4 ******
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC4,101), nombre_cliente, cancha_asignada4, CONVERT(VARCHAR,hora_inicioC4,108), CONVERT(VARCHAR,hora_finC4,108) from agenda where cast(fecha_reservaC4 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada4 = '"&optCanchaAsignada1&"' and estado=1 and id <> '"&idRegistro&"' and "&_
		" ( (cast('"&txthorarioInicioC1&"' as time) >= cast(hora_inicioC4 as time) and cast('"&txthorarioInicioC1&"' as time) < cast(hora_finC4 as time) ) "&_
	   "or (cast('"&txthorarioFinC1&"' as time) > cast(hora_inicioC4 as time) and cast('"&txthorarioFinC1&"' as time) < cast(hora_finC4 as time) )) "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'noOk', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"	
		next
		'info = left(info, len(info)-1)
	end if 

	' ******* CLASE 5 *******
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC5,101), nombre_cliente, cancha_asignada5, CONVERT(VARCHAR,hora_inicioC5,108), CONVERT(VARCHAR,hora_finC5,108) from agenda where cast(fecha_reservaC5 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada5 = '"&optCanchaAsignada1&"' and estado=1 and id <> '"&idRegistro&"' and "&_
		" ( (cast('"&txthorarioInicioC1&"' as time) >= cast(hora_inicioC5 as time) and cast('"&txthorarioInicioC1&"' as time) < cast(hora_finC5 as time) ) "&_
	   "or (cast('"&txthorarioFinC1&"' as time) > cast(hora_inicioC5 as time) and cast('"&txthorarioFinC1&"' as time) < cast(hora_finC5 as time) )) "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'noOk', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"	
		next
		'info = left(info, len(info)-1)
	end if

	' ******* CLASE 6 *******
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC6,101), nombre_cliente, cancha_asignada6, CONVERT(VARCHAR,hora_inicioC6,108), CONVERT(VARCHAR,hora_finC6,108) from agenda where cast(fecha_reservaC6 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada6 = '"&optCanchaAsignada1&"' and estado=1 and id <> '"&idRegistro&"' and "&_
		" ( (cast('"&txthorarioInicioC1&"' as time) >= cast(hora_inicioC6 as time) and cast('"&txthorarioInicioC1&"' as time) < cast(hora_finC6 as time) ) "&_
	   "or (cast('"&txthorarioFinC1&"' as time) > cast(hora_inicioC6 as time) and cast('"&txthorarioFinC1&"' as time) < cast(hora_finC6 as time) )) "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'noOk', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"	
		next
		'info = left(info, len(info)-1)
	end if

	' ****** CLASE 7 ******
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC7,101), nombre_cliente, cancha_asignada7, CONVERT(VARCHAR,hora_inicioC7,108), CONVERT(VARCHAR,hora_finC7,108) from agenda where cast(fecha_reservaC7 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada7 = '"&optCanchaAsignada1&"' and estado=1 and id <> '"&idRegistro&"' and "&_
		" ( (cast('"&txthorarioInicioC1&"' as time) >= cast(hora_inicioC7 as time) and cast('"&txthorarioInicioC1&"' as time) < cast(hora_finC7 as time) ) "&_
	   "or (cast('"&txthorarioFinC1&"' as time) > cast(hora_inicioC7 as time) and cast('"&txthorarioFinC1&"' as time) < cast(hora_finC7 as time) )) "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'noOk', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"	
		next
		'info = left(info, len(info)-1)
	end if

	' ****** CLASE 8 ******
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC8,101), nombre_cliente, cancha_asignada8, CONVERT(VARCHAR,hora_inicioC8,108), CONVERT(VARCHAR,hora_finC8,108) from agenda where cast(fecha_reservaC8 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada8 = '"&optCanchaAsignada1&"' and estado=1 and id <> '"&idRegistro&"' and "&_
		" ( (cast('"&txthorarioInicioC1&"' as time) >= cast(hora_inicioC8 as time) and cast('"&txthorarioInicioC1&"' as time) < cast(hora_finC8 as time) ) "&_
	   "or (cast('"&txthorarioFinC1&"' as time) > cast(hora_inicioC8 as time) and cast('"&txthorarioFinC1&"' as time) < cast(hora_finC8 as time) )) "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'noOk', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"	
		next
		'info = left(info, len(info)-1)
	end if

	if info <> "" then
		info = left(info, len(info)-1)
	else
		info = "{'ok':'ok'}"
   	end if
   
end if


' buscamos las reservaciones del día y cancha seleccionada
if comm = "buscarReservacion" then	    
     
	sql = "select id, fecha_renta, nombre_cliente, cancha_asignada, CONVERT(VARCHAR,hora_inicio,108), CONVERT(VARCHAR,hora_fin,108) from agenda where cast(fecha_renta as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada = '"&optCanchaAsignada1&"' and estado=1 and id <> '"&idRegistro&"' order by fecha_renta asc "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"	
		next
		'info = left(info, len(info)-1)
	' else
	' 	info = "{'ok':'noOk'}"
	end if


	'buscamos los horarios del tipo servicio = academia para revisar si no existen fechas y canchas que se buscan
	' ****** CLASE 2 *****
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC2,101), nombre_cliente, cancha_asignada2, CONVERT(VARCHAR,hora_inicioC2,108), CONVERT(VARCHAR,hora_finC2,108) from agenda where cast(fecha_reservaC2 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada2 = '"&optCanchaAsignada1&"' and tipo_servicio = 3 and estado=1 and id <> '"&idRegistro&"' order by fecha_renta asc "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"	
		next
		'info = left(info, len(info)-1)
	end if

	' ***** CLASE 3 *****
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC3,101), nombre_cliente, cancha_asignada3, CONVERT(VARCHAR,hora_inicioC3,108), CONVERT(VARCHAR,hora_finC3,108) from agenda where cast(fecha_reservaC3 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada3 = '"&optCanchaAsignada1&"' and tipo_servicio = 3 and estado=1 and id <> '"&idRegistro&"' order by fecha_renta asc "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"	
		next
		'info = left(info, len(info)-1)
	end if

	'****** CLASE 4 ******
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC4,101), nombre_cliente, cancha_asignada4, CONVERT(VARCHAR,hora_inicioC4,108), CONVERT(VARCHAR,hora_finC4,108) from agenda where cast(fecha_reservaC4 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada4 = '"&optCanchaAsignada1&"' and tipo_servicio = 3 and estado=1 and id <> '"&idRegistro&"'order by fecha_renta asc "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"	
		next
		'info = left(info, len(info)-1)
	end if 

	' ******* CLASE 5 *******
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC5,101), nombre_cliente, cancha_asignada5, CONVERT(VARCHAR,hora_inicioC5,108), CONVERT(VARCHAR,hora_finC5,108) from agenda where cast(fecha_reservaC5 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada5 = '"&optCanchaAsignada1&"' and tipo_servicio = 3 and estado=1 and id <> '"&idRegistro&"' order by fecha_renta asc "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"	
		next
		'info = left(info, len(info)-1)
	end if

	' ******* CLASE 6 *******
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC6,101), nombre_cliente, cancha_asignada6, CONVERT(VARCHAR,hora_inicioC6,108), CONVERT(VARCHAR,hora_finC6,108) from agenda where cast(fecha_reservaC6 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada6 = '"&optCanchaAsignada1&"' and tipo_servicio = 3 and estado=1 and id <> '"&idRegistro&"' order by fecha_renta asc "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"	
		next
		'info = left(info, len(info)-1)
	end if

	' ****** CLASE 7 ******
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC7,101), nombre_cliente, cancha_asignada7, CONVERT(VARCHAR,hora_inicioC7,108), CONVERT(VARCHAR,hora_finC7,108) from agenda where cast(fecha_reservaC7 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada7 = '"&optCanchaAsignada1&"' and tipo_servicio = 3 and estado=1 and id <> '"&idRegistro&"' order by fecha_renta asc "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"	
		next
		'info = left(info, len(info)-1)
	end if

	' ****** CLASE 8 ******
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC8,101), nombre_cliente, cancha_asignada8, CONVERT(VARCHAR,hora_inicioC8,108), CONVERT(VARCHAR,hora_finC8,108) from agenda where cast(fecha_reservaC8 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada8 = '"&optCanchaAsignada1&"' and tipo_servicio = 3 and estado=1 and id <> '"&idRegistro&"' order by fecha_renta asc "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"	
		next
		'info = left(info, len(info)-1)
	end if





	if info <> "" then
		info = left(info, len(info)-1)
	else
		info = "{'ok':'noOk'}"
   	end if

end if


' buscamos si existe una reservacion para el día, cancha y hora seleccionada del tipo ACADEMIA
if comm = "verificarHorariosAcademia" then   
	x = 0
    for i=1 to 8
    	if i = 1 then
    		txtFechaReservaC = txtFechaReservaC1
    		optCanchaAsignada = optCanchaAsignada1
    		txthorarioInicio = txthorarioInicioC1
    		txthorarioFin =  txthorarioFinC1	
    	elseif i = 2 then
    		txtFechaReservaC = txtFechaReservaC2
    		optCanchaAsignada = optCanchaAsignada2
    		txthorarioInicio = txthorarioInicioC2
    		txthorarioFin =  txthorarioFinC2
    	elseif i = 3 then
    		txtFechaReservaC = txtFechaReservaC3
    		optCanchaAsignada = optCanchaAsignada3
    		txthorarioInicio = txthorarioInicioC3
    		txthorarioFin =  txthorarioFinC3
    	elseif i = 4 then
    		txtFechaReservaC = txtFechaReservaC4
    		optCanchaAsignada = optCanchaAsignada4
    		txthorarioInicio = txthorarioInicioC4
    		txthorarioFin =  txthorarioFinC4
    	elseif i = 5 then
    		txtFechaReservaC = txtFechaReservaC5
    		optCanchaAsignada = optCanchaAsignada5
    		txthorarioInicio = txthorarioInicioC5
    		txthorarioFin =  txthorarioFinC5
    	elseif i = 6 then
    		txtFechaReservaC = txtFechaReservaC6
    		optCanchaAsignada = optCanchaAsignada6
    		txthorarioInicio = txthorarioInicioC6
    		txthorarioFin =  txthorarioFinC6
    	elseif i = 7 then
    		txtFechaReservaC = txtFechaReservaC7
    		optCanchaAsignada = optCanchaAsignada7
    		txthorarioInicio = txthorarioInicioC7
    		txthorarioFin =  txthorarioFinC7
    	elseif i = 8 then
    		txtFechaReservaC = txtFechaReservaC8
    		optCanchaAsignada = optCanchaAsignada8
    		txthorarioInicio = txthorarioInicioC8
    		txthorarioFin =  txthorarioFinC8
    	end if

    	if txtFechaReservaC <> "" then

    		sql = "select id, fecha_renta, nombre_cliente, cancha_asignada, CONVERT(VARCHAR,hora_inicio,108), CONVERT(VARCHAR,hora_fin,108) from agenda where cast(fecha_renta as date) = cast('"&txtFechaReservaC&"' as date) and cancha_asignada = '"&optCanchaAsignada&"' and estado=1 and id <> '"&idRegistro&"' and "&_
	   			" ( (cast('"&txthorarioInicio&"' as time) >= cast(hora_inicio as time) and cast('"&txthorarioInicio&"' as time) < cast(hora_fin as time) ) "&_
	   			"or (cast('"&txthorarioFin&"' as time) > cast(hora_inicio as time) and cast('"&txthorarioFin&"' as time) < cast(hora_fin as time) )) "
			datos = executee(sql,dominio)
		
			if not IsEmpty(datos) then
				l = 0
				info = info & "{'clase':'"&i&"', 'ok':'noOk', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"
				x = x + 1
			end if
		end if
    next 
	
	if info <> "" then
		info = left(info, len(info)-1)
	end if

	if x = 0 then
		info = "{'ok':'ok'}"
	end if
   
end if

if comm = "obtienePrecioRenta" and idRegistro > 0 then
	sql = "select id, nombre_cliente, telefono, precio_renta, observaciones, descuento, fecha_pago, playtomic, transferencia, tarjeta, deposito, efectivo from agenda where id='"&idRegistro&"' "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = "{'ok':'ok',  'id':'"&datos(0,l)&"', 'nombre_cliente':'"&datos(1,l)&"', 'telefono':'"&datos(2,l)&"', 'precio_renta':'"&datos(3,l)&"', 'observaciones':'"&datos(4,l)&"', 'descuento':'"&datos(5,l)&"', 'fecha_pago':'"&datos(6,l)&"', 'playtomic':'"&datos(7,l)&"', 'transferencia':'"&datos(8,l)&"', 'tarjeta':'"&datos(9,l)&"', 'deposito':'"&datos(10,l)&"', 'efectivo':'"&datos(11,l)&"'}"	
		next

	end if
end if	


if comm = "buscaUsuarioParaEliminarRegistro" and idRegistro <> "" then
	sql = "select id, nombre from admin_usuarios where clave='"&idRegistro&"' and tipo = 1 "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		info = "{'ok':'ok'}"	
	else
		info = "{'ok':'noOk'}"	
	end if
end if	

'realizar pago de agenda
if comm = "realizarPago" and idRegistro > 0 then
	camposActualizar = " precio_renta='"&txtPrecioRenta&"', pagado=1, fecha_pago=getdate(), descuento='"&txtDescuento&"', playtomic='"&txtPlayTomic&"', transferencia='"&txtTransferencia&"', tarjeta='"&txtTarjeta&"', deposito='"&txtDeposito&"', efectivo='"&txtEfectivo&"'  "
	ActualizarDatos tabla, camposActualizar, "id='"&idRegistro&"' ", dominio
	info = "{'ok':'ok'}"

end if

respuesta = "{'data':["&info&"]}"
respuesta = Replace(respuesta, "'", chr(34))
respuesta = replace(respuesta,"//","'")
response.Write(respuesta)
%>