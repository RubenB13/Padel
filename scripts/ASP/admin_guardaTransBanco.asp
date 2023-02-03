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

camposs = "Desc_trans_banco, tipo_trans_banco, Clas_trans_banco, tipo_transaccion, Fecha_trans_banco, Resp_trans_banco, Cantidad, Estado, id_usuario, Fecha_captura"
datoss = " '"&txtConcepto&"', '"&txtTipo&"', '"&txtClasif&"', '"&cboTipoTransaccion&"', '"&txtFechaRealizada&"', '"&txtResponsable&"', '"&cantidad_trans&"', 1, '"&idUser&"', getdate() "


'tabla = "admin_Historial_Caja"

'nuevo registro Caja' 
if comm = "NuevaTransBanco" then
	    On Error Resume Next

	if idRegistro = 0 then
		guardarDatos "admin_historia_Banco", camposs, datoss, dominio
		info = "{'ok':'ok'}"
	elseif idRegistro > 0 then
		ActualizarDatos "admin_historia_Banco", " Desc_trans_banco='"&txtConcepto&"', tipo_trans_banco='"&txtTipo&"', Clas_trans_banco='"&txtClasif&"', tipo_transaccion='"&cboTipoTransaccion&"', Fecha_trans_banco='"&txtFechaRealizada&"', Resp_trans_banco='"&txtResponsable&"', Cantidad='"&cantidad_trans&"' ", " id='"&idRegistro&"' " ,dominio
		info = "{'ok':'ok'}"
	end if

	if Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
	
	On Error GoTo 0
end if

if com = "listarHistorialBancoMes" then
	
	sql = " SELECT ban.id, ban.Desc_trans_banco, ban.tipo_trans_banco, ban.Clas_trans_banco, ban.tipo_transaccion, "&_
		" convert(varchar,ban.fecha_trans_banco,103), ban.Resp_trans_banco, ban.cantidad "&_
		" FROM admin_historia_Banco ban "&_
		" where ban.Estado= 1 and MONTH( ban.fecha_trans_banco) = MONTH(GETDATE())"

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
			elseif datos(3,l) = 7 then
				clasificacion = "Comisión bancaria"
			end if 

			if datos(4,l)=1 then
				tipo_tra = "Clip"
			elseif datos(4,l)=2 then
				tipo_tra = "Transferencia"
			elseif datos(4,l)=3 then
				tipo_tra = "Deposito"
			elseif datos(4,l)=4 then
				tipo_tra = "Cosimión"
			end if

			eliminarTrans = "<button class=//md-btn md-raised mb-2 blue//><i class=//fa fa-trash// onclick=javascript:eliminarTransaccion("&datos(0,l)&")></i></button>&nbsp"
			actualizarTrans = "<button class=//md-btn md-raised mb-2 indigo//><i class=//fa fa-refresh//onclick=javascript:ModificarTransaccionCaja("&datos(0,l)&")></i></button>"
				
			info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'descripcion':'"&datos(1,l)&"', 'tipo':'"&tipoEntSal&"', 'clasificacion':'"&clasificacion&"', 'tipo_transaccion':'"&tipo_tra&"', 'fecha':'"&datos(5,l)&"', 'responsable':'"&datos(6,l)&"', 'monto':'"&formatcurrency(datos(7,l),2)&"', 'accion':'"&eliminarTrans&actualizarTrans&"'},"
		next
		info = left(info, len(info)-1)
	end if

end if

if com = "listarHistorialBanco" then
	
	sql = " SELECT ban.id, ban.Desc_trans_banco, ban.tipo_trans_banco, ban.Clas_trans_banco, ban.tipo_transaccion, "&_
		" convert(varchar,ban.fecha_trans_banco,103), ban.Resp_trans_banco, ban.cantidad "&_
		" FROM admin_historia_Banco ban "&_
		" where ban.Estado= 1 and cast( ban.fecha_trans_banco as date ) >= cast('"&periodoDesde&"' as date) and cast( ban.fecha_trans_banco as date ) <= cast('"&periodoA&"' as date)"

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
			elseif datos(3,l) = 7 then
				clasificacion = "Comisión bancaria"
			end if 

			if datos(4,l)=1 then
				tipo_tra = "Clip"
			elseif datos(4,l)=2 then
				tipo_tra = "Transferencia"
			elseif datos(4,l)=3 then
				tipo_tra = "Deposito"
			elseif datos(4,l)=4 then
				tipo_tra = "Cosimión"
			end if

			eliminarTrans = "<button class=//md-btn md-raised mb-2 blue//><i class=//fa fa-trash// onclick=javascript:eliminarTransaccion("&datos(0,l)&")></i></button>&nbsp"
			actualizarTrans = "<button class=//md-btn md-raised mb-2 indigo//><i class=//fa fa-refresh//onclick=javascript:ModificarTransaccionCaja("&datos(0,l)&")></i></button>"
				
			info = info & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'descripcion':'"&datos(1,l)&"', 'tipo':'"&tipoEntSal&"', 'clasificacion':'"&clasificacion&"', 'tipo_transaccion':'"&tipo_tra&"', 'fecha':'"&datos(5,l)&"', 'responsable':'"&datos(6,l)&"', 'monto':'"&formatcurrency(datos(7,l),2)&"', 'accion':'"&eliminarTrans&actualizarTrans&"'},"
		next
		info = left(info, len(info)-1)
	end if

end if


if comm = "verTransaccion" then
	
	sql = " SELECT ban.id, ban.Desc_trans_banco, ban.tipo_trans_banco, ban.Clas_trans_banco, ban.tipo_transaccion, "&_
		" ban.fecha_trans_banco, ban.Resp_trans_banco, ban.cantidad "&_
		" FROM admin_historia_Banco ban "&_
		" where ban.id = '"&idRegistro&"' "

	datos = executee(sql, dominio)

	if not IsEmpty(datos) then
		l=0
		' for l=0 to ubound(datos,2)
				
			info = "{'ok':'ok', 'id':'"&datos(0,l)&"', 'descripcion':'"&datos(1,l)&"', 'tipo':'"&datos(2,l)&"', 'clasificacion':'"&datos(3,l)&"', 'tipo_transaccion':'"&datos(4,l)&"', 'fecha':'"&datos(5,l)&"', 'responsable':'"&datos(6,l)&"', 'monto':'"&datos(7,l)&"'}"
		' next
		' info = left(info, len(info)-1)
	end if

end if


if comm = "eliminarTransaccion" then
	ActualizarDatos "admin_historia_Banco", " Estado=0 ", " id='"&idRegistro&"' ", dominio
	info = "{'ok':'ok'}"
end if

if comm = "modificartransbanco" then
	    On Error Resume Next

	ActualizarDatos "admin_historia_Banco", "Desc_trans_banco='"&txtConcepto&"', Fecha_trans_banco='"&txtFechaRealizada&"', Cantidad='"&cantidad_trans&"'", "id='"&idRegistro&"' ", dominio
	info = "{'ok':'ok'}"

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
