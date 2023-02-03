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


' obtener calendario
if comm = "getCalendario" then	    

	ss = " and CONVERT(VARCHAR,fecha_renta,111) >= DATEADD(MONTH, -2, getDate()) OR "&_
		" ( CONVERT(VARCHAR,fecha_reservaC2,111) >= DATEADD(MONTH, -2, getDate()) and estado = 1 ) OR "&_
		" ( CONVERT(VARCHAR,fecha_reservaC3,111) >= DATEADD(MONTH, -2, getDate()) and estado = 1 ) OR "&_
		" ( CONVERT(VARCHAR,fecha_reservaC4,111) >= DATEADD(MONTH, -2, getDate()) and estado = 1 ) OR "&_
		" ( CONVERT(VARCHAR,fecha_reservaC5,111) >= DATEADD(MONTH, -2, getDate()) and estado = 1 ) OR "&_
		" ( CONVERT(VARCHAR,fecha_reservaC6,111) >= DATEADD(MONTH, -2, getDate()) and estado = 1 ) OR "&_
		" ( CONVERT(VARCHAR,fecha_reservaC7,111) >= DATEADD(MONTH, -2, getDate()) and estado = 1 ) OR "&_
		" ( CONVERT(VARCHAR,fecha_reservaC8,111) >= DATEADD(MONTH, -2, getDate()) and estado = 1 ) " 
     
	sql = "select id, CONVERT(VARCHAR,fecha_renta,111), nombre_cliente, cancha_asignada, CONVERT(VARCHAR,hora_inicio,108), CONVERT(VARCHAR,hora_fin,108), tipo_servicio, CONVERT(VARCHAR,fecha_reservaC2,111), CONVERT(VARCHAR,hora_inicioC2,108), CONVERT(VARCHAR,hora_finC2,108), CONVERT(VARCHAR,fecha_reservaC3,111), CONVERT(VARCHAR,hora_inicioC3,108), CONVERT(VARCHAR,hora_finC3,108), CONVERT(VARCHAR,fecha_reservaC4,111), CONVERT(VARCHAR,hora_inicioC4,108), CONVERT(VARCHAR,hora_finC4,108), CONVERT(VARCHAR,fecha_reservaC5,111), CONVERT(VARCHAR,hora_inicioC5,108), CONVERT(VARCHAR,hora_finC5,108), CONVERT(VARCHAR,fecha_reservaC6,111), CONVERT(VARCHAR,hora_inicioC6,108), CONVERT(VARCHAR,hora_finC6,108), CONVERT(VARCHAR,fecha_reservaC7,111), CONVERT(VARCHAR,hora_inicioC7,108), CONVERT(VARCHAR,hora_finC7,108), CONVERT(VARCHAR,fecha_reservaC8,111), CONVERT(VARCHAR,hora_inicioC8,108), CONVERT(VARCHAR,hora_finC8,108), cancha_asignada2, cancha_asignada3, cancha_asignada4, cancha_asignada5, cancha_asignada6, cancha_asignada7, cancha_asignada8 from agenda where estado = 1 "&ss&" order by fecha_renta desc "
	datos = executee(sql,dominio)
	
	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)

			tipoServicio = datos(6,l)

			if tipoServicio = 1 then 'Renat normal
				claseColor = "#22b638"
			elseif tipoServicio = 2 then 'WPT
				claseColor = "#1d25a4"
			elseif tipoServicio = 3 then 'Academia
				claseColor = "#f0e802"
			elseif tipoServicio = 4 then 'Grupal
				claseColor = "#9c27b0"
			elseif tipoServicio = 5 then 'Particular
				claseColor = "#ff5900"
			elseif tipoServicio = 6 then 'hora muerta
				claseColor = "#f25ea3"
			elseif tipoServicio = 7 then 'hora concurrida
				claseColor = "#61cef2"
			elseif tipoServicio = 8 then 'hora concurrida
				claseColor = "#f0c802"
			end if
			

			horaInicio = datos(4,l)
			horaFinal = datos(5,l)
			dia = Replace(datos(1,l), "/","-")
			cancha_asignada = datos(3,l)

			if cancha_asignada = 1 then
				info1 = info1 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&datos(3,l)&"', 'start':'"&dia&" "&horaInicio&"', 'end':'"&dia&" "&horaFinal&"', 'backgroundColor':'"&claseColor&"'},"
			elseif cancha_asignada = 2 then
				info2 = info2 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&datos(3,l)&"', 'start':'"&dia&" "&horaInicio&"', 'end':'"&dia&" "&horaFinal&"', 'backgroundColor':'"&claseColor&"'},"
			elseif cancha_asignada = 3 then
				info3 = info3 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&datos(3,l)&"', 'start':'"&dia&" "&horaInicio&"', 'end':'"&dia&" "&horaFinal&"', 'backgroundColor':'"&claseColor&"'},"
			elseif cancha_asignada = 4 then
				info4 = info4 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&datos(3,l)&"', 'start':'"&dia&" "&horaInicio&"', 'end':'"&dia&" "&horaFinal&"', 'backgroundColor':'"&claseColor&"'},"
			end if

			
			if tipoServicio = 3 then

				cancha2 = datos(28,l)
				horaInicio2 = datos(8,l)
				horaFin2 = datos(9,l)
				fechaReserva2 = datos(7,l)
				dia = Replace(fechaReserva2,"/","-")
				
				
				if fechaReserva2 <> "1900/01/01" and cancha2 <> 0 and horaInicio2 <> "00:00:00" and horaFin2 <> "00:00:00" then
					if cancha2 = 1 then
						info1 = info1 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha2&"', 'start':'"&dia&" "&horaInicio2&"', 'end':'"&dia&" "&horaFin2&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha2 = 2 then
						info2 = info2 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha2&"', 'start':'"&dia&" "&horaInicio2&"', 'end':'"&dia&" "&horaFin2&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha2 = 3 then
						info3 = info3 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha2&"', 'start':'"&dia&" "&horaInicio2&"', 'end':'"&dia&" "&horaFin2&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha2 = 4 then
						info4 = info4 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha2&"', 'start':'"&dia&" "&horaInicio2&"', 'end':'"&dia&" "&horaFin2&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					end if					
				end if


				cancha3 = datos(29,l)
				horaInicio3 = datos(11,l)
				horaFin3 = datos(12,l)
				fechaReserva3 = datos(10,l)
				dia = Replace(fechaReserva3,"/","-")
				

				if fechaReserva3 <> "1900/01/01" and cancha3 <> 0 and horaInicio3 <> "00:00:00" and horaFin3 <> "00:00:00" then
					if cancha3 = 1 then
						info1 = info1 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha3&"', 'start':'"&dia&" "&horaInicio3&"', 'end':'"&dia&" "&horaFin3&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha3 = 2 then
						info2 = info2 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha3&"', 'start':'"&dia&" "&horaInicio3&"', 'end':'"&dia&" "&horaFin3&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha3 = 3 then
						info3 = info3 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha3&"', 'start':'"&dia&" "&horaInicio3&"', 'end':'"&dia&" "&horaFin3&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha3 = 4 then
						info4 = info4 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha3&"', 'start':'"&dia&" "&horaInicio3&"', 'end':'"&dia&" "&horaFin3&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					end if					
				end if

				cancha4 = datos(30,l)
				horaInicio4 = datos(14,l)
				horaFin4 = datos(15,l)
				fechaReserva4 = datos(13,l)
				dia = Replace(fechaReserva4,"/","-")
				

				if fechaReserva4 <> "1900/01/01" and cancha4 <> 0 and horaInicio4 <> "00:00:00" and horaFin4 <> "00:00:00" then
					if cancha4 = 1 then
						info1 = info1 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha4&"', 'start':'"&dia&" "&horaInicio4&"', 'end':'"&dia&" "&horaFin4&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha4 = 2 then
						info2 = info2 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha4&"', 'start':'"&dia&" "&horaInicio4&"', 'end':'"&dia&" "&horaFin4&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha4 = 3 then
						info3 = info3 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha4&"', 'start':'"&dia&" "&horaInicio4&"', 'end':'"&dia&" "&horaFin4&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha4 = 4 then
						info4 = info4 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha4&"', 'start':'"&dia&" "&horaInicio4&"', 'end':'"&dia&" "&horaFin4&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					end if					
				end if

				cancha5 = datos(31,l)
				horaInicio5 = datos(17,l)
				horaFin5 = datos(18,l)
				fechaReserva5 = datos(16,l)
				dia = Replace(fechaReserva5,"/","-")
				

				if fechaReserva5 <> "1900/01/01" and cancha5 <> 0 and horaInicio5 <> "00:00:00" and horaFin5 <> "00:00:00" then
					if cancha5 = 1 then
						info1 = info1 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha5&"', 'start':'"&dia&" "&horaInicio5&"', 'end':'"&dia&" "&horaFin5&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha5 = 2 then
						info2 = info2 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha5&"', 'start':'"&dia&" "&horaInicio5&"', 'end':'"&dia&" "&horaFin5&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha5 = 3 then
						info3 = info3 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha5&"', 'start':'"&dia&" "&horaInicio5&"', 'end':'"&dia&" "&horaFin5&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha5 = 4 then
						info4 = info4 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha5&"', 'start':'"&dia&" "&horaInicio5&"', 'end':'"&dia&" "&horaFin5&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					end if					
				end if

				cancha6 = datos(32,l)
				horaInicio6 = datos(20,l)
				horaFin6 = datos(21,l)
				fechaReserva6 = datos(19,l)
				dia = Replace(fechaReserva6,"/","-")
				

				if fechaReserva6 <> "1900/01/01" and cancha6 <> 0 and horaInicio6 <> "00:00:00" and horaFin6 <> "00:00:00" then
					if cancha6 = 1 then
						info1 = info1 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha6&"', 'start':'"&dia&" "&horaInicio6&"', 'end':'"&dia&" "&horaFin6&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha6 = 2 then
						info2 = info2 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha6&"', 'start':'"&dia&" "&horaInicio6&"', 'end':'"&dia&" "&horaFin6&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha6 = 3 then
						info3 = info3 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha6&"', 'start':'"&dia&" "&horaInicio6&"', 'end':'"&dia&" "&horaFin6&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha6 = 4 then
						info4 = info4 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha6&"', 'start':'"&dia&" "&horaInicio6&"', 'end':'"&dia&" "&horaFin6&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					end if					
				end if


				cancha7 = datos(33,l)
				horaInicio7 = datos(23,l)
				horaFin7 = datos(24,l)
				fechaReserva7 = datos(22,l)
				dia = Replace(fechaReserva7,"/","-")
				

				if fechaReserva7 <> "1900/01/01" and cancha7 <> 0 and horaInicio7 <> "00:00:00" and horaFin7 <> "00:00:00" then
					if cancha7 = 1 then
						info1 = info1 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha7&"', 'start':'"&dia&" "&horaInicio7&"', 'end':'"&dia&" "&horaFin7&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha7 = 2 then
						info2 = info2 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha7&"', 'start':'"&dia&" "&horaInicio7&"', 'end':'"&dia&" "&horaFin7&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha7 = 3 then
						info3 = info3 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha7&"', 'start':'"&dia&" "&horaInicio7&"', 'end':'"&dia&" "&horaFin7&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha7 = 4 then
						info4 = info4 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha7&"', 'start':'"&dia&" "&horaInicio7&"', 'end':'"&dia&" "&horaFin7&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					end if					
				end if

				cancha8 = datos(34,l)
				horaInicio8 = datos(26,l)
				horaFin8 = datos(27,l)
				fechaReserva8 = datos(25,l)
				dia = Replace(fechaReserva8,"/","-")
				

				if fechaReserva8 <> "1900/01/01" and cancha8 <> 0 and horaInicio8 <> "00:00:00" and horaFin8 <> "00:00:00" then
					if cancha8 = 1 then
						info1 = info1 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha8&"', 'start':'"&dia&" "&horaInicio8&"', 'end':'"&dia&" "&horaFin8&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha8 = 2 then
						info2 = info2 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha8&"', 'start':'"&dia&" "&horaInicio8&"', 'end':'"&dia&" "&horaFin8&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha8 = 3 then
						info3 = info3 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha8&"', 'start':'"&dia&" "&horaInicio8&"', 'end':'"&dia&" "&horaFin8&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					elseif cancha8 = 4 then
						info4 = info4 & "{'ok':'ok', 'id':'"&datos(0,l)&"', 'fecha_renta':'"&dia&"', 'title':'"&datos(2,l)&"', 'cancha':'"&cancha8&"', 'start':'"&dia&" "&horaInicio8&"', 'end':'"&dia&" "&horaFin8&"', 'tipo_servicio':3, 'backgroundColor':'"&claseColor&"'},"
					end if					
				end if


			end if
		next

		if info1 <> "" then
			info1 = left(info1, len(info1)-1)
		end if

		if info2 <> "" then
			info2 = left(info2, len(info2)-1)
		end if

		if info3 <> "" then
			info3 = left(info3, len(info3)-1)
		end if

		if info4 <> "" then
			info4 = left(info4, len(info4)-1)
		end if

		' set fs=Server.CreateObject("Scripting.FileSystemObject") 
  '       filePath = Server.MapPath("\scripts\plugins\dist\horario.json")
  '       set f=fs.CreateTextFile(filePath,true)
  '       info1 = "["&info&"]"
  '       info1 = Replace(info1, "'", chr(34)) 
  '       f.write(info1)
  '       f.close
  '       set f=nothing
  '       set fs=nothing 

	end if
   
end if



respuesta = "{'data':["&info1&"], 'data2':["&info2&"], 'data3':["&info3&"], 'data4':["&info4&"]}"
respuesta = Replace(respuesta, "'", chr(34))
respuesta = replace(respuesta,"//","'")
response.Write(respuesta)
%>