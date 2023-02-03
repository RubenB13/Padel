<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="BD.asp"-->


<%
Response.Expires = 0
LServerName = Request.ServerVariables("SERVER_NAME")
valSpl = split(LServerName,".")
dominio = "db_a8638d_bdupadel" 'valSpl(0)


'idUser =  'Request.Cookies ("kkii124655")("id")
'nombreUser = 'Request.Cookies ("kkii124655")("nom")
'tipoUser =  'Request.Cookies ("kkii124655")("tipo")

 ' idUser = request.form("idUsuario")
 ' txtNombreCliente  = Request.form("txtNombreCliente")
 ' txtTelefono  = request.form("txtTelefono")
 ' optTipoServicio = request.form("optTipoServicio")
 ' optProfesor = request.form("optProfesor")
 ' optNumPersonas = request.form("optNumPersonas")
 ' optCanchaAsignada = request.form("optCanchaAsignada")
 ' txtFechaReserva = request.form("txtFechaReserva")
 ' txthorarioInicio = request.form("txthorarioInicio")
 idTipoServicio =  request.form("idTipoServicio")
 comm = request.form("comm")
 ' idRegistro = request.form("idReg")


' camposs = "nombre_cliente, telefono, tipo_servicio, profesor_asignado, numero_personas, cancha_asignada, fecha_renta, hora_inicio, hora_fin, fecha_registro, precio_renta, pagado, fecha_pago, id_usuario"
' datoss = " '"&txtNombreCliente&"', '"&txtTelefono&"', '"&optTipoServicio&"', '"&optProfesor&"', '"&optNumPersonas&"', '"&optCanchaAsignada&"', '"&txtFechaReserva&"','"&txthorarioInicio&"', '"&txthorarioFin&"', getDate(),'"&txtPrecioRenta&"', 0, '','"&idUser&"' "
	    
' tabla = "agenda"

'nueva agenda
' if comm = "nuevaAgenda" then

' 	if idRegistro = 0 then
' 		guardarDatos tabla, camposs, datoss, dominio
' 		info = "{'ok':'ok'}"

' 		' titulo = "Incidencia: "&cliente
' 		' mensaje = "Se ha generado una incidencia..."

' 		' enviarNotificacion titulo, mensaje, dominio

' 	end if
' end if

'listar tipos de servicios
if comm = "tipoServicios" then	    
     
	sql = "select id, tipo_servicio from admin_tipoServicio where estado=1 "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
		
			info = info & "{'id':'"&datos(0,l)&"', 'tipoServicio':'"&datos(1,l)&"'},"	

		next

		info = left(info, len(info)-1)
	end if
	  
end if


if comm = "tipoServiciosPa" then	    
     
	sql = "select id, tipo_servicio from admin_tipoServicio where estado=1 and id>2 and id<6"
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
		
			info = info & "{'id':'"&datos(0,l)&"', 'tipoServicio':'"&datos(1,l)&"'},"	

		next

		info = left(info, len(info)-1)
	end if
	  
end if

'buscar precio tipos de servicio
if comm = "precioServicios" then	    
     
	sql = "select id, tipo_servicio, costo_hora, dos_personas, tres_personas, cuatro_personas, CONVERT(VARCHAR,hora_inicio,108), CONVERT(VARCHAR,hora_fin,108), CONVERT(VARCHAR,hora_inicio2,108), CONVERT(VARCHAR,hora_fin2,108) from admin_tipoServicio where estado=1 and id = '"&idTipoServicio&"' "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)

			if datos(0,l) = "7" then
				' buscamos el horario muestro para compararlo con el horario concurrido
				sql2 = "select id, tipo_servicio, costo_hora, dos_personas, tres_personas, cuatro_personas, CONVERT(VARCHAR,hora_inicio,108), CONVERT(VARCHAR,hora_fin,108), CONVERT(VARCHAR,hora_inicio2,108), CONVERT(VARCHAR,hora_fin2,108) from admin_tipoServicio where estado=1 and id = 6 "
				datos2 = executee(sql2,dominio)
				if not IsEmpty(datos2) then
					horarioInicio_Muerto = datos2(6,l)
					horarioFin_Muerto = datos2(7,l)
				else
					horarioInicio_Muerto = "00:00"
					horarioFin_Muerto = "00:00"
				end if

			end if
			
			info = info & "{'id':'"&datos(0,l)&"', 'tipoServicio':'"&datos(1,l)&"', 'precio_hora':'"&datos(2,l)&"', 'dos_personas':'"&datos(3,l)&"', 'tres_personas':'"&datos(4,l)&"', 'cuatro_personas':'"&datos(5,l)&"', 'hora_inicio':'"&datos(6,l)&"', 'hora_fin':'"&datos(7,l)&"', 'hora_inicio2':'"&datos(8,l)&"', 'hora_fin2':'"&datos(9,l)&"', 'horario_inicio_muerto':'"&horarioInicio_Muerto&"', 'horario_fin_Muerto':'"&horarioFin_Muerto&"'},"	

		next

		info = left(info, len(info)-1)
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
response.Write(respuesta)
%>