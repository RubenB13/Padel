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
com = request.queryString("com")
idRegistro = request.form("idReg")
claveusuario = request.form("Clave")
comm = request.form("comm")
tabla1 = "admin_historia_Caja"

'SOLICITO DATOS DE TABLA' 
 txtConcepto  = Request.form("txtTrans1")
 txtTipo  = request.form("TipoTrans")
 txtClasif = request.form("clasTrans")
 txtFechaRealizada = request.form("txtFechatrans")
 txtResponsable = request.form("txtResponsable")
 txtCosto= request.form("txtCantidad")

if com = "ConsultaCaja" then
	    On Error Resume Next

		sqlrescaja="select"&_ 
							"(select ISNULL(sum(Cantidad),0) from admin_historia_Caja where Estado=1 and Tipo_Trans_Caja=1 and cast(Fecha_trans_caja as date) >= cast('"&periodoDesde&"' as date ) and cast(Fecha_trans_caja as date)<= CAST('"&periodoA&"' as date )) as ing,"&_							
							"(select ISNULL(sum(Cantidad),0) from admin_historia_Caja where Estado=1 and Tipo_Trans_Caja=2 and cast(Fecha_trans_caja as date) >= cast('"&periodoDesde&"' as date ) and cast(Fecha_trans_caja as date)<= CAST('"&periodoA&"' as date )) as egr"

		resCaja = executee(sqlrescaja,dominio)

		if not IsEmpty(resCaja) then
		ttEntrada = resCaja(0,l)
		ttSalida = resCaja(1,l)
		else 
		ttEntrada = 0
		ttSalida = 0
		end if
		balancePeriodo = ttEntrada - ttSalida

	   
	   info = "{'ok':'ok', 'Concepto':'Monto', 'Total_de_Entrada':'"&formatcurrency(ttEntrada,2)&"', 'Total_de_Salida':'"&formatcurrency(ttSalida,2)&"', 'Balance_en_caja':'"&formatcurrency(balancePeriodo,2)&"'}"		 
		
	if Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
	
	On Error GoTo 0
end if

if com = "datosCajas" then

	    On Error Resume Next
		  sqltrans = " select "&_
						"(select COUNT(*) from admin_historia_Caja where Estado=1 and Tipo_Trans_Caja=1 and Clas_trans_Caja=1 and cast(Fecha_trans_caja as date) >= cast('"&periodoDesde&"' as date ) and cast(Fecha_trans_caja as date)<= CAST('"&periodoA&"' as date )) as pagoSer,"&_
						"(select COUNT(*) from admin_historia_Caja where Estado=1 and Tipo_Trans_Caja=1 and Clas_trans_Caja=2 and cast(Fecha_trans_caja as date) >= cast('"&periodoDesde&"' as date ) and cast(Fecha_trans_caja as date)<= CAST('"&periodoA&"' as date )) as PagoPar,"&_
						"(select COUNT(*) from admin_historia_Caja where Estado=1 and Tipo_Trans_Caja=1 and Clas_trans_Caja=3 and cast(Fecha_trans_caja as date) >= cast('"&periodoDesde&"' as date ) and cast(Fecha_trans_caja as date)<= CAST('"&periodoA&"' as date )) as PagoAd,"&_
						"(select COUNT(*) from admin_historia_Caja where Estado=1 and Tipo_Trans_Caja=1 and Clas_trans_Caja=4 and  cast(Fecha_trans_caja as date) >= cast('"&periodoDesde&"' as date ) and cast(Fecha_trans_caja as date)<= CAST('"&periodoA&"' as date )) as venta,"&_
						"(select COUNT(*) from admin_historia_Caja where Estado=1 and Tipo_Trans_Caja=1 and Clas_trans_Caja=5 and cast(Fecha_trans_caja as date) >= cast('"&periodoDesde&"' as date ) and cast(Fecha_trans_caja as date)<= CAST('"&periodoA&"' as date )) as otro,"&_
						"(select ISNULL(sum(Cantidad),0) from admin_historia_Caja where Estado=1 and Tipo_Trans_Caja=1 and Clas_trans_Caja=1 and cast(Fecha_trans_caja as date) >= cast('"&periodoDesde&"' as date ) and cast(Fecha_trans_caja as date)<= CAST('"&periodoA&"' as date )) as pagoSer,"&_
						"(select ISNULL(sum(Cantidad),0) from admin_historia_Caja where Estado=1 and Tipo_Trans_Caja=1 and Clas_trans_Caja=2 and cast(Fecha_trans_caja as date) >= cast('"&periodoDesde&"' as date ) and cast(Fecha_trans_caja as date)<= CAST('"&periodoA&"' as date )) as PagoPar,"&_
						"(select ISNULL(sum(Cantidad),0) from admin_historia_Caja where Estado=1 and Tipo_Trans_Caja=1 and Clas_trans_Caja=3 and cast(Fecha_trans_caja as date) >= cast('"&periodoDesde&"' as date ) and cast(Fecha_trans_caja as date)<= CAST('"&periodoA&"' as date )) as PagoAd,"&_
						"(select ISNULL(sum(Cantidad),0) from admin_historia_Caja where Estado=1 and Tipo_Trans_Caja=1 and Clas_trans_Caja=4 and  cast(Fecha_trans_caja as date) >= cast('"&periodoDesde&"' as date ) and cast(Fecha_trans_caja as date)<= CAST('"&periodoA&"' as date )) as venta,"&_
						"(select ISNULL(sum(Cantidad),0) from admin_historia_Caja where Estado=1 and Tipo_Trans_Caja=1 and Clas_trans_Caja=5 and cast(Fecha_trans_caja as date) >= cast('"&periodoDesde&"' as date ) and cast(Fecha_trans_caja as date)<= CAST('"&periodoA&"' as date )) as otro"
							
        trans= executee(sqltrans,dominio)
		if not IsEmpty(trans) then 
			pagoser   = trans(0,l)
			pagopar   = trans(1,l)
			pagoade   = trans(2,l)
			venta     = trans(3,l)
			otros     = trans(4,l)
			Cpagoser  = trans(5,l)
			Cpagopar  = trans(6,l)
			Cpagoade  = trans(7,l)
			Cventa    = trans(8,l)
			Cotros    = trans(9,l)
		else  
			pagoser    = 0
			pagopar    = 0
			pagoade    = 0
			pagovent   = 0
			otros      = 0
			venta      = 0 
			Cpagoser   = 0
			Cpagopar   = 0
			Cpagoade   = 0
			Cventa     = 0
			Cotros     = 0
		end if
	   info = "{'ok':'ok', 'Concepto':'transaciones', 'Pago de servicios':'"&pagoser&"', 'Pago Parciales':'"&pagopar&"', 'Pagos Adelantados':'"&pagoade&"', 'Ventas':'"&venta&"', 'Otros':'"&otros&"'}, {'ok':'ok', 'Concepto':'monto', 'Pago de servicios':'"&formatcurrency(Cpagoser,2)&"', 'Pago Parciales':'"&formatcurrency(Cpagopar,2)&"', 'Pagos Adelantados':'"&formatcurrency(Cpagoade,2)&"', 'Ventas':'"&formatcurrency(Cventa,2)&"', 'Otros':'"&formatcurrency(Cotros,2)&"'}"
		 
		
		if Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
	
	On Error GoTo 0
