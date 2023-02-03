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

 idUsuario = request.form("id")
 comm = request.form("comm")


 'conuslta al usuario logeado
if comm = "buscaUsuario" then	    
     
	sql = "select id, nombre from admin_usuarios where id = '"&idUsuario&"' "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'nombre':'"&datos(1,l)&"'},"	
		
		info = left(info, len(info)-1)
	end if
	  
end if
	


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