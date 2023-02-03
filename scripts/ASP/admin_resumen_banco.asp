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
 cboTipoTransaccion = request.form("cboTipoTransaccion")
 ' Banco = request.form("banco")
 txtFechaRealizada = request.form("txtFechatrans")
 txtResponsable = request.form("txtResponsable")
 cantidad_trans= request.form("cantidad_trans")



 periodoDesde = request.QueryString("de")
 periodoA = request.QueryString("a")


 comm = request.form("comm")
 idRegistro = request.form("idReg")
 com = request.queryString("com")
 fi = request.queryString("fi")
 ff = request.queryString("ff")


if com = "listarResumenBanco" then
	
	sql = " select "&_
		" (select ISNULL(sum(ban.cantidad),0) from admin_historia_Banco ban where ban.Estado=1 and ban.tipo_trans_banco=1 "&_
		" and (cast(ban.fecha_trans_banco as date) >= cast('"&fi&"' as date) and cast(ban.fecha_trans_banco as date) <= cast('"&ff&"' as date)  ))AS totalEntrada, "&_
		" (select ISNULL(sum(ban.cantidad),0) from admin_historia_Banco ban where ban.Estado=1 and ban.tipo_trans_banco=2 "&_
		" and (cast(ban.fecha_trans_banco as date) >= cast('"&fi&"' as date) and cast(ban.fecha_trans_banco as date) <= cast('"&ff&"' as date)  ) ) AS totalSalida "

	datos = executee(sql, dominio)

	if not IsEmpty(datos) then
		l=0
		' for l=0 to ubound(datos,2)

			balance = formatcurrency(CDbl(datos(0,l)) - CDbl(datos(1,l)),2)
				
			info = "{'ok':'ok', 'concepto':'Monto', 'total_entrada':'"&formatcurrency(datos(0,l),2)&"', 'total_salida':'"&formatcurrency(datos(1,l),2)&"', 'balance':'"&balance&"'}"
		' next
		' info = left(info, len(info)-1)
	end if

end if


if com = "listarTransaccionesBanco" then
	
	sql = " select ISNULL(sum(ban.cantidad),0), ban.Clas_trans_banco, isnull(COUNT(ban.Clas_trans_banco),0) "&_
		" from admin_historia_Banco ban "&_
		" where ban.Estado=1 and "&_
		" (cast(ban.fecha_trans_banco as date) >= cast('"&fi&"' as date) and cast(ban.fecha_trans_banco as date) <= cast('"&ff&"' as date)) "&_
		" group by ban.Clas_trans_banco "

	datos = executee(sql, dominio)

	if not IsEmpty(datos) then
		l=0
		for l=0 to ubound(datos,2)

			if datos(1,l) = 1 then 
				pago_servicio = datos(0,l)
				numPS = datos(2,l)
		
			elseif datos(1,l) = 2 then
				pago_parcial = datos(0,l)
				numPP = datos(2,l)
			
			elseif datos(1,l) = 3 then
				pago_adelantado = datos(0,l)
				numPA = datos(2,l)
			 
			elseif datos(1,l) = 4 then
				venta = datos(0,l)
				numVenta = datos(2,l)
				
			elseif datos(1,l) = 5 then
				otro = datos(0,l)
				numOtro = datos(2,l)

			elseif datos(1,l) = 6 then
				cclip = datos(0,l)
				numcclip = datos(2,l)

			elseif datos(1,l) = 7 then
				cbanco = datos(0,l)
				numcbanco = datos(2,l)
			
			else 
			numP = 0
		    numPP = 0 
			numPA = 0 
			numVenta = 0 
			numOtro = 0 
			end if 
			 	
		next

		info = "{'ok':'ok', 'concepto':'Monto', 'pago_servicios':'"&formatcurrency(pago_servicio,2)&"', 'pago_parcial':'"&formatcurrency(pago_parcial,2)&"', 'pago_adelantado':'"&formatcurrency(pago_adelantado,2)&"', 'ventas':'"&formatcurrency(venta,2)&"', 'otros':'"&formatcurrency(otro,2)&"', 'cclip':'"&formatcurrency(cclip,2)&"', 'cbanco':'"&formatcurrency(cbanco,2)&"'}, {'ok':'ok', 'concepto':'Transacciones', 'pago_servicios':'"&numPS&"', 'pago_parcial':'"&numPP&"', 'pago_adelantado':'"&numPA&"', 'ventas':'"&numVenta&"', 'otros':'"&numOtro&"','cclip':'"&numcclip&"', 'cbanco':'"&numcbanco&"'}"
		' info = left(info, len(info)-1)
	end if

end if