end if


'historial completo
if com = "ConsultarHistoriaCaja" then
	    On Error Resume Next

		sqlcons= "select int,Desc_trans_caja,Tipo_Trans_Caja,Clas_trans_Caja,CONVERT(varchar,Fecha_trans_caja,103),Responsable_trans_caja,Cantidad from admin_historia_Caja where Estado=1 and cast(Fecha_trans_caja as date) >= cast('"&periodoDesde&"' as date ) and cast(Fecha_trans_caja as date) <= cast('"&periodoA&"' as date )"

   		 historiaCaja = executee(sqlcons,dominio)

	 	 if not IsEmpty(historiaCaja) then
		
			for l=0 to ubound(historiaCaja,2)

				id = historiaCaja(0,l)
				desc = historiaCaja(1,l)
				tipo = historiaCaja(2,l)
				if tipo = 1 then 
				tipo= "Entrada"
				elseif tipo = 2 then 
				tipo = "Salida"
				end if
				clase = historiaCaja(3,l)
				if clase =  1 then 
					clase = "Pago de Servicio" 
					elseif clase =  2 then 
					clase = "Pago Parcial" 
					elseif clase =  3 then 
					clase = "Pago adelantado" 
					elseif clase =  4 then 
					clase = "Venta" 
					elseif clase =  5 then 
					clase = "Otro" 
				end if

				fecha = historiaCaja(4,l)
				resp =  historiaCaja(5,l)
				cantidad = historiaCaja(6,l)
				
				eliminarTrans = "<button class=//md-btn md-raised mb-2 blue//><i class=//fa fa-trash// onclick=javascript:borrarRegistro("&id&")></i></button>&nbsp"
			    ' actualizarTrans = "<button class=//md-btn md-raised mb-2 indigo//><i class=//fa fa-refresh//onclick=javascript:claveModificar("&id&")></i></button>"

				info = info & "{'Id':'"&id&"', 'Descripcion':'"&desc&"', 'Tipo':'"&tipo&"', 'Clasificacion':'"&clase&"', 'Fecha realizada':'"&fecha&"', 'Responsable':'"&resp&"', 'Cantidad':'"&formatcurrency(cantidad,2)&"', 'Accion':'"&eliminarTrans&"'},"
			next	
			info = left(info, len(info)-1)
		end if
	
	   
	If Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
		On Error GoTo 0
