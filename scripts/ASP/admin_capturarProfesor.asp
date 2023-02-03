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

 ' idUser = request.form("idUsuario")
 txtNombreProfesor  = Request.form("txtNombreProfesor")
 txtTelefono  = request.form("txtTelefono")
 ' optTipoServicio = request.form("optTipoServicio")
 ' optProfesor = request.form("optProfesor")
 ' optNumPersonas = request.form("optNumPersonas")
 ' optCanchaAsignada = request.form("optCanchaAsignada")
 ' txtFechaReserva = request.form("txtFechaReserva")
 ' txthorarioInicio = request.form("txthorarioInicio")
 ' txthorarioFin =  request.form("txthorarioFin")
 comm = request.form("comm")
 idRegistro = request.form("idReg")


camposs = "nombre, telefono, estado"
datoss = " '"&txtNombreProfesor&"', '"&txtTelefono&"', 1 "
	    
tabla = "admin_profesores"

'guarda y actualiza un profesor
if comm = "save" then
	On Error Resume Next
		if idRegistro = 0 then
			guardarDatos tabla, camposs, datoss, dominio
			info = "{'ok':'ok'}"
		elseif idRegistro > 0 then
			ActualizarDatos tabla, "nombre='"&txtNombreProfesor&"', telefono='"&txtTelefono&"' ", "id='"&idRegistro&"' ", dominio
	 		info = "{'ok':'ok'}"
		end if

	if Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
	On Error GoTo 0
end if

'elimna a un profesor
if comm = "eliminar" and idRegistro > 0 then
	On Error Resume Next
			ActualizarDatos tabla, "estado=0 ", "id='"&idRegistro&"' ", dominio
	 		info = "{'ok':'ok'}"

	if Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
	On Error GoTo 0
end if

'listar profesores
if comm = "profesores" then	    
    On Error Resume Next
	sql = "select id, nombre from admin_profesores where estado=1 "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
		
			info = info & "{'id':'"&datos(0,l)&"', 'nombre':'"&datos(1,l)&"'},"	

		next

		info = left(info, len(info)-1)
	end if

	if Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
	On Error GoTo 0
   
end if	

'muestra todos los profesores para editar o eliminar'
if comm="listaProfesores" then
    sql = "select id, nombre, telefono from admin_profesores where estado=1 "
    datos = executee(sql, dominio)
    if not IsEmpty(datos) then
        l = 0
        info = ""
        for l=0 to ubound(datos,2)
            eliminarProfesor = "<button class=//md-btn md-raised mb-2 blue// onclick=javascript:eliminarProfesor("&datos(0,l)&")><i class=//fa fa-trash//></i></button>"
            actualizarProfesor = "<button class=//md-btn md-raised mb-2 blue// onclick=javascript:actualizarProfesor("&datos(0,l)&")><i class=//fa fa-refresh//></i></button>&nbsp"
            
            info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'nombre':'"&datos(1,l)&"', 'telefono': '"&datos(2,l)&"', 'accion':'"&actualizarProfesor&eliminarProfesor&"'},"
        next
        info = left(info, len(info)-1)
    else
        info = "{'ok':'noOk'}"
    end if

end if


if comm = "get" and idRegistro > 0 then
	sql = "select id, nombre, telefono from admin_profesores where id = '"&idRegistro&"' "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		info = "{'ok':'ok','id':'"&datos(0,l)&"', 'nombre':'"&datos(1,l)&"', 'telefono':'"&datos(2,l)&"'}"	
	else
		info = "{'ok':'noOk'}"
	end if
   
end if	


if comm = "buscaProfesor" then
	On Error Resume Next
	sql = "select id, nombre from admin_profesores where nombre ='"&nombreUser&"' and estado=1 "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0		
		info = "{'id':'"&datos(0,l)&"', 'nombre':'"&datos(1,l)&"'}"
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