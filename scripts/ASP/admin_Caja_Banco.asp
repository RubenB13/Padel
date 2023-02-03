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


if com = "listarResumenCaja" then
	
	sql = " select "&_
		" (select ISNULL(sum(caja.Cantidad),0) from admin_historia_Caja caja where caja.Estado=1 and caja.Tipo_Trans_Caja=1 "&_
		" and (cast(caja.Fecha_trans_caja as date) >= cast('"&fi&"' as date) and cast(caja.Fecha_trans_caja as date) <= cast('"&ff&"' as date)  ))AS totalEntrada, "&_
		" (select ISNULL(sum(caja.cantidad),0) from admin_historia_Caja caja where caja.Estado=1 and caja.Tipo_Trans_Caja=2 "&_
		" and (cast(caja.Fecha_trans_caja as date) >= cast('"&fi&"' as date) and cast(caja.Fecha_trans_caja as date) <= cast('"&ff&"' as date)  ) ) AS totalSalida "

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


if com = "listarResumenCajaBanco" then
	On Error Resume Next
	sql = " select ISNULL(COUNT(caja.int),0), ISNULL(sum(caja.Cantidad),0), caja.Tipo_Trans_Caja "&_
		" from admin_historia_Caja caja "&_
		" where caja.Estado=1 and "&_
		" (cast(caja.Fecha_trans_caja as date) >= cast('"&fi&"' as date) and cast(caja.Fecha_trans_caja as date) <= cast('"&ff&"' as date) ) "&_
		" group by caja.Tipo_Trans_Caja "&_
		" union all "&_
		" select ISNULL(COUNT(ban.id),0), ISNULL(sum(ban.Cantidad),0), ban.tipo_trans_banco "&_
		" from admin_historia_Banco ban "&_
		" where ban.Estado=1 and "&_
		" (cast(ban.fecha_trans_banco as date) >= cast('"&fi&"' as date) and cast(ban.fecha_trans_banco as date) <= cast('"&ff&"' as date) ) "&_
		" group by ban.tipo_trans_banco "

	datos = executee(sql, dominio)

	if not IsEmpty(datos) then
		l=0
		for l=0 to ubound(datos,2)

			if datos(2,l) = 1 then
				movimientos_entrada = CDbl(movimientos_entrada) + CDbl(datos(0,l))	
				cantidad_entrada = CDbl(cantidad_entrada) + CDbl(datos(1,l))
			elseif datos(2,l) = 2 then
				movimientos_salida = CDbl(movimientos_salida) + CDbl(datos(0,l))
				cantidad_salida = CDbl(cantidad_salida) + CDbl(datos(1,l))
			end if	
			
		next

		balance = formatcurrency(CDbl(cantidad_entrada) - CDbl(cantidad_salida),2)
			
		info = "{'ok':'ok', 'movimientos_entrada':'"&movimientos_entrada&"', 'total_entrada':'"&formatcurrency(cantidad_entrada,2)&"', 'movimientos_salida':'"&movimientos_salida&"', 'total_salida':'"&formatcurrency(cantidad_salida,2)&"', 'balance':'"&balance&"'}"
		' info = left(info, len(info)-1)
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
