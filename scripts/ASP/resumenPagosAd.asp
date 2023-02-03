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



 periodoDesde = request.QueryString("de")
 periodoA = request.QueryString("a")


 comm = request.form("comm")
 idRegistro = request.form("idReg")
 com = request.queryString("com")





'datos del resumen del mes
if com = "verResumenMes" then
	    On Error Resume Next

		sqlcons= "select isnull(sum(total_clases),0), isnull(sum(total_pagado),0), isnull(sum(clases_tomadas),0), isnull(sum(capita_rest),0)   from admin_control_pagosAd where estado = 1 and month(fecha_pago) = month(getdate())"

   		 datos = executee(sqlcons,dominio)

			totalclases = datos(0,l)
			totalpagado = datos(1,l)
			clasestomadas = datos(2,l)
			capitalRestante = datos(3,l)

         	clasesrestantes = totalclases - clasestomadas
			
   info = "{'totalClases':'"&totalclases&"', 'totalPagado':'"&formatcurrency(totalpagado,2)&"', 'ClasesRestantes':'"&clasesrestantes&"', 'CapitalRestante':'"&formatcurrency(capitalRestante,2)&"'}"

	
	   
	If Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
		On Error GoTo 0
end if

if com = "verResumenMesTipo" then 
 On Error Resume Next 

 sql = "select "&_
			"(select ISNULL(sum(total_clases),0) from admin_control_pagosAd where estado = 1 and tipo_servicio = 3 and month(fecha_pago) = month(getdate())), "&_
			"(select ISNULL(sum(total_clases),0) from admin_control_pagosAd where estado = 1 and tipo_servicio = 4 and month(fecha_pago) = month(getdate())), "&_
			"(select ISNULL(sum(total_clases),0) from admin_control_pagosAd where estado = 1 and tipo_servicio = 5 and month(fecha_pago) = month(getdate())), "&_
			"(select ISNULL(sum(total_pagado),0) from admin_control_pagosAd where estado = 1 and tipo_servicio = 3 and month(fecha_pago) = month(getdate())), "&_
			"(select ISNULL(sum(total_pagado),0) from admin_control_pagosAd where estado = 1 and tipo_servicio = 4 and month(fecha_pago) = month(getdate())), "&_
			"(select ISNULL(sum(total_pagado),0) from admin_control_pagosAd where estado = 1 and tipo_servicio = 5 and month(fecha_pago) = month(getdate()))"


cons = executee(sql, dominio)
   
totalCAca = cons(0,l)
totalCGru = cons(1,l)
totalCPart = cons(2,l)
ingAca = cons(3,l)
ingGru = cons(4,l)
ingPar = cons(5,l)


info = "{'tipo':'Academia', 'total':'"&totalCAca&"','ingreso':'"&formatcurrency(ingAca,2)&"'}, {'tipo':'Grupal', 'total':'"&totalCGru&"','ingreso':'"&formatcurrency(ingGru,2)&"'}, {'tipo':'Particular', 'total':'"&totalCPart&"','ingreso':'"&formatcurrency(ingPar,2)&"'}"

if Err.Number <> 0 then 
  Response.write(Err.Description)
  Response.End
  end if 
  On Error GoTo 0


end if 


'consulta por fecha de tipos de clases de pago adelantado
if com = "verResumenMesTipoCons" then 
 On Error Resume Next 

 sql = "select "&_
			"(select ISNULL(sum(total_clases),0) from admin_control_pagosAd where estado = 1 and tipo_servicio = 3 and cast(fecha_pago as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_pago as date) <= cast('"&periodoA&"' as date)), "&_
			"(select ISNULL(sum(total_clases),0) from admin_control_pagosAd where estado = 1 and tipo_servicio = 4 and cast(fecha_pago as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_pago as date) <= cast('"&periodoA&"' as date)), "&_
			"(select ISNULL(sum(total_clases),0) from admin_control_pagosAd where estado = 1 and tipo_servicio = 5 and cast(fecha_pago as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_pago as date) <= cast('"&periodoA&"' as date)), "&_
			"(select ISNULL(sum(total_pagado),0) from admin_control_pagosAd where estado = 1 and tipo_servicio = 3 and cast(fecha_pago as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_pago as date) <= cast('"&periodoA&"' as date)), "&_
			"(select ISNULL(sum(total_pagado),0) from admin_control_pagosAd where estado = 1 and tipo_servicio = 4 and cast(fecha_pago as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_pago as date) <= cast('"&periodoA&"' as date)), "&_
			"(select ISNULL(sum(total_pagado),0) from admin_control_pagosAd where estado = 1 and tipo_servicio = 5 and cast(fecha_pago as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_pago as date) <= cast('"&periodoA&"' as date))"


cons = executee(sql, dominio)
   
