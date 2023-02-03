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

 nombre = request.form("nomb")
 idUsPa = request.form("iduser")

 periodoDesde = request.QueryString("de")
 periodoA = request.QueryString("a")


 comm = request.form("comm")
 idRegistro = request.form("idReg")
 com = request.queryString("com")

camposs = "nombre_usuario, fecha_registro, id_registro, estado"
datoss = " '"&nombre&"', getdate(), '"&idUser&"', 1"


'tabla = "admin_Historial_Caja"

'nuevo registro Caja' 
if comm = "guardarUserPa" then
	    On Error Resume Next

	if idRegistro = 0 then
		guardarDatos "admin_usu_pa", camposs, datoss, dominio
		info = "{'ok':'ok'}"

	end if

	if Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
	
	On Error GoTo 0
end if

'lista de usuarios para pagos adelantados
if com = "verUsuarios" then
	    On Error Resume Next

		sqlcons= "select id, nombre_usuario, convert(varchar,fecha_registro,7) from admin_usu_pa where estado=1"

   		 datos = executee(sqlcons,dominio)

	 	 if not IsEmpty(datos) then
		
			for l=0 to ubound(datos,2)

				id = datos(0,l)
				nombre = datos(1,l)
				fecha = datos(2,l)
					
				borrar = "<button class=//md-btn md-raised mb-2 blue// onclick=javascript:borrarUser("&id&")><i class=//fa fa-trash//></i></button>&nbsp"

			    actualizar = "<button class=//md-btn md-raised mb-2 indigo// onclick=javascript:actualizarUser("&id&")><i class=//fa fa-refresh//></i></button>"

				
				info = info & "{'id':'"&id&"', 'nombre':'"&nombre&"', 'fecha':'"&fecha&"', 'accion':'"&borrar&actualizar&"'},"
			next	
			info = left(info, len(info)-1)
		end if
	
	   
	If Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
		On Error GoTo 0
end if


if comm = "borrarUser"  then
	ActualizarDatos "admin_usu_pa", "estado=0, fecha_baja=getdate(), id_baja="&idUser&" ", "id='"&idUsPa&"' ", dominio
	info = "{'ok':'ok'}"
end if


if comm = "modificarUser"  then
	    On Error Resume Next
	ActualizarDatos "admin_usu_pa", "nombre_usuario='"&nombre&"', fecha_modifica=getdate(), id_modifica='"&idUser&"' ", "id='"&idUsPa&"' ", dominio
	info = "{'ok':'ok'}"

		If Err.Number <> 0 then
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
