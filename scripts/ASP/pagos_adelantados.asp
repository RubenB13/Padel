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
 idservicio = request.form("idservicio")
 idprof = request.form("prof")
 tclases = request.form("tcl")
 tpago = request.form("tpg")
fpago = request.form("fdate")
 periodoDesde = request.QueryString("de")
 periodoA = request.QueryString("a")

nfecha = request.form("nf")

 comm = request.form("comm")
 idRegistro = request.form("idReg")
 com = request.queryString("com")
 numper =  request.form("nump")

camposs = "nombre_usuario, fecha_registro, id_registro, estado"
datoss = " '"&nombre&"', getdate(), '"&idUser&"', 1"

campospa = "id_user, fecha_pago, tipo_servicio, total_clases ,total_pagado, estado, profe, capita_rest, nu_perso "
datospa = "'"&idUsPa&"', '"&fpago&"', '"&idservicio&"', '"&tclases&"', '"&tpago&"', 1, '"&idprof&"', '"&tpago&"', '"&numper&"' "
'tabla = "admin_Historial_Caja"

'Guarda Usuario' 
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


'Guarda Pago Adelantado' 
if comm = "guardaPagoAdelantado" then
	    On Error Resume Next

	if idRegistro = 0 then
		guardarDatos "admin_control_pagosAd", campospa, datospa, dominio
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
					
			

			   accion = "<button class=//md-btn md-raised mb-2 indigo// onclick=//javascript:agregaUsuariopa("&id&",&#39;"&nombre&"&#39;)//>Agregar</button>"

				
				info = info & "{'id':'"&id&"', 'nombre':'"&nombre&"', 'fecha':'"&fecha&"', 'accion':'"&accion&"'},"
			next	
			info = left(info, len(info)-1)
		end if
	
	   
	If Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
		On Error GoTo 0
end if


'lista de pagos adelantados
if com = "verPagosAdelantados" then
	    On Error Resume Next

		sqlcons= "select cp.id_user, us.nombre_usuario, convert(varchar, cp.fecha_pago,6), cp.total_clases, tp.tipo_servicio, cp.total_pagado, p.nombre, cp.id, cp.nu_perso  from admin_control_pagosAd cp "&_
					" inner join admin_usu_pa us on cp.id_user = us.id "&_
					" inner join admin_tipoServicio tp on cp.tipo_servicio = tp.id "&_
					" inner join admin_profesores p on cp.profe = p.id "&_
					" where cp.estado = 1 and month(cp.fecha_pago) = MONTH(GETDATE())"

   		 datos = executee(sqlcons,dominio)

	 	 if not IsEmpty(datos) then
		
			for l=0 to ubound(datos,2)

				id = datos(0,l)
				nombre = datos(1,l)
				fecha = datos(2,l)
				clases = datos(3,l)
				tipo = datos(4,l)
				pago = datos(5,l)
				profe = datos(6,l)
				idg = datos(6,l)
				idr = datos(7,l)
				nump = datos(8,l)	
			

			      accion = "<button class=//md-btn md-raised mb-2 indigo// onclick=//javascript:borrarPagoAdelantado("&idr&")//><i class=//fa fa-trash//></i></button>&nbsp"
			      modifica = "<button class=//md-btn md-raised mb-2 warning// onclick=//javascript:modalModificaInfo("&idr&",&#39;"&fecha&"&#39;)//><i class=//fa fa-refresh//></i></button>"

				
				info = info & "{'id':'"&id&"', 'nombre':'"&nombre&"', 'fecha':'"&fecha&"', 'clases':'"&clases&"', 'pago':'"&pago&"', 'tipo':'"&tipo&"', 'profe':'"&profe&"', 'accion':'"&accion&modifica&"', 'numper':'"&nump&"'},"
			next	
			info = left(info, len(info)-1)
		end if
	
	   
	If Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
		On Error GoTo 0
end if


	' vemos todos los pagos adelantados


	
'lista de pagos adelantados
if com = "verTodosPagosAdelantados" then
	    On Error Resume Next

		sqlcons= "select cp.id_user, us.nombre_usuario, convert(varchar, cp.fecha_pago,6), cp.total_clases, tp.tipo_servicio, cp.total_pagado, p.nombre, cp.id, cp.nu_perso from admin_control_pagosAd cp "&_
					" inner join admin_usu_pa us on cp.id_user = us.id "&_
					" inner join admin_tipoServicio tp on cp.tipo_servicio = tp.id "&_
					" inner join admin_profesores p on cp.profe = p.id "&_
					" where cp.estado = 1"

   		 datos = executee(sqlcons,dominio)

	 	 if not IsEmpty(datos) then
		
			for l=0 to ubound(datos,2)

				id = datos(0,l)
				nombre = datos(1,l)
				fecha = datos(2,l)
				clases = datos(3,l)
				tipo = datos(4,l)
				pago = datos(5,l)
				profe = datos(6,l)
				idr = datos(7,l)
				nump = datos(8,l)
					
			

				accion = "<button class=//md-btn md-raised mb-2 indigo// onclick=//javascript:borrarPagoAdelantado("&idr&")//><i class=//fa fa-trash//></i></button>&nbsp"
			    modifica = "<button class=//md-btn md-raised mb-2 warning// onclick=//javascript:modalModificaInfo("&idr&",&#39;"&fecha&"&#39;)//><i class=//fa fa-refresh//></i></button>"


				
				info = info & "{'id':'"&id&"', 'nombre':'"&nombre&"', 'fecha':'"&fecha&"', 'clases':'"&clases&"', 'pago':'"&pago&"', 'tipo':'"&tipo&"', 'profe':'"&profe&"', 'accion':'"&accion&modifica&"', 'numper':'"&nump&"'},"
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


if comm = "borraPagoAdelantado"  then
	ActualizarDatos "admin_control_pagosAd", "estado=0, fecha_baja=getdate(), id_baja="&idUser&" ", "id='"&idUsPa&"' ", dominio
	info = "{'ok':'ok'}"
end if
if comm = "modificaPago"  then
	ActualizarDatos "admin_control_pagosAd", "fecha_pago='"&nfecha&"'", "id='"&idUsPa&"' ", dominio
	info = "{'ok':'ok', 'fechanueva':'"&nfecha&"'}"
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


if comm = "calculocostounitarioPa" then	    
     
	On Error Resume Next
	sql = "select * from admin_tipoServicio where estado=1 and id = '"&idservicio&"'"
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
       
	   id = datos(0,l)
	   costo1 = datos(2,l)
	   costo2 = datos(4,l)
	   costo3 = datos(5,l)
	   costo4 = datos(6,l)
		if id = 3 then 
		
	    costo1 = (costo1/8)
	    costo2 = (costo2/8)
	    costo3 = (costo3/8)
	    costo4 = (costo4/8)
		end if
       

	end if 		

	info = "{'ok':'ok', 'id':'"&id&"', 'costo1':'"&costo1&"', 'costo2':'"&costo2&"', 'costo3':'"&costo3&"', 'costo4':'"&costo4&"'}"
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