end if

' tabla de transacciones por mes
if com = "consultaMes" then
	    On Error Resume Next

		sqlcons= "select int,Desc_trans_caja,Tipo_Trans_Caja,Clas_trans_Caja,CONVERT(varchar,Fecha_trans_caja,103),Responsable_trans_caja,Cantidad "&_
				 "from admin_historia_Caja where Estado=1 and month(Fecha_trans_caja) = month(getdate())"

   		 historiaCaja = executee(sqlcons,dominio)

	 	 if not IsEmpty(historiaCaja) then
		
			for l=0 to ubound(historiaCaja,2)

				id = historiaCaja(0,l)
				desc = historiaCaja(1,l)
				tipo = historiaCaja(2,l)
				if tipo = 1 then 
				tipo= "Entrada"
				elseif tipo = 2 then 
				tipo = "Salida"
				end if
				clase = historiaCaja(3,l)
				if clase =  1 then 
					clase = "Pago de Servicio" 
					elseif clase =  2 then 
					clase = "Pago Parcial" 
					elseif clase =  3 then 
					clase = "Pago adelantado" 
					elseif clase =  4 then 
					clase = "Venta" 
					elseif clase =  5 then 
					clase = "Otro" 
				end if

				fecha = historiaCaja(4,l)
				resp =  historiaCaja(5,l)
				cantidad = historiaCaja(6,l)
				
				eliminarTrans = "<button class=//md-btn md-raised mb-2 blue//><i class=//fa fa-trash// onclick=javascript:eliminarTransaccionCaja("&id&")></i></button>&nbsp"
			    actualizarTrans = "<button class=//md-btn md-raised mb-2 indigo//><i class=//fa fa-refresh//onclick=javascript:ModificarTransaccionCaja("&id&")></i></button>"

				info = info & "{'Id':'"&id&"', 'Descripcion':'"&desc&"', 'Tipo':'"&tipo&"', 'Clasificacion':'"&clase&"', 'Fecha realizada':'"&fecha&"', 'Responsable':'"&resp&"', 'Cantidad':'"&formatcurrency(cantidad,2)&"', 'Accion':'"&eliminarTrans&actualizarTrans&"'},"
			next	
			info = left(info, len(info)-1)
		end if
	
	   
	If Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
		On Error GoTo 0
end if


' tabla de transacciones por mes
if com = "consultaCaja" then
	    On Error Resume Next

		sqlcons= "select int,Desc_trans_caja,Tipo_Trans_Caja,Clas_trans_Caja,CONVERT(varchar,Fecha_trans_caja,103),Responsable_trans_caja,Cantidad "&_
                 "from admin_historia_Caja where Estado=1 "&_ 
				 "and cast(Fecha_trans_caja as date) >= cast('"&periodoDesde&"' as date) and  cast(Fecha_trans_caja as date) <= cast('"&periodoA&"' as date)"

   		 historiaCaja = executee(sqlcons,dominio)

	 	 if not IsEmpty(historiaCaja) then
		
			for l=0 to ubound(historiaCaja,2)

				id = historiaCaja(0,l)
				desc = historiaCaja(1,l)
				tipo = historiaCaja(2,l)
				if tipo = 1 then 
				tipo= "Entrada"
				elseif tipo = 2 then 
				tipo = "Salida"
				end if
				clase = historiaCaja(3,l)
				if clase =  1 then 
					clase = "Pago de Servicio" 
					elseif clase =  2 then 
					clase = "Pago Parcial" 
					elseif clase =  3 then 
					clase = "Pago adelantado" 
					elseif clase =  4 then 
					clase = "Venta" 
					elseif clase =  5 then 
					clase = "Otro" 
				end if

				fecha = historiaCaja(4,l)
				resp =  historiaCaja(5,l)
				cantidad = historiaCaja(6,l)
				
				eliminarTrans = "<button class=//md-btn md-raised mb-2 blue//><i class=//fa fa-trash// onclick=javascript:eliminarTransaccionCaja("&id&")></i></button>&nbsp"
			    actualizarTrans = "<button class=//md-btn md-raised mb-2 indigo//><i class=//fa fa-refresh//onclick=javascript:ModificarTransaccionCaja("&id&")></i></button>"

				info = info & "{'Id':'"&id&"', 'Descripcion':'"&desc&"', 'Tipo':'"&tipo&"', 'Clasificacion':'"&clase&"', 'Fecha realizada':'"&fecha&"', 'Responsable':'"&resp&"', 'Cantidad':'"&formatcurrency(cantidad,2)&"', 'Accion':'"&eliminarTrans&actualizarTrans&"'},"
			next	
			info = left(info, len(info)-1)
		end if
	
	   
	If Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
		On Error GoTo 0
