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
 tresta = request.form("tpr")
 fechauso = request.form("fechas")

 idControlPagos = request.form("idControlPagos")
 id_ControlPagos = request.queryString("id_ControlPagos")

 periodoDesde = request.QueryString("de")
 periodoA = request.QueryString("a")

 ideUs = request.QueryString("us")
 



 comm = request.form("comm")
 idRegistro = request.form("idReg")
 com = request.queryString("com")

camposs = "nombre_usuario, fecha_registro, id_registro, estado"
datoss = " '"&nombre&"', getdate(), '"&idUser&"', 1"

campospa = "id_user, fecha_pago, tipo_servicio, total_clases ,total_pagado, estado, profe, capita_rest"
datospa = "'"&idUsPa&"', getdate(), '"&idservicio&"', '"&tclases&"', '"&tpago&"', 1, '"&idprof&"', '"&tresta&"'"

camposcl = "id_user, fecha_clase, fecha_registro, id_reg, estado, id_controlPagos"
datoscl = "'"&idUsPa&"', '"&fechauso&"', getdate(), '"&idUser&"', 1, '"&idControlPagos&"' "

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



'Guarda Pago Adelantado' 
if comm = "agregaClaseAd" then
	    On Error Resume Next

	if idRegistro = 0 then
		guardarDatos "admi_registro_clases", camposcl, datoscl, dominio
		info = "{'ok':'ok', 'usuario':'"&idUsPa&"'}"

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

		sqlcons= "select cp.id_user, us.nombre_usuario, convert(varchar, cp.fecha_pago,6), cp.total_clases, tp.tipo_servicio, cp.total_pagado, p.nombre, isnull(cp.clases_tomadas,0), isnull(cp.capita_rest,0), cp.id from admin_control_pagosAd cp "&_
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
				tomadas = datos(7,l)
				resta =  datos(8,l)
			   quedan = clases -  tomadas
			   idr = datos(9,l)

                  verinfo = "<button class=//md-btn md-raised mb-2 success// onclick=//javascript:verInfo("&id&",&#39;"&nombre&"&#39;,"&idr&")//><i class=//fa fa-pencil-square-o//></i></button>"
			      agregaclase = "<button class=//md-btn md-raised mb-2 indigo// onclick=//javascript:agregamosClase("&id&",&#39;"&nombre&"&#39;,"&idr&")//><i class=//fa fa-check//></i></button>"

				
				info = info & "{'id':'"&id&"', 'nombre':'"&nombre&"', 'fecha':'"&fecha&"', 'clases':'"&clases&"', 'tomadas':'"&tomadas&"', 'restan':'"&quedan&"' , 'pago':'"&formatCurrency(pago,2)&"', 'resta':'"&formatCurrency(resta,2)&"', 'tipo':'"&tipo&"', 'profe':'"&profe&"', 'info':'"&verinfo&"', 'accion':'"&agregaclase&"'},"
			next	
			info = left(info, len(info)-1)
		end if
	
	   
	If Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
		On Error GoTo 0
end if




' consulta pagos adelantados por fecha


if com = "consultaFecha" then
	    On Error Resume Next

'     if hasta IsEmpty then 
' 	a = new date 
' 	    hasta = a
' 	end if 
'    if desde IsEmpty then 
'      	b = new date 
' 	    desde = b
' 	end if 

		sqlcons= "select cp.id_user, us.nombre_usuario, convert(varchar, cp.fecha_pago,6), cp.total_clases, tp.tipo_servicio, cp.total_pagado, p.nombre, isnull(cp.clases_tomadas,0), isnull(cp.capita_rest,0), cp.id from admin_control_pagosAd cp "&_
					"inner join admin_usu_pa us on cp.id_user = us.id "&_
					"inner join admin_tipoServicio tp on cp.tipo_servicio = tp.id "&_
					"inner join admin_profesores p on cp.profe = p.id "&_
					"where cp.estado = 1 and cast(cp.fecha_pago as date) >= cast('"&periodoDesde&"' as date) and cast(cp.fecha_pago as date) <= cast('"&periodoA&"' as date)"

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
				tomadas = datos(7,l)
				resta =  datos(8,l)		
				idr = datos(9,l)
			      quedan = clases -  tomadas
                  verinfo = "<button class=//md-btn md-raised mb-2 success// onclick=//javascript:verInfo("&id&",&#39;"&nombre&"&#39;,"&idr&")//><i class=//fa fa-pencil-square-o//></i></button>"
			      agregaclase = "<button class=//md-btn md-raised mb-2 indigo// onclick=//javascript:agregamosClase("&id&",&#39;"&nombre&"&#39;,"&idr&")//><i class=//fa fa-check//></i></button>"

				
				info = info & "{'id':'"&id&"', 'nombre':'"&nombre&"', 'fecha':'"&fecha&"', 'clases':'"&clases&"', 'tomadas':'"&tomadas&"', 'restan': '"&quedan&"', 'pago':'"&formatCurrency(pago,2)&"', 'resta':'"&formatCurrency(resta,2)&"', 'tipo':'"&tipo&"', 'profe':'"&profe&"', 'info':'"&verinfo&"', 'accion':'"&agregaclase&"'},"
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
if com = "listaClasesTomadas" then
	    On Error Resume Next

		sqlcons= "select rc.id, convert(varchar,rc.fecha_clase,6) from admi_registro_clases rc "&_
				 "inner join admin_usu_pa upa on rc.id_user = upa.id "&_
				  "where rc.estado =1 and rc.id_controlPagos = '"&id_ControlPagos&"'" 

   		 datos = executee(sqlcons,dominio)

	 	 if not IsEmpty(datos) then
		
			for l=0 to ubound(datos,2)

				id = datos(0,l)
		     	fecha = datos(1,l)
		
					
			
                  accion = "<button class=//md-btn md-raised mb-2 indigo// onclick=//javascript:borrarClase("&id&")//><i class=//fa fa-trash//></i></button>"

				
				info = info & "{'id':'"&id&"', 'fecha':'"&fecha&"', 'accion':'"&accion&"'},"
			next	
			info = left(info, len(info)-1)
		end if
	
	   
	If Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
		On Error GoTo 0
