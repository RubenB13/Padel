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

 txtConcepto  = Request.form("txtTrans")
 txtTipo  = request.form("TipoTrans")
 txtClasif = request.form("clasTrans")
 txtFechaRealizada = request.form("txtFechatrans")
 txtResponsable = request.form("txtResponsable")
 txtCosto= request.form("txtCantidad")



 periodoDesde = request.QueryString("de")
 periodoA = request.QueryString("a")


 comm = request.form("comm")
 idRegistro = request.form("idReg")
 com = request.queryString("com")

camposs = "Desc_trans_caja, Tipo_Trans_Caja, Clas_trans_Caja, Fecha_trans_caja, Responsable_trans_caja, Cantidad, Estado, Fecha_captura_caja, id_usuario"
datoss = " '"&txtConcepto&"', '"&txtTipo&"', '"&txtClasif&"', '"&txtFechaRealizada&"', '"&txtResponsable&"', '"&txtCosto&"', 1, getdate(),'"&idUser&"' "


'tabla = "admin_Historial_Caja"

'nuevo registro Caja' 
if comm = "NuevaTransCaja" then
	    On Error Resume Next

	if idRegistro = 0 then
		guardarDatos "admin_historia_Caja", camposs, datoss, dominio
		info = "{'ok':'ok'}"

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
