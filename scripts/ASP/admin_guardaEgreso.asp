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
 txtEgConcepto  = Request.form("txtEgConcepto")
 txtEgDescripcion  = request.form("txtEgDescripcion")
 txtEgFecha = request.form("txtEgFecha")
 optTipoGasto = request.form("optTipoGasto")
 optFrecuencia = request.form("optFrecuencia")
 txtProveedor = request.form("txtProveedor")
 txtEgResponsable = request.form("txtEgResponsable")
 txtEgCosto = request.form("txtEgCosto")
 txtEgConceptoTotal =  request.form("txtEgConceptoTotal")
 txtEgTotal =  request.form("txtEgTotal")

 periodoDesde = request.QueryString("de")
periodoA = request.QueryString("a")


 comm = request.form("comm")
 idRegistro = request.form("idReg")
 com = request.queryString("com")

camposs = "concepto, descripcion, fecha_realizo, tipo_egreso, frecuencia_egreso, justificacion, responsable, costo_unitario, cantidad_total, egreso_total, id_usuario, estatus"
datoss =" '"&txtEgConcepto&"', '"&txtEgDescripcion&"', '"&txtEgFecha&"', '"&optTipoGasto&"', '"&optFrecuencia&"', '"&txtProveedor&"', '"&txtEgResponsable&"', '"&txtEgCosto&"', '"&txtEgConceptoTotal&"', '"&txtEgTotal&"','"&idUser&"', '1' "

tabla = "admin_egresos"

'nuevo registro de ingreso
if comm = "nuevoEgreso" then

	if idRegistro = 0 then
		guardarDatos tabla, camposs, datoss, dominio
		info = "{'ok':'ok'}"

	end if
end if


if comm = "eliminarRegistro" and idRegistro > 0 then
	ActualizarDatos tabla, "estatus=0, fecha_baja=getdate(), id_usuario_baja="&idUser&" ", "id='"&idRegistro&"' ", dominio
	info = "{'ok':'ok'}"
end if

' listar egresos
if com = "listarEgresos" then
	if periodoDesde <> "" and periodoA <> "" then
	  ss = " and ( cast(fecha_realizo as date) >= '"&periodoDesde&"' and cast(fecha_realizo as date) <= '"&periodoA&"' )"
	else
	  ss = " and ( month(fecha_realizo) = MONTH(getdate()) ) "
	end if

	sql = "select id, concepto, descripcion, CONVERT(VARCHAR,fecha_realizo,101), tipo_egreso, frecuencia_egreso, justificacion, responsable, costo_unitario, cantidad_total, egreso_total from admin_egresos where estatus = 1 "&ss&" order by fecha_realizo desc "
	datos = executee(sql,dominio)

	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			tipo_egreso = datos(4,l)
			if tipo_egreso =  1 then
				tipo_egreso = "Fijo"
				'color  = "success"
			elseif tipo_egreso = 2 then
				tipo_egreso = "Variable"
				'color = "primary"
			end if

  		tipo_frecuencia = datos(5,l)
  		if tipo_frecuencia =  1 then
  			 tipo_frecuencia = "Diario"
			elseif tipo_frecuencia = 2 then
  			 tipo_frecuencia = "Semanal"
      elseif tipo_frecuencia = 3 then
    		 tipo_frecuencia = "Quincenal"
      elseif tipo_frecuencia = 4 then
      	 tipo_frecuencia = "Mensual"
      elseif tipo_frecuencia = 5 then
         tipo_frecuencia = "Bimenstral"
      elseif tipo_frecuencia = 6 then
         tipo_frecuencia = "Semestral"
      elseif tipo_frecuencia = 7 then
      	 tipo_frecuencia = "Anual"
      elseif tipo_frecuencia = 8 then
    		 tipo_frecuencia = "Indefinido"
  				'color = "primary"
  			end if

		'	tipo_servicioSPAN = "<span class=//badge badge-pill "&color&"//>"&tipo_servicio&"</span>"

     eliminarRegistro = "<button class=//md-btn md-raised mb-2 w-xs blue// onclick=javascript:eliminarRegistro("&datos(0,l)&")><i class=//fa fa-trash//></i></button>"

     egresoTotal = CDbl(egresoTotal) + CDbl(datos(10,l))

			info = info & "{'id':'"&datos(0,l)&"', 'concepto':'"&datos(1,l)&"', 'descripcion':'"&datos(2,l)&"', 'fecha_realizo':'"&datos(3,l)&"', 'tipo_egreso':'"&tipo_egreso&"', 'frecuencia_egreso':'"&tipo_frecuencia&"', 'justificacion':'"&datos(6,l)&"','responsable':'"&datos(7,l)&"', 'costo_unitario':'"&formatcurrency(datos(8,l),2)&"', 'cantidad_total':'"&datos(9,l)&"', 'egreso_total':'"&formatcurrency(datos(10,l),2)&"', 'eliminar': '"&eliminarRegistro&"', 'egresoTotal':'"&formatcurrency(egresoTotal,2)&"', 'ok':'ok'},"
		next

		info = left(info, len(info)-1)


	end if

