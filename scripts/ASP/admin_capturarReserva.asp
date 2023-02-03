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

 idRegistro = request.form("idReg")
 txtNombreCliente  = Request.form("txtNombreCliente")
 txtTelefono  = request.form("txtTelefono")
 optTipoServicio = request.form("optTipoServicio")
 txtFechaReservaC1 = request.form("txtFechaReservaC1")
 txthorarioInicioC1 = request.form("txthorarioInicioC1")
 txthorarioFinC1 =  request.form("txthorarioFinC1")
 txtComentario =  request.form("txtComentario")
 comm = request.form("comm")

 txtNombreAcademia = request.form("txtNombreAcademia")
 optTipoClase = request.form("optTipoClase")
 txtTelefonoAcademia = request.form("txtTelefonoAcademia")
 optGenero = request.form("optGenero")
 txtEdad = request.form("txtEdad")
 optExperiencia = request.form("optExperiencia")


camposs = "nombre, telefono, tipo_servicio, fecha_reserva, hora_inicio, hora_final, fecha_registro, estado, comentarios "

datoss = " '"&txtNombreCliente&"', '"&txtTelefono&"', '"&optTipoServicio&"','"&txtFechaReservaC1&"','"&txthorarioInicioC1&"', '"&txthorarioFinC1&"', getDate(), '1', '"&txtComentario&"' "

tabla = "admin_reservarUsuario"

'nueva reserva
if comm = "nuevaReserva" then
	On Error Resume Next
	guardarDatos tabla, camposs, datoss, dominio
	info = "{'ok':'ok'}"

	if Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
	On Error GoTo 0
end if

if comm = "atenderReserva" and idRegistro > 0 then
	ActualizarDatos tabla, "estado=0", "id='"&idRegistro&"' ", dominio
	info = "{'ok':'ok'}"
end if

'listar reservas
if comm = "listarReservas" then
	On Error Resume Next
	
	sql = "select id, nombre, telefono, tipo_servicio, CONVERT(VARCHAR,fecha_reserva,103), CONVERT(VARCHAR,hora_inicio,108), CONVERT(VARCHAR,hora_final,108), fecha_registro, comentarios from admin_reservarUsuario where estado = 1"

	datos = executee(sql,dominio)

	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			
			horario = datos(5,l)&" - "&datos(6,l)
			num_reservaciones = CInt(num_reservaciones) + 1

			tipo_servicio = datos(3,l)
			
			if tipo_servicio = 0 or tipo_servicio = 1 or tipo_servicio = 2 or tipo_servicio = 3 then
				verReserva = "<a class=//item-title _500// href=javascript:verReserva("&datos(0,l)&")>"&datos(1,l)&"</a>"
			elseif tipo_servicio = 4 or tipo_servicio= 5 or tipo_servicio = 6 then
				verReserva = "<a class=//item-title _500// href=javascript:verReservaClase("&datos(0,l)&")>"&datos(1,l)&"</a>"
			end if

			if tipo_servicio = 0 then
				tipoServicio = "no selecciono servicio"
			elseif tipo_servicio = 1 then
				tipoServicio = "Renta normal"
			elseif tipo_servicio = 2 then
				tipoServicio = "Cancha WPT"
			elseif tipo_servicio = 3 then
				tipoServicio = "Información de clases"
			elseif tipo_servicio = 4 then
				tipoServicio = "Clase particular"
			elseif tipo_servicio = 5 then
				tipoServicio = "Clase grupal"
			elseif tipo_servicio = 6 then
				tipoServicio = "Academia"
			end if

			info = info & "{'id':'"&datos(0,l)&"', 'nombre':'"&verReserva&"', 'telefono':'"&datos(2,l)&"', 'tipo_servicio':'"&tipoServicio&"', 'fecha_reserva':'"&datos(4,l)&"', 'horario':'"&horario&"', 'fecha_registro':'"&datos(7,l)&"', 'comentarios':'"&datos(8,l)&"', 'num_reservas':'"&num_reservaciones&"'},"	

		next

		info = left(info, len(info)-1)
	end if

	if Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
	On Error GoTo 0
end if


if comm = "verReserva" then
	On Error Resume Next
	
	sql = "select id, nombre, telefono, tipo_servicio, CONVERT(VARCHAR,fecha_reserva,103), CONVERT(VARCHAR,hora_inicio,108), CONVERT(VARCHAR,hora_final,108), fecha_registro, comentarios, isnull(genero,0), edad, isnull(experiencia,0) from admin_reservarUsuario where estado = 1 and id='"&idRegistro&"'"

	datos = executee(sql,dominio)

	if not IsEmpty(datos) then
		horario = datos(5,l)&" - "&datos(6,l)
		
		tipo_servicio = datos(3,l)
		if tipo_servicio = 0 then
			tipoServicio = "no selecciono servicio"
		elseif tipo_servicio = 1 then
			tipoServicio = "Renta normal"
		elseif tipo_servicio = 2 then
			tipoServicio = "Cancha WPT"
		elseif tipo_servicio = 3 then
			tipoServicio = "Información de clases"
		elseif tipo_servicio = 4 then
			tipoServicio = "Clase particular"
		elseif tipo_servicio = 5 then
			tipoServicio = "Clase grupal"
		elseif tipo_servicio = 6 then
			tipoServicio = "Academia"
		end if

		tipo_genero = datos(9,l)
		if tipo_genero = 0 then
			tipoGenero = "Sin especificar"
		elseif tipo_genero = 1 then
			tipoGenero = "Femenino"
		elseif tipo_genero = 2 then
			tipoGenero = "Masculino"
		end if

		tipo_experiencia = datos(11,l)
		if tipo_experiencia = 0 then
			experiencia = "Sin especificar"
		elseif tipo_experiencia = 1 then
			experiencia = "Básica"
		elseif tipo_experiencia = 2 then
			experiencia = "Avanzada"
		elseif tipo_experiencia = 3 then
			experiencia = "Sin experiencia"
		end if

		info = info & "{'id':'"&datos(0,l)&"', 'nombre':'"&datos(1,l)&"', 'telefono':'"&datos(2,l)&"', 'tipo_servicio':'"&tipoServicio&"', 'fecha_reserva':'"&datos(4,l)&"', 'horario':'"&horario&"', 'fecha_registro':'"&datos(7,l)&"', 'comentarios':'"&datos(8,l)&"', 'genero':'"&tipoGenero&"', 'edad':'"&datos(10,l)&"', 'experiencia':'"&experiencia&"'}"	

		
	end if

	if Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
	On Error GoTo 0
end if


' **** reserva clase academia ****

'nueva reserva de clase

campos = "nombre, telefono, tipo_servicio, genero, edad, experiencia, fecha_registro, estado"
datos = " '"&txtNombreAcademia&"', '"&txtTelefonoAcademia&"', '"&optTipoClase&"', '"&optGenero&"', '"&txtEdad&"', '"&optExperiencia&"', getDate(), 1 "

if comm = "nuevaReservaClase" then
	On Error Resume Next
	guardarDatos tabla, campos, datos, dominio
	info = "{'ok':'ok'}"

	if Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
	On Error GoTo 0
end if


respuesta = "{'data':["&info&"]}"
respuesta = Replace(respuesta, "'", chr(34))
respuesta = replace(respuesta,"//","'")
response.Write(respuesta)
%>