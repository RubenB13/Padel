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
		' titulo = "Incidencia: "&cliente
		' mensaje = "Se ha generado una incidencia..."

		' enviarNotificacion titulo, mensaje, dominio

	end if
end if


respuesta = "{'data':["&info&"]}"
respuesta = Replace(respuesta, "'", chr(34))
respuesta = replace(respuesta,"//","'")
response.Write(respuesta)
%>