end if




' borra el usuario para clase adelantada 
if comm = "borrarUser"  then
	ActualizarDatos "admin_usu_pa", "estado=0, fecha_baja=getdate(), id_baja="&idUser&" ", "id='"&idUsPa&"' ", dominio
	info = "{'ok':'ok'}"
end if

' borra la clase adelantada 
if comm = "borrarClase"  then
	ActualizarDatos "admi_registro_clases", "estado=0, fecha_baja=getdate(), id_baja="&idUser&" ", "id='"&idUsPa&"' ", dominio
	info = "{'ok':'ok','usuario':'"&idUsPa&"'}"
end if


if comm = "borraPagoAdelantado"  then
	ActualizarDatos "admin_control_pagosAd", "estado=0, fecha_baja=getdate(), id_baja="&idUser&" ", "id_user='"&idUsPa&"' ", dominio
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


if comm = "calculocostounitarioPa" then	    
     
	On Error Resume Next
	sql = "select id, costo_hora from admin_tipoServicio where estado=1 and id = '"&idservicio&"'"
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
       
	   id = datos(0,l)
	   precio = datos(1,l)
		if id = 3 then 
		precio = (precio/8)
		end if
       

	end if 		

	info = "{'ok':'ok', 'id':'"&id&"', 'costo':'"&precio&"'}"
	If Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
		On Error GoTo 0
	
	  
end if


if comm = "verClasesRestantes" then	    
     
	On Error Resume Next
	sql1 = "select total_clases from admin_control_pagosAd  where estado = 1 and id = '"&idRegistro&"'"
	datos1 = executee(sql1,dominio)
	
	if not IsEmpty(datos1) then
       
	clasesTotales = datos1(0,l) 

	end if 

	sql2 = "select isnull(count(id),0) from admi_registro_clases where id_controlPagos = '"&idRegistro&"' and estado = 1"
	datos2 = executee(sql2,dominio)
	
	if not IsEmpty(datos2) then
       
	clasestomadas = datos2(0,l) 

	end if 		
	clasesRestantes = clasesTotales - clasestomadas

		ActualizarDatos "admin_control_pagosAd", "clases_tomadas='"&clasestomadas&"', clases_restantes='"&clasesRestantes&"'", "id='"&idRegistro&"' ", dominio

	info = "{'ok':'ok', 'id':'"&id&"', 'resta':'"&clasesRestantes&"'}"
	If Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
		On Error GoTo 0
	
	  
end if

if comm = "actualizaClases" then	    
     
	On Error Resume Next
	sql1 = "select total_clases, total_pagado, s.costo_hora, cpa.tipo_servicio  from admin_control_pagosAd cpa "&_
			"inner join admin_tipoServicio s on s.id = cpa.tipo_servicio "&_
			"where cpa.estado = 1 and cpa.id = '"&idRegistro&"'" 

	datos1 = executee(sql1,dominio)
	
	if not IsEmpty(datos1) then
       
	clasesTotales = datos1(0,l) 
	cInicial = datos1(1,l)
	costoh = datos1(2,l)
	tipo = datos1(3,l) 

	if tipo = 3 then
	costor = costoh/8

	else 
	costor = costoh

	end if 

	end if 

	sql2 = "select isnull(count(id),0) from admi_registro_clases where id_controlPagos = '"&idRegistro&"' and estado = 1"
	datos2 = executee(sql2,dominio)
	
	if not IsEmpty(datos2) then
       
	clasestomadas = datos2(0,l) 

	end if 		
	clasesRestantes = clasesTotales - clasestomadas
	capitalr = (cInicial) - (clasestomadas*costor)

		ActualizarDatos "admin_control_pagosAd", "clases_tomadas='"&clasestomadas&"', clases_restantes='"&clasesRestantes&"', capita_rest ='"&capitalr&"'", "id='"&idRegistro&"' and estado = 1", dominio

	info = "{'ok':'ok', 'id':'"&id&"', 'resta':'"&clasesRestantes&"'}"
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