end if



' contulsta de transacción para modificar
if comm = "verTrans" then
	On Error Resume Next

	sqlcons= "select int,Desc_trans_caja,Tipo_Trans_Caja,Clas_trans_Caja,Fecha_trans_caja,Responsable_trans_caja,Cantidad from admin_historia_Caja where Estado=1 and int ='"&idRegistro&"'"

		historiaCaja = executee(sqlcons,dominio)

		if not IsEmpty(historiaCaja) then
	
			id = historiaCaja(0,l)
			desc = historiaCaja(1,l)
			tipo = historiaCaja(2,l)
			clase = historiaCaja(3,l)
			fecha = historiaCaja(4,l)
			resp =  historiaCaja(5,l)
			cantidad = historiaCaja(6,l)
		end if
			
			info = "{'ok':'ok', 'Id':'"&id&"', 'Descripcion':'"&desc&"', 'Tipo':'"&tipo&"', 'Clasificacion':'"&clase&"', 'Fecha':'"&fecha&"', 'Responsable':'"&resp&"', 'Cantidad':'"&cantidad&"'}"
			
	
	If Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
	On Error GoTo 0
end if




if com = "ConsultaAnt" then
	    On Error Resume Next

		sqlrescaja="select "&_
					"(Select isnull(sum(Cantidad),0) from admin_historia_Caja where Estado = 1 and Tipo_Trans_Caja=1 and month(Fecha_trans_caja) = MONTH('"&periodoA&"')) as EmC,"&_
					"(Select isnull(sum(Cantidad),0) from admin_historia_Caja where Estado = 1 and Tipo_Trans_Caja=1 and month(Fecha_trans_caja) = MONTH(dateadd(MM,-1,'"&periodoA&"'))) as EmA, "&_
					"(Select isnull(sum(Cantidad),0) from admin_historia_Caja where Estado = 1 and Tipo_Trans_Caja=2 and month(Fecha_trans_caja) = MONTH('"&periodoA&"')) as SmC, "&_
					"(Select isnull(sum(Cantidad),0) from admin_historia_Caja where Estado = 1 and Tipo_Trans_Caja=2 and month(Fecha_trans_caja) = MONTH(dateadd(MM,-1,'"&periodoA&"'))) as SmA"
						

		resCaja = executee(sqlrescaja,dominio)

		if not IsEmpty(resCaja) then
		ec1 = resCaja(0,l)
		ec0 = resCaja(1,l)
		sc1= resCaja(2,l)
		sc0 = resCaja(3,l)
		else 
		ec1 = 0
		ec0 = 0
		sc1 = 0
		sc0 = 0
		end if
		bca1 = ec1 - sc1
		bca0 = ec0 - sc0
	   
	   info = "{'ok':'ok', 'Balance_en_caja':'"&formatcurrency(bca1,2)&"', 'balance_anterior':'"&formatcurrency(bca0,2)&"'}"		 
		
	if Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
	
	On Error GoTo 0
end if


if comm = "buscaUsuarioParaEliminarRegistro" and idRegistro <> "" then
	sql = "select id, nombre from admin_usuarios where clave='"&idRegistro&"' and tipo = 1 "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		info = "{'ok':'ok'}"	
	else
		info = "{'ok':'noOk'}"	
	end if
end if	

if comm = "eliminar_trans" and idRegistro > 0 then
	ActualizarDatos tabla1, "Estado=0, fecha_baja=getdate(), id_usuario_baja="&idUser&" ", "int='"&idRegistro&"' ", dominio
	info = "{'ok':'ok'}"
end if

'asp modificar trans' 

if comm = "modificar_trans" and idRegistro > 0 then
	ActualizarDatos tabla1, "Desc_trans_caja='"&txtConcepto&"', Fecha_trans_caja='"&txtFechaRealizada&"', Cantidad='"&txtCosto&"'", "int='"&idRegistro&"' ", dominio
	info = "{'ok':'ok'}"


end if


' ver datos para modificar 
if comm = "vertransCaja" then
	sql = "select Desc_trans_caja, cantidad, fecha_trans_caja  from admin_historia_caja where estado = 1 and int = '"&idRegistro&"' "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
	    desc = datos(0,l)
	    cant = datos(1,l)
	    fec = datos(2,l)

		info = "{'ok':'ok', 'desc':'"&desc&"', 'cant':'"&cant&"', 'fech':'"&fec&"'}"	
	else
		info = "{'ok':'noOk'}"	
	end if
end if	


respuesta = "{'data':["&info&"]}"
respuesta = Replace(respuesta, "'", chr(34))
respuesta = replace(respuesta,"//","'")
response.Write(respuesta)
%>