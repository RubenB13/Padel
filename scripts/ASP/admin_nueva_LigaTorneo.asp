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

comm = request.form("comm")
idRegistro = request.form("idReg")

txtNombreTorneo = request.form("txtNombreTorneo")
txtCostoInscripcion = request.form("txtCostoInscripcion")
date_from = request.form("date_from")
date_to = request.form("date_to")
txthorarioInicioC1 = request.form("txthorarioInicioC1")
txthorarioFinC1 = request.form("txthorarioFinC1")
cboDia = request.form("cboDia")

com = request.queryString("com")
periodoDesde = request.QueryString("de")
periodoA = request.queryString("a")


'nuevo torneo
if comm = "nuevoTorneo" then

	camposs = " nombre, inscripcion, fecha_inicio, fecha_fin, hora_inicio, hora_fin, dia "
	datoss = " '"&txtNombreTorneo&"', '"&txtCostoInscripcion&"', '"&date_from&"', '"&date_to&"', '"&txthorarioInicioC1&"', '"&txthorarioFinC1&"', '"&cboDia&"' "

	if idRegistro = 0 then 'nueva torneo'
		guardarDatos "admin_torneos", camposs, datoss, dominio
		info = "{'ok':'ok'}"
	elseif idRegistro > 0 then 'actualizammos torneo'
		' ActualizarDatos "admin_torneos", camposAct, "id='"&idRegistro&"' ", dominio
		info = "{'ok':'ok1'}"
	end if
end if


'listar ligas y torneos
if com = "listarTorneos" then
	On Error Resume Next
	if periodoDesde <> "" and periodoA <> "" then
		ss = " where cast(fecha_inicio as date) >= '"&periodoDesde&"' and cast(fecha_inicio as date) <= '"&periodoA&"' "
	else
		ss = ""
	end if

	sql = " SELECT TOP (10) id, nombre, inscripcion, FORMAT(fecha_inicio, 'd MMMM yyyy','es-US'), FORMAT(fecha_fin, 'd MMMM yyyy','es-US'), "&_
		" CONVERT(VARCHAR,hora_inicio,108), CONVERT(VARCHAR,hora_fin,108), dia FROM admin_torneos "&ss
	
	datos = executee(sql,dominio)

	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			dia = datos(7,l)
			if dia =  1 then
				dia_semana = "Lunes"
			elseif dia = 2 then
				dia_semana = "Martes"
			elseif dia = 3 then
				dia_semana = "Miércoles"
			elseif dia = 4 then
				dia_semana = "Jueves"
			elseif dia = 5 then
				dia_semana = "Viernres"
			elseif dia = 6 then
				dia_semana = "Sábado"
			elseif dia = 7 then
				dia_semana = "Domingo"
			end if

			editar_torneo = "<a class=//btn btn-icon white//><i class=//fa fa-pencil// title=//Editar Torneo//></i></a>&nbsp;&nbsp;"
			agregar_jugador = "<a class=//btn btn-icon white//><i class=//fa fa-users// title=//Agregar jugador//></i></a>"
			
			datos_torneo = "<div class=//sl-item b-primary //>"&_
							"<div class=//sl-content//>"&_
							    "<div class=//sl-date text-muted//>Torneo: "&datos(1,l)&"</div>"&_
							    "<div class=//sl-date text-muted//>Jugadores: 10 - Inscripción: "&formatcurrency(datos(2,l),2)&"</div>"&_
							    "<div class=//sl-date text-muted//>Del "&datos(3,l)&" al "&datos(4,l)&"</div>"&_
							    "<div class=//sl-date text-muted//>Horario: "&datos(5,l)&" - "&datos(6,l)&"</div>"&_
							    "<div class=//sl-date text-muted//>Día: "&dia_semana&"</div>"&_
							    "<div>"&editar_torneo&agregar_jugador&"</div>"&_
							 "</div>"&_
							"</div>"

			info = info & "{'ok':'ok',  'id':'"&datos(0,l)&"', 'datos_torneo':'"&datos_torneo&"'},"
		next
		info = left(info, len(info)-1)
	end if
	
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