totalCAca = cons(0,l)
totalCGru = cons(1,l)
totalCPart = cons(2,l)
ingAca = cons(3,l)
ingGru = cons(4,l)
ingPar = cons(5,l)


info = "{'tipo':'Academia', 'total':'"&totalCAca&"','ingreso':'"&formatcurrency(ingAca,2)&"'}, {'tipo':'Grupal', 'total':'"&totalCGru&"','ingreso':'"&formatcurrency(ingGru,2)&"'}, {'tipo':'Particular', 'total':'"&totalCPart&"','ingreso':'"&formatcurrency(ingPar,2)&"'}"

if Err.Number <> 0 then 
  Response.write(Err.Description)
  Response.End
  end if 
  On Error GoTo 0


end if 



'datos del resumen del mes
if com = "verResumenGlobal" then
	    On Error Resume Next

		sqlcons= "select isnull(sum(total_clases),0), isnull(sum(total_pagado),0), isnull(sum(clases_tomadas),0), isnull(sum(capita_rest),0)   from admin_control_pagosAd where estado = 1"

   		 datos = executee(sqlcons,dominio)

			totalclases = datos(0,l)
			totalpagado = datos(1,l)
			clasestomadas = datos(2,l)
			capitalRestante = datos(3,l)

         	clasesrestantes = totalclases - clasestomadas
			
   info = "{'totalClases':'"&totalclases&"', 'totalPagado':'"&formatcurrency(totalpagado,2)&"', 'ClasesRestantes':'"&clasesrestantes&"', 'CapitalRestante':'"&formatcurrency(capitalRestante,2)&"'}"

	
	   
	If Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
		On Error GoTo 0
end if


'datos del resumen del mes
if com = "ConsultarMes" then
	    On Error Resume Next

		sqlcons= "select isnull(sum(total_clases),0), isnull(sum(total_pagado),0), isnull(sum(clases_tomadas),0), isnull(sum(capita_rest),0)   from admin_control_pagosAd where estado = 1 and cast(fecha_pago as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_pago as date) <= cast('"&periodoA&"' as date)"

   		 datos = executee(sqlcons,dominio)

			totalclases = datos(0,l)
			totalpagado = datos(1,l)
			clasestomadas = datos(2,l)
			capitalRestante = datos(3,l)

         	clasesrestantes = totalclases - clasestomadas
			
   info = "{'totalClases':'"&totalclases&"', 'totalPagado':'"&formatcurrency(totalpagado,2)&"', 'ClasesRestantes':'"&clasesrestantes&"', 'CapitalRestante':'"&formatcurrency(capitalRestante,2)&"'}"

	
	   
	If Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
		On Error GoTo 0
end if



'lista de pagos adelantados
if com = "VerDetallePa" then
	    On Error Resume Next

		sqlcons= "select usuarios.nombre_usuario, FORMAT(pagos.fecha_pago, 'd MMMM yyyy','es-US'), pagos.total_pagado  from admin_control_pagosAd pagos "&_
				  "inner join admin_usu_pa usuarios on usuarios.id = pagos.id_user "&_
				  "where pagos.estado = 1 and CAST(pagos.fecha_pago as date) >= CAST('"&periodoDesde&"' as date) and CAST(pagos.fecha_pago as date) <= CAST('"&periodoA&"' as date)"

   		 datos = executee(sqlcons,dominio)

	 	 if not IsEmpty(datos) then
		
			for l=0 to ubound(datos,2)

		                   
				
				info = info & "{ 'usuario':'"&datos(0,l)&"' , 'fechaPago':'"&datos(1,l)&"', 'Cantidad':'"&formatCurrency(datos(2,l),2)&"'},"
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
if com = "DetalleClases" then
	    On Error Resume Next

		sqlcons= "select usuario.nombre_usuario,  FORMAT(clases.fecha_clase, 'd MMMM yyyy','es-US'), (pagos.total_pagado/pagos.total_clases) "&_
				" from admi_registro_clases clases "&_
				" inner join admin_control_pagosAd pagos on pagos.id = clases.id_controlPagos "&_
				" inner join admin_usu_pa usuario on usuario.id = clases.id_user "&_ 
				" where clases.estado = 1 and CAST(clases.fecha_clase as date) >= CAST('"&periodoDesde&"' as date) and CAST(clases.fecha_clase as date) <= CAST('"&periodoA&"' as date)"

   		 datos = executee(sqlcons,dominio)

	 	 if not IsEmpty(datos) then
		
			for l=0 to ubound(datos,2)

		                   
				
				info = info & "{ 'usuario':'"&datos(0,l)&"' , 'fecha':'"&datos(1,l)&"', 'monto':'"&formatCurrency(datos(2,l),2)&"'},"
			next	
			info = left(info, len(info)-1)
		end if
	
	   
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
