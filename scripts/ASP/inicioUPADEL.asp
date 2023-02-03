<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="BD.asp"-->
<%
Response.Expires = 0
LServerName = Request.ServerVariables("SERVER_NAME")
valSpl = split(LServerName,".")
dominio = "db_a8638d_bdupadel" 'valSpl(0)

tokey = Request.Cookies ("kkii124655")("tokey")
idUser = Request.Cookies ("kkii124655")("id")
nombreUser = Request.Cookies ("kkii124655")("nom")
tipoUser = Request.Cookies ("kkii124655")("tipo")
' app = Request.Cookies ("kkii124655")("app")

'se consulta el tipo de fraccionamiento (dominioi) para saber que dashboard cargamos de acuerdo a la información que retornamos en el json
' Response.write(len(Request.Cookies ("kkii124655")("tokey")))
' response.write(Request.Cookies("kkii124655")("id"))

If len(Request.Cookies ("kkii124655")("tokey")) = 3 Then
	respuesta = "{'userValid':'false'}"
else
	sql = "select nombre, tipo from admin_usuarios where estado=1 "
	datos = executee(sql, dominio)
	if not IsEmpty(datos) then
		l = 0
		' nombreFra = datos(1,l)
		' select case tipoUser
		' case 1
		' 	if dominio = "sichertech" then
		' 		tituloContent = "Administración Central ST"
		' 		tituloVentana = tituloContent
		' 		tipouse = "adminCentral"
		' 	end if
		' case 2
		' 	tituloContent = "Administrador Residencial"
		' 	tituloVentana = nombreFra&" | Administrador Residencial"
		' 	tipouse = "adminResidencial"
		' case 3
		' 	tituloContent = "Residente"
		' 	tituloVentana = nombreFra&" | Residente"
		' 	tipouse = "usuarioDueno"
		' case 4
		' 	tituloContent = "Vigilancia"
		' 	tituloVentana = nombreFra&" | Vigilancia"
		' 	tipouse = "usuarioVigilante"
		' end select
		
		select case tipoUser
		case 1
			txtTipouser = "Administrador"
		case 2
			txtTipouser = "Usuario"
		case 3
			'vigilante no se muestra
			txtTipouser = ""
		end select
		respuesta = "{'userValid':'true', 'nombreUsuario':'"&nombreUser&"', 'tipoUsuario':'"&txtTipouser&"', 'idTp':'"&tipoUser&"', 'tokey':'"&tokey&"'}"	
	end if
end if

respuesta = Replace(respuesta, "'", chr(34))
response.Write(respuesta)
	
%>