end if



' listar egresos eliminados, historico
if com = "listarEgresosEliminados" then

	sql = "select id, concepto, descripcion, CONVERT(VARCHAR,fecha_realizo,101), tipo_egreso, frecuencia_egreso, justificacion, responsable, costo_unitario, cantidad_total, egreso_total, CONVERT(VARCHAR,fecha_baja,101) from admin_egresos where estatus = 0 order by fecha_realizo desc "
	datos = executee(sql,dominio)

	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			tipo_egreso = datos(4,l)
			if tipo_egreso =  1 then
				tipo_egreso = "Fijo"
				'color  = "success"
			elseif tipo_egreso = 2 then
				tipo_egreso = "Variable"
				'color = "primary"
			end if
      tipo_frecuencia = datos(5,l)
      if tipo_frecuencia =  1 then
         tipo_frecuencia = "Diario"
      elseif tipo_frecuencia = 2 then
         tipo_frecuencia = "Semanal"
      elseif tipo_frecuencia = 3 then
         tipo_frecuencia = "Quincenal"
      elseif tipo_frecuencia = 4 then
         tipo_frecuencia = "Mensual"
      elseif tipo_frecuencia = 5 then
         tipo_frecuencia = "Bimenstral"
      elseif tipo_frecuencia = 6 then
         tipo_frecuencia = "Semestral"
      elseif tipo_frecuencia = 7 then
         tipo_frecuencia = "Anual"
      elseif tipo_frecuencia = 8 then
         tipo_frecuencia = "Indefinido"
          'color = "primary"
        end if
		'	tipo_servicioSPAN = "<span class=//badge badge-pill "&color&"//>"&tipo_servicio&"</span>"

			'eliminarAgenda = "<button class=//md-btn md-raised mb-2 w-xs blue// onclick=javascript:eliminarAgenda("&datos(0,l)&")><i class=//fa fa-trash//></i></button>"

			info = info & "{'id':'"&datos(0,l)&"', 'concepto':'"&datos(1,l)&"', 'descripcion':'"&datos(2,l)&"', 'fecha_realizo':'"&datos(3,l)&"', 'tipo_egreso':'"&tipo_egreso&"', 'frecuencia_egreso':'"&tipo_frecuencia&"', 'justificacion':'"&datos(6,l)&"','responsable':'"&datos(7,l)&"', 'costo_unitario':'"&formatcurrency(datos(8,l),2)&"', 'cantidad_total':'"&datos(9,l)&"', 'egreso_total':'"&formatcurrency(datos(10,l),2)&"','fecha_baja':'"&datos(11,l)&"'},"
		next

		info = left(info, len(info)-1)


	end if

end if

' obtener calendario
if comm = "getCalendario" then

	sql = "select id, fecha_renta, nombre_cliente, cancha_asignada, CONVERT(VARCHAR,hora_inicio,108), CONVERT(VARCHAR,hora_fin,108) from agenda where estado = 1 order by fecha_renta desc "
	datos = executee(sql,dominio)

	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"
		next

		info = left(info, len(info)-1)

		set fs=Server.CreateObject("Scripting.FileSystemObject")
        filePath = Server.MapPath("\archivo.json")
        set f=fs.CreateTextFile(filePath,true)
        info1 = info
        info1 = Replace(info1, "'", chr(34))
        f.write(info1)
        f.close
        set f=nothing
        set fs=nothing

	end if

end if


' buscamos si existe una reservacion para el d??a, cancha y hora seleccionada
if comm = "verificarHorario" then
	' response.write(txtFechaReservaC1)
	' response.write(txthorarioInicioC1)
	' response.write(txthorarioFinC1)
	' response.write(optCanchaAsignada1)

	sql = "select id, CONVERT(VARCHAR,fecha_renta,101), nombre_cliente, cancha_asignada, CONVERT(VARCHAR,hora_inicio,108), CONVERT(VARCHAR,hora_fin,108) from agenda where cast(fecha_renta as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada = '"&optCanchaAsignada1&"' and estado=1 and "&_
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
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC2,101), nombre_cliente, cancha_asignada2, CONVERT(VARCHAR,hora_inicioC2,108), CONVERT(VARCHAR,hora_finC2,108) from agenda where cast(fecha_reservaC2 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada2 = '"&optCanchaAsignada1&"' and estado=1 and "&_
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
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC3,101), nombre_cliente, cancha_asignada3, CONVERT(VARCHAR,hora_inicioC3,108), CONVERT(VARCHAR,hora_finC3,108) from agenda where cast(fecha_reservaC3 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada3 = '"&optCanchaAsignada1&"' and estado=1 and "&_
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
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC4,101), nombre_cliente, cancha_asignada4, CONVERT(VARCHAR,hora_inicioC4,108), CONVERT(VARCHAR,hora_finC4,108) from agenda where cast(fecha_reservaC4 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada4 = '"&optCanchaAsignada1&"' and estado=1 and "&_
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
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC5,101), nombre_cliente, cancha_asignada5, CONVERT(VARCHAR,hora_inicioC5,108), CONVERT(VARCHAR,hora_finC5,108) from agenda where cast(fecha_reservaC5 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada5 = '"&optCanchaAsignada1&"' and estado=1 and "&_
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
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC6,101), nombre_cliente, cancha_asignada6, CONVERT(VARCHAR,hora_inicioC6,108), CONVERT(VARCHAR,hora_finC6,108) from agenda where cast(fecha_reservaC6 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada6 = '"&optCanchaAsignada1&"' and estado=1 and "&_
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
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC7,101), nombre_cliente, cancha_asignada7, CONVERT(VARCHAR,hora_inicioC7,108), CONVERT(VARCHAR,hora_finC7,108) from agenda where cast(fecha_reservaC7 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada7 = '"&optCanchaAsignada1&"' and estado=1 and "&_
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
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC8,101), nombre_cliente, cancha_asignada8, CONVERT(VARCHAR,hora_inicioC8,108), CONVERT(VARCHAR,hora_finC8,108) from agenda where cast(fecha_reservaC8 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada8 = '"&optCanchaAsignada1&"' and estado=1 and "&_
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


' buscamos las reservaciones del d??a y cancha seleccionada
if comm = "buscarReservacion" then

	sql = "select id, fecha_renta, nombre_cliente, cancha_asignada, CONVERT(VARCHAR,hora_inicio,108), CONVERT(VARCHAR,hora_fin,108) from agenda where cast(fecha_renta as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada = '"&optCanchaAsignada1&"' and estado=1 order by fecha_renta asc "
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
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC2,101), nombre_cliente, cancha_asignada2, CONVERT(VARCHAR,hora_inicioC2,108), CONVERT(VARCHAR,hora_finC2,108) from agenda where cast(fecha_reservaC2 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada2 = '"&optCanchaAsignada1&"' and tipo_servicio = 3 and estado=1 order by fecha_renta asc "
	datos = executee(sql,dominio)

	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"
		next
		'info = left(info, len(info)-1)
	end if

	' ***** CLASE 3 *****
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC3,101), nombre_cliente, cancha_asignada3, CONVERT(VARCHAR,hora_inicioC3,108), CONVERT(VARCHAR,hora_finC3,108) from agenda where cast(fecha_reservaC3 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada3 = '"&optCanchaAsignada1&"' and tipo_servicio = 3 and estado=1 order by fecha_renta asc "
	datos = executee(sql,dominio)

	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"
		next
		'info = left(info, len(info)-1)
	end if

	'****** CLASE 4 ******
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC4,101), nombre_cliente, cancha_asignada4, CONVERT(VARCHAR,hora_inicioC4,108), CONVERT(VARCHAR,hora_finC4,108) from agenda where cast(fecha_reservaC4 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada4 = '"&optCanchaAsignada1&"' and tipo_servicio = 3 and estado=1 order by fecha_renta asc "
	datos = executee(sql,dominio)

	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"
		next
		'info = left(info, len(info)-1)
	end if

	' ******* CLASE 5 *******
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC5,101), nombre_cliente, cancha_asignada5, CONVERT(VARCHAR,hora_inicioC5,108), CONVERT(VARCHAR,hora_finC5,108) from agenda where cast(fecha_reservaC5 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada5 = '"&optCanchaAsignada1&"' and tipo_servicio = 3 and estado=1 order by fecha_renta asc "
	datos = executee(sql,dominio)

	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"
		next
		'info = left(info, len(info)-1)
	end if

	' ******* CLASE 6 *******
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC6,101), nombre_cliente, cancha_asignada6, CONVERT(VARCHAR,hora_inicioC6,108), CONVERT(VARCHAR,hora_finC6,108) from agenda where cast(fecha_reservaC6 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada6 = '"&optCanchaAsignada1&"' and tipo_servicio = 3 and estado=1 order by fecha_renta asc "
	datos = executee(sql,dominio)

	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"
		next
		'info = left(info, len(info)-1)
	end if

	' ****** CLASE 7 ******
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC7,101), nombre_cliente, cancha_asignada7, CONVERT(VARCHAR,hora_inicioC7,108), CONVERT(VARCHAR,hora_finC7,108) from agenda where cast(fecha_reservaC7 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada7 = '"&optCanchaAsignada1&"' and tipo_servicio = 3 and estado=1 order by fecha_renta asc "
	datos = executee(sql,dominio)

	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'cancha_asignada':'"&datos(3,l)&"', 'hora_inicio':'"&datos(4,l)&"', 'hora_fin':'"&datos(5,l)&"'},"
		next
		'info = left(info, len(info)-1)
	end if

	' ****** CLASE 8 ******
	sql = "select id, CONVERT(VARCHAR,fecha_reservaC8,101), nombre_cliente, cancha_asignada8, CONVERT(VARCHAR,hora_inicioC8,108), CONVERT(VARCHAR,hora_finC8,108) from agenda where cast(fecha_reservaC8 as date) = cast('"&txtFechaReservaC1&"' as date) and cancha_asignada8 = '"&optCanchaAsignada1&"' and tipo_servicio = 3 and estado=1 order by fecha_renta asc "
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


' buscamos si existe una reservacion para el d??a, cancha y hora seleccionada del tipo ACADEMIA
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

    		sql = "select id, fecha_renta, nombre_cliente, cancha_asignada, CONVERT(VARCHAR,hora_inicio,108), CONVERT(VARCHAR,hora_fin,108) from agenda where cast(fecha_renta as date) = cast('"&txtFechaReservaC&"' as date) and cancha_asignada = '"&optCanchaAsignada&"' and estado=1 and "&_
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

'abre incidencia con envio de notificacion
' if comm = "abrirIncidencia" and idRegistro > 0 then
'     if idRegistro >0 then
' 		'sql = "update "+tabla+" set estado='1', fecha_cierre=getDate() where id="+idRegistro
' 		ActualizarDatos tabla, "estado='0', fecha_cierre='' ", "id='"&idRegistro&"' ", dominio
' 		info = "{'ok':'ok'}"

' 		titulo = "Se abrio incidencia: "&cliente
' 		mensaje = "Se ha abierto la incidencia: "&idRegistro

' 		enviarNotificacion titulo, mensaje, dominio

' 	end if
' end if

respuesta = "{'data':["&info&"]}"
respuesta = Replace(respuesta, "'", chr(34))
respuesta = replace(respuesta,"//","'")
response.Write(respuesta)
%>