if com = "listarHistorialBanco" then
	
	sql = " SELECT ban.id, ban.Desc_trans_banco, ban.tipo_trans_banco, ban.Clas_trans_banco, ban.tipo_transaccion, "&_
		" convert(varchar,ban.fecha_trans_banco,103), ban.Resp_trans_banco, ban.cantidad "&_
		" FROM admin_historia_Banco ban "&_
		" where ban.Estado= 1 and  "&_
		" (cast(ban.fecha_trans_banco as date) >= cast('"&fi&"' as date) and cast(ban.fecha_trans_banco as date) <= cast('"&ff&"' as date)) "

	datos = executee(sql, dominio)

	if not IsEmpty(datos) then
		l=0
		for l=0 to ubound(datos,2)

			if datos(2,l)=1 then
				tipoEntSal = "Entrada"
			elseif datos(2,l)=2 then
				tipoEntSal = "Salida"
			end if

			if datos(3,l) = 1 then 
				clasificacion = "Pago de servicio"
			elseif datos(3,l) = 2 then
				clasificacion = "Pago parcial"
			elseif datos(3,l) = 3 then
				clasificacion = "Pago adelantado"
			elseif datos(3,l) = 4 then
				clasificacion = "Venta"
			elseif datos(3,l) = 5 then
				clasificacion = "Otro"
			elseif datos(3,l) = 6 then
				clasificacion = "Comisión bancaría Clip"
			elseif datos(3,l) = 5 then
				clasificacion = "Comisión bancaria"
			end if 

			if datos(4,l)=1 then
				tipo_tra = "clip"
			elseif datos(4,l)=2 then
				tipo_tra = "Transferencia"
			elseif datos(4,l)=3 then
				tipo_tra = "Deposito"
			elseif datos(4,l)=4 then
				tipo_tra = "Comisión"
			end if

			eliminar = "<button class=//md-btn md-raised mb-2 blue//><i class=//fa fa-trash// onclick=javascript:eliminarTransaccion("&datos(0,l)&")></i></button>"
			
				
			info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'descripcion':'"&datos(1,l)&"', 'tipo':'"&tipoEntSal&"', 'clasificacion':'"&clasificacion&"', 'tipo_transaccion':'"&tipo_tra&"', 'fecha':'"&datos(5,l)&"', 'responsable':'"&datos(6,l)&"', 'monto':'"&formatcurrency(datos(7,l),2)&"', 'accion':'"&eliminar&"'},"
		next
		info = left(info, len(info)-1)
	end if

end if


if com = "consultaClas" then


		  sqltrans = "select "&_
							"(select ISNULL(COUNT(tipo_transaccion),0)  from admin_historia_Banco where estado = 1 and tipo_transaccion = 1 and (cast(fecha_trans_banco as date) >= '"&fi&"') and (cast(fecha_trans_banco as date) <= '"&ff&"'))as clip, "&_
							"(select ISNULL(COUNT(tipo_transaccion),0)  from admin_historia_Banco where estado = 1 and tipo_transaccion = 2 and (cast(fecha_trans_banco as date) >= '"&fi&"') and (cast(fecha_trans_banco as date) <= '"&ff&"'))as trasn, "&_
							"(select ISNULL(COUNT(tipo_transaccion),0) from admin_historia_Banco where estado = 1 and tipo_transaccion = 3 and (cast(fecha_trans_banco as date) >= '"&fi&"') and (cast(fecha_trans_banco as date) <= '"&ff&"')) as depo, "&_
							"(select ISNULL(sum(cantidad),0)  from admin_historia_Banco where estado = 1 and tipo_transaccion = 1 and (cast(fecha_trans_banco as date) >= '"&fi&"') and (cast(fecha_trans_banco as date) <= '"&ff&"'))as clip2, "&_
							"(select ISNULL(sum(cantidad),0)  from admin_historia_Banco where estado = 1 and tipo_transaccion = 2 and (cast(fecha_trans_banco as date) >= '"&fi&"') and (cast(fecha_trans_banco as date) <= '"&ff&"'))as trasn2, "&_
							"(select ISNULL(sum(cantidad),0) from admin_historia_Banco where estado = 1 and tipo_transaccion = 3 and (cast(fecha_trans_banco as date) >= '"&fi&"') and (cast(fecha_trans_banco as date) <= '"&ff&"')) as depo2, "&_
							"(select ISNULL(COUNT(tipo_transaccion),0) from admin_historia_Banco where estado = 1 and tipo_transaccion = 4 and (cast(fecha_trans_banco as date) >= '"&fi&"') and (cast(fecha_trans_banco as date) <= '"&ff&"')) as comi, "&_ 
							"(select ISNULL(sum(cantidad),0) from admin_historia_Banco where estado = 1 and tipo_transaccion = 4 and (cast(fecha_trans_banco as date) >= '"&fi&"') and (cast(fecha_trans_banco as date) <= '"&ff&"')) as comi"

        trans= executee(sqltrans,dominio)

		if not IsEmpty(trans) then 
			clipt   = trans(0,l)
			transt  = trans(1,l)
			dept    = trans(2,l)
			clip2   = trans(3,l)
			transt2 = trans(4,l)
			dept2   =  trans(5,l)
			comi   =  trans(6,l)
			comi2   =  trans(7,l)
		 else  
			clipt   = 0
			transt  = 0
			dept    = 0
			clip2   = 0
			transt2 = 0
			dept2   = 0
			comi   = 0
			comi2   = 0
		end if

		totalt = clipt + transt + dept+ comi
		totalc = (clip2 + transt2 + dept2)-comi2

	   info = "{'ok':'ok', 'Concepto':'Transacciones', 'clip':'"&clipt&"', 'transferencia':'"&transt&"', 'deposito':'"&dept&"', 'comision':'"&comi&"' , 'total':'"&totalt&"'}, {'ok':'ok', 'Concepto':'Transacciones', 'clip':'"&formatcurrency(clip2,0)&"', 'transferencia':'"&formatcurrency(transt2,2)&"', 'deposito':'"&formatcurrency(dept2,2)&"', 'comision':'"&formatcurrency(comi2,2)&"', 'total':'"&formatcurrency(totalc,2)&"'}"
		 
		
end if




respuesta = "{'data':["&info&"]}"
respuesta = Replace(respuesta, "'", chr(34))
respuesta = replace(respuesta,"//","'")
response.Write(respuesta)
%>
