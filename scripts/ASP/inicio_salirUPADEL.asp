<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="BD.asp"-->
<%
Response.Expires = 0
LServerName = Request.ServerVariables("SERVER_NAME")
valSpl = split(LServerName,".")
dominio = "db_a8638d_bdupadel" 'valSpl(0)

Session.Abandon
tokey = Request.Cookies ("kkii124655")("tokey")
idUser = Request.Cookies ("kkii124655")("id")
nombreUser = Request.Cookies ("kkii124655")("nom")
tipoUser = Request.Cookies ("kkii124655")("tipo")

' borramos el campo token del usuario que sale de la aplicacion
' if idUser <> "" then
' 	ActualizarDatos "usuarios",  " token=''", "id="&idUser , dominio 
' end if

Response.Cookies ("kkii124655")("tokey") = "err"
Response.Cookies ("kkii124655")("id")= "err"
Response.Cookies ("kkii124655")("nom")= "err"
Response.Cookies ("kkii124655")("tipo")= "err"
Response.Cookies ("kkii124655").Expires =  Date() - 1 'Now() 

tokey = Request.Cookies ("kkii124655")("tokey") 
idUser = Request.Cookies ("kkii124655")("id") 

respuesta = "{'toeky': '"&tokey&"', 'iduser':'"&idUser&"'}"
respuesta = Replace(respuesta, "'", chr(34))
response.Write(respuesta)
	
%>