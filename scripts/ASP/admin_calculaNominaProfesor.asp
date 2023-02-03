<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="BD.asp"-->


<%
Response.Expires = 0
LServerName = Request.ServerVariables("SERVER_NAME")
valSpl = split(LServerName,".")
dominio = "db_a8638d_bdupadel" 'valSpl(0)


'idUser =  'Request.Cookies ("kkii124655")("id")
'nombreUser = 'Request.Cookies ("kkii124655")("nom")
'tipoUser =  'Request.Cookies ("kkii124655")("tipo")

 idProfesor = request.form("idProfesor")
 periodoDesde = request.form("txtfechaInicio")
 periodoA =  request.form("txtfechaFin")
 comm = request.form("comm")
	    
' if idProfesor ="" then
' 	idProfesor = Request.Cookies ("kkii124655")("id")
' 	' response.write(idProfesor)
' end if

'calcular nomina semanal de profesores
if comm = "calculaNomina" then	
	On Error Resume Next
	ss = " and ( cast(ag.fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(ag.fecha_renta as date) <= cast('"&periodoA&"' as date) ) "&_
			" or ( cast(ag.fecha_reservaC2 as date) >= cast('"&periodoDesde&"' as date) and cast(ag.fecha_reservaC2 as date) <= cast('"&periodoA&"' as date) and ag.tipo_servicio = 3 and ag.profesor_asignado='"&idProfesor&"' and ag.estado=1)"&_
			" or ( cast(ag.fecha_reservaC3 as date) >= cast('"&periodoDesde&"' as date) and cast(ag.fecha_reservaC3 as date) <= cast('"&periodoA&"' as date) and ag.tipo_servicio = 3 and ag.profesor_asignado='"&idProfesor&"' and ag.estado=1)"&_
			" or ( cast(ag.fecha_reservaC4 as date) >= cast('"&periodoDesde&"' as date) and cast(ag.fecha_reservaC4 as date) <= cast('"&periodoA&"' as date) and ag.tipo_servicio = 3 and ag.profesor_asignado='"&idProfesor&"' and ag.estado=1)"&_
			" or ( cast(ag.fecha_reservaC5 as date) >= cast('"&periodoDesde&"' as date) and cast(ag.fecha_reservaC5 as date) <= cast('"&periodoA&"' as date) and ag.tipo_servicio = 3 and ag.profesor_asignado='"&idProfesor&"' and ag.estado=1)"&_
			" or ( cast(ag.fecha_reservaC6 as date) >= cast('"&periodoDesde&"' as date) and cast(ag.fecha_reservaC6 as date) <= cast('"&periodoA&"' as date) and ag.tipo_servicio = 3 and ag.profesor_asignado='"&idProfesor&"' and ag.estado=1)"&_
			" or ( cast(ag.fecha_reservaC7 as date) >= cast('"&periodoDesde&"' as date) and cast(ag.fecha_reservaC7 as date) <= cast('"&periodoA&"' as date) and ag.tipo_servicio = 3 and ag.profesor_asignado='"&idProfesor&"' and ag.estado=1)"&_
			" or ( cast(ag.fecha_reservaC8 as date) >= cast('"&periodoDesde&"' as date) and cast(ag.fecha_reservaC8 as date) <= cast('"&periodoA&"' as date) and ag.tipo_servicio = 3 and ag.profesor_asignado='"&idProfesor&"' and ag.estado=1)"    
     
	sql = "select ag.id, CONVERT(VARCHAR,ag.fecha_renta,101), ag.nombre_cliente, ag.numero_personas, ag.cancha_asignada, CONVERT(VARCHAR,ag.hora_inicio,108), CONVERT(VARCHAR,ag.hora_fin,108), ag.tipo_servicio, ag.cancha_asignada2, CONVERT(VARCHAR,ag.fecha_reservaC2,101), CONVERT(VARCHAR,ag.hora_inicioC2,108), CONVERT(VARCHAR,ag.hora_finC2,108), ag.cancha_asignada3, CONVERT(VARCHAR,ag.fecha_reservaC3,101), CONVERT(VARCHAR,ag.hora_inicioC3,108), CONVERT(VARCHAR,ag.hora_finC3,108), ag.cancha_asignada4, CONVERT(VARCHAR,ag.fecha_reservaC4,101), CONVERT(VARCHAR,ag.hora_inicioC4,108), CONVERT(VARCHAR,ag.hora_finC4,108), ag.cancha_asignada5, CONVERT(VARCHAR,ag.fecha_reservaC5,101), CONVERT(VARCHAR,ag.hora_inicioC5,108), CONVERT(VARCHAR,ag.hora_finC5,108), ag.cancha_asignada6, CONVERT(VARCHAR,ag.fecha_reservaC6,101), CONVERT(VARCHAR,ag.hora_inicioC6,108), CONVERT(VARCHAR,ag.hora_finC6,108), ag.cancha_asignada7, CONVERT(VARCHAR,ag.fecha_reservaC7,101), CONVERT(VARCHAR,ag.hora_inicioC7,108), CONVERT(VARCHAR,ag.hora_finC7,108), ag.cancha_asignada8, CONVERT(VARCHAR,ag.fecha_reservaC8,101), CONVERT(VARCHAR,ag.hora_inicioC8,108), CONVERT(VARCHAR,ag.hora_finC8,108), (select isnull(pro.pago_a_profesor,0) from admin_pago_profesor pro where pro.id_tipo_servicio = ag.tipo_servicio and pro.numero_personas = ag.numero_personas), (select profe.nombre from admin_profesores profe where profe.id=ag.profesor_asignado) from agenda ag where ag.profesor_asignado='"&idProfesor&"' and ag.estado = 1 "&ss&" order by ag.fecha_renta"

	datos = executee(sql,dominio)
	nominaProfe = 0
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)

			tipo_servicio = datos(7,l)
			'response.write(tipo_servicio)

			if tipo_servicio =  1 then
				tipoServicio = "Renta normal"
				color  = "success"
			elseif tipo_servicio = 2 then
				tipoServicio = "Cancha WPT"
				color = "primary"
			elseif tipo_servicio = 3 then
				tipoServicio = "Academia"
				color = "warning"
			elseif tipo_servicio = 4 then
				tipoServicio = "Clase grupal"
				color = "purple"
			elseif tipo_servicio = 5 then
				tipoServicio = "Clase particular"
				color = "orange"
			elseif tipo_servicio = 8 then
				tipoServicio = "Academia-día"
				color = "deep-orange"
			end if

			tipo_servicioSPAN = "<span class=//badge "&color&"//>"&tipoServicio&"</span>"

			if tipo_servicio = 3 then
				numClaseSPAN = "<span class=//badge blue-grey// title=//1ra Clase//>1</span>"
			else
				numClaseSPAN =""
			end if

			pago_por_clase = "<span class=//badge green// title=//Pago por clase//>Pago: "&formatcurrency(datos(36,l),2)&"</span>"
			
			
			'response.write(nominaProfe)

			fr = datos(1,l)
			'response.write(periodoDesde & " - " & periodoA)
			if CDate(fr) >= CDate(periodoDesde) and CDate(fr) <= CDate(periodoA) then
				nominaProfe = CDbl(nominaProfe) + CDbl(datos(36,l))
			 	info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&datos(1,l)&"', 'nombre_cliente':'"&datos(2,l)&"', 'num_personas':'"&datos(3,l)&"', 'cancha_asignada':'"&datos(4,l)&"', 'hora_inicio':'"&datos(5,l)&"', 'hora_fin':'"&datos(6,l)&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&" | "&pago_por_clase&"','pago_profesor':'"&datos(36,l)&"', 'tipo_servicioNum':'"&tipo_servicio&"', 'profesor':'"&datos(37,l)&"', 'nomina_profesor':'"&formatcurrency(nominaProfe,2)&"'},"
			end if

			if tipo_servicio = 3 then

				cancha2 = datos(8,l)
				horaInicio2 = datos(10,l)
				horaFin2 = datos(11,l)
				fechaReserva2 = datos(9,l)
				
				'Clase no. 2
				if fechaReserva2 <> "1/1/1900" and cancha2 <> 0 and horaInicio2 <> "00:00:00" and horaFin2 <> "00:00:00" then
					numClaseSPAN = "<span class=//badge blue-grey// title=//2da Clase//>2</span>"
					if ss <> "" then
						if CDate(fechaReserva2) >= CDate(periodoDesde) and CDate(fechaReserva2) <= CDate(periodoA) then
							nominaProfe = CDbl(nominaProfe) + CDbl(datos(36,l))
							info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva2&"', 'nombre_cliente':'"&datos(2,l)&"', 'num_personas':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha2&"', 'hora_inicio':'"&horaInicio2&"', 'hora_fin':'"&horaFin2&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&" | "&pago_por_clase&"', 'pago_profesor':'"&datos(36,l)&"', 'tipo_servicioNum':'"&tipo_servicio&"', 'profesor':'"&datos(37,l)&"', 'nomina_profesor':'"&formatcurrency(nominaProfe,2)&"'},"
						end if
					else
						' info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva2&"', 'nombre_cliente':'"&datos(2,l)&"', 'num_personas':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha2&"', 'hora_inicio':'"&horaInicio2&"', 'hora_fin':'"&horaFin2&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"','pago_profesor':'"&datos(36,l)&"', 'tipo_servicioNum':'"&tipo_servicio&"', 'profesor':'"&datos(37,l)&"', 'nomina_profesor':'"&formatcurrency(nominaProfe,2)&"'},"
					end if
				end if

				cancha3 = datos(12,l)
				horaInicio3 = datos(14,l)
				horaFin3 = datos(15,l)
				fechaReserva3 = datos(13,l)

				'Clase no. 3
				if fechaReserva3 <> "1/1/1900" and cancha3 <> 0 and horaInicio3 <> "00:00:00" and horaFin3 <> "00:00:00" then
					numClaseSPAN = "<span class=//badge blue-grey// title=//3ra Clase//>3</span>"
					if ss <> "" then
						if CDate(fechaReserva3) >= CDate(periodoDesde) and CDate(fechaReserva3) <= CDate(periodoA) then
							nominaProfe = CDbl(nominaProfe) + CDbl(datos(36,l))
							info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva3&"', 'nombre_cliente':'"&datos(2,l)&"', 'num_personas':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha3&"', 'hora_inicio':'"&horaInicio3&"', 'hora_fin':'"&horaFin3&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&" | "&pago_por_clase&"', 'pago_profesor':'"&datos(36,l)&"', 'tipo_servicioNum':'"&tipo_servicio&"', 'profesor':'"&datos(37,l)&"', 'nomina_profesor':'"&formatcurrency(nominaProfe,2)&"'},"
						end if
					else
						' info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva3&"', 'nombre_cliente':'"&datos(2,l)&"', 'num_personas':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha3&"', 'hora_inicio':'"&horaInicio3&"', 'hora_fin':'"&horaFin3&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'pago_profesor':'"&datos(36,l)&"', 'tipo_servicioNum':'"&tipo_servicio&"', 'profesor':'"&datos(37,l)&"', 'nomina_profesor':'"&formatcurrency(nominaProfe,2)&"'},"
					end if
				end if

				cancha4 = datos(16,l)
				horaInicio4 = datos(18,l)
				horaFin4 = datos(19,l)
				fechaReserva4 = datos(17,l)

				'Clase no. 4
				if fechaReserva4 <> "1/1/1900" and cancha4 <> 0 and horaInicio4 <> "00:00:00" and horaFin4 <> "00:00:00" then
					numClaseSPAN = "<span class=//badge blue-grey// title=//4ta Clase//>4</span>"
					if ss <> "" then
						if CDate(fechaReserva4) >= CDate(periodoDesde) and CDate(fechaReserva4) <= CDate(periodoA) then
							nominaProfe = CDbl(nominaProfe) + CDbl(datos(36,l))
							info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva4&"', 'nombre_cliente':'"&datos(2,l)&"', 'num_personas':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha4&"', 'hora_inicio':'"&horaInicio4&"', 'hora_fin':'"&horaFin4&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&" | "&pago_por_clase&"', 'pago_profesor':'"&datos(36,l)&"', 'tipo_servicioNum':'"&tipo_servicio&"', 'profesor':'"&datos(37,l)&"','nomina_profesor':'"&formatcurrency(nominaProfe,2)&"'},"
						end if
					else
						' info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva4&"', 'nombre_cliente':'"&datos(2,l)&"', 'num_personas':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha4&"', 'hora_inicio':'"&horaInicio4&"', 'hora_fin':'"&horaFin4&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'pago_profesor':'"&datos(36,l)&"', 'tipo_servicioNum':'"&tipo_servicio&"', 'profesor':'"&datos(37,l)&"','nomina_profesor':'"&formatcurrency(nominaProfe,2)&"'},"
					end if
				end if

				cancha5 = datos(20,l)
				horaInicio5 = datos(22,l)
				horaFin5 = datos(23,l)
				fechaReserva5 = datos(21,l)

				'Clase no. 5
				if fechaReserva5 <> "1/1/1900" and cancha5 <> 0 and horaInicio5 <> "00:00:00" and horaFin5 <> "00:00:00" then
					numClaseSPAN = "<span class=//badge blue-grey// title=//5ta Clase//>5</span>"
					if ss <> "" then
						if CDate(fechaReserva5) >= CDate(periodoDesde) and CDate(fechaReserva5) <= CDate(periodoA) then
							nominaProfe = CDbl(nominaProfe) + CDbl(datos(36,l))
							info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva5&"', 'nombre_cliente':'"&datos(2,l)&"', 'num_personas':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha5&"', 'hora_inicio':'"&horaInicio5&"', 'hora_fin':'"&horaFin5&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&" | "&pago_por_clase&"', 'pago_profesor':'"&datos(36,l)&"', 'tipo_servicioNum':'"&tipo_servicio&"', 'profesor':'"&datos(37,l)&"','nomina_profesor':'"&formatcurrency(nominaProfe,2)&"'},"
						end if
					else
						' info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva5&"', 'nombre_cliente':'"&datos(2,l)&"', 'num_personas':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha5&"', 'hora_inicio':'"&horaInicio5&"', 'hora_fin':'"&horaFin5&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'pago_profesor':'"&datos(36,l)&"', 'tipo_servicioNum':'"&tipo_servicio&"', 'profesor':'"&datos(37,l)&"','nomina_profesor':'"&formatcurrency(nominaProfe,2)&"'},"
					end if
				end if

				cancha6 = datos(24,l)
				horaInicio6 = datos(26,l)
				horaFin6 = datos(27,l)
				fechaReserva6 = datos(25,l)

				'Clase no. 6
				if fechaReserva6 <> "1/1/1900" and cancha6 <> 0 and horaInicio6 <> "00:00:00" and horaFin6 <> "00:00:00" then
					numClaseSPAN = "<span class=//badge blue-grey// title=//6ta Clase//>6</span>"
					if ss <> "" then
						if CDate(fechaReserva6) >= CDate(periodoDesde) and CDate(fechaReserva6) <= CDate(periodoA) then
							nominaProfe = CDbl(nominaProfe) + CDbl(datos(36,l))
							info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva6&"', 'nombre_cliente':'"&datos(2,l)&"', 'num_personas':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha6&"', 'hora_inicio':'"&horaInicio6&"', 'hora_fin':'"&horaFin6&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&" | "&pago_por_clase&"', 'pago_profesor':'"&datos(36,l)&"', 'tipo_servicioNum':'"&tipo_servicio&"', 'profesor':'"&datos(37,l)&"','nomina_profesor':'"&formatcurrency(nominaProfe,2)&"'},"
						end if
					else
						' info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva6&"', 'nombre_cliente':'"&datos(2,l)&"', 'num_personas':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha6&"', 'hora_inicio':'"&horaInicio6&"', 'hora_fin':'"&horaFin6&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'pago_profesor':'"&datos(36,l)&"', 'tipo_servicioNum':'"&tipo_servicio&"', 'profesor':'"&datos(37,l)&"','nomina_profesor':'"&formatcurrency(nominaProfe,2)&"'},"
					end if
				end if

				cancha7 = datos(28,l)
				horaInicio7 = datos(30,l)
				horaFin7 = datos(31,l)
				fechaReserva7 = datos(29,l)

				'Clase no. 7
				if fechaReserva7 <> "1/1/1900" and cancha7 <> 0 and horaInicio7 <> "00:00:00" and horaFin7 <> "00:00:00" then
					numClaseSPAN = "<span class=//badge blue-grey// title=//7ma Clase//>7</span>"
					if ss <> "" then
						if CDate(fechaReserva7) >= CDate(periodoDesde) and CDate(fechaReserva7) <= CDate(periodoA) then
							nominaProfe = CDbl(nominaProfe) + CDbl(datos(36,l))
							info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva7&"', 'nombre_cliente':'"&datos(2,l)&"', 'num_personas':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha7&"', 'hora_inicio':'"&horaInicio7&"', 'hora_fin':'"&horaFin7&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&" | "&pago_por_clase&"', 'pago_profesor':'"&datos(36,l)&"', 'tipo_servicioNum':'"&tipo_servicio&"', 'profesor':'"&datos(37,l)&"','nomina_profesor':'"&formatcurrency(nominaProfe,2)&"'},"
						end if
					else
						' info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva7&"', 'nombre_cliente':'"&datos(2,l)&"', 'num_personas':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha7&"', 'hora_inicio':'"&horaInicio7&"', 'hora_fin':'"&horaFin7&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'pago_profesor':'"&datos(36,l)&"', 'tipo_servicioNum':'"&tipo_servicio&"', 'profesor':'"&datos(37,l)&"','nomina_profesor':'"&formatcurrency(nominaProfe,2)&"'},"
					end if
				end if


				cancha8 = datos(32,l)
				horaInicio8 = datos(34,l)
				horaFin8 = datos(35,l)
				fechaReserva8 = datos(33,l)

				'Clase no. 8
				if fechaReserva8 <> "1/1/1900" and cancha8 <> 0 and horaInicio8 <> "00:00:00" and horaFin8 <> "00:00:00" then
					numClaseSPAN = "<span class=//badge blue-grey// title=//8va Clase//>8</span>"
					if ss <> "" then
						if CDate(fechaReserva8) >= CDate(periodoDesde) and CDate(fechaReserva8) <= CDate(periodoA) then
							nominaProfe = CDbl(nominaProfe) + CDbl(datos(36,l))
							info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva8&"', 'nombre_cliente':'"&datos(2,l)&"', 'num_personas':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha8&"', 'hora_inicio':'"&horaInicio8&"', 'hora_fin':'"&horaFin8&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&" | "&pago_por_clase&"', 'pago_profesor':'"&datos(36,l)&"', 'tipo_servicioNum':'"&tipo_servicio&"', 'profesor':'"&datos(37,l)&"','nomina_profesor':'"&formatcurrency(nominaProfe,2)&"'},"
						end if
					else
						' info = info & "{'id':'"&datos(0,l)&"', 'fecha_renta':'"&fechaReserva8&"', 'nombre_cliente':'"&datos(2,l)&"', 'num_personas':'"&datos(3,l)&"', 'cancha_asignada':'"&cancha8&"', 'hora_inicio':'"&horaInicio8&"', 'hora_fin':'"&horaFin8&"', 'tipo_servicio':'"&numClaseSPAN&tipo_servicioSPAN&"', 'pago_profesor':'"&datos(36,l)&"', 'tipo_servicioNum':'"&tipo_servicio&"', 'profesor':'"&datos(37,l)&"','nomina_profesor':'"&formatcurrency(nominaProfe,2)&"'},"
					end if
				end if

			end if

		next

		info = left(info, len(info)-1)
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