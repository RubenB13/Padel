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

fi = request.form("fi")
ff = request.form("ff")

periodoDesde = request.QueryString("de")
periodoA = request.QueryString("a")

comm = request.form("comm")
idRegistro = request.form("idReg")
com = request.queryString("com")

totalre = 0
captot = 0
egrAd = 0
ingVen = 0 

if com = "listarAdministrativo" then
	    On Error Resume Next
		sql = "select "&_
		"(select count(id) from agenda where tipo_servicio=1 and estado=1 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <=cast('"&periodoA&"' as date) ) as rentaNormal,"&_
		"(select count(id) from agenda where tipo_servicio=2 and estado=1 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <=cast('"&periodoA&"' as date) ) as wpt, "&_
		"(select count(id) from agenda where tipo_servicio=4 and estado=1 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <=cast('"&periodoA&"' as date) ) as grupal, "&_
		"(select count(id) from agenda where tipo_servicio=5 and estado=1 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <=cast('"&periodoA&"' as date) ) as particular,"&_ 
		"(select COUNT(id) from agenda where tipo_servicio=3 and estado=1 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <=cast('"&periodoA&"' as date) )as d1,"&_
		"(select count(id) from agenda where estado=1 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <= cast('"&periodoA&"' as date) or "&_
		"(cast(fecha_reservaC2 as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_reservaC2 as date) <=cast('"&periodoA&"' as date)) or "&_
		"(cast(fecha_reservaC3 as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_reservaC3 as date) <=cast('"&periodoA&"' as date)) or "&_
		"(cast(fecha_reservaC4 as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_reservaC4 as date) <= cast('"&periodoA&"' as date)) or "&_
		"(cast(fecha_reservaC5 as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_reservaC5 as date) <= cast('"&periodoA&"' as date)) or "&_
		"(cast(fecha_reservaC6 as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_reservaC6 as date) <= cast('"&periodoA&"' as date)) or "&_
		"(cast(fecha_reservaC7 as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_reservaC7 as date) <= cast('"&periodoA&"' as date)) or "&_
		"(cast(fecha_reservaC8 as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_reservaC8 as date) <= cast('"&periodoA&"' as date))) as totalReservaciones, "&_
		"(select count(*) from agenda where estado =1 and descuento>0 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <= cast('"&periodoA&"' as date)) as reservacionesConDescuento,"&_
		"(select ISNULL(sum(precio_renta),0) from agenda where estado=1 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <=cast('"&periodoA&"' as date)) as ingresos, "&_
		"(select COUNT(id) from agenda where tipo_servicio=3 and estado=1 and cast(fecha_reservaC2 as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_reservaC2 as date) <=cast('"&periodoA&"' as date)) as d2, "&_
		"(select COUNT(id) from agenda where tipo_servicio=3 and estado=1 and cast(fecha_reservaC3 as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_reservaC3 as date) <=cast('"&periodoA&"' as date)) as d3, "&_
		"(select COUNT(id) from agenda where tipo_servicio=3 and estado=1 and cast(fecha_reservaC4 as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_reservaC4 as date) <=cast('"&periodoA&"' as date)) as d4, "&_
		"(select COUNT(id) from agenda where tipo_servicio=3 and estado=1 and cast(fecha_reservaC5 as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_reservaC5 as date) <=cast('"&periodoA&"' as date)) as d5, "&_
		"(select COUNT(id) from agenda where tipo_servicio=3 and estado=1 and cast(fecha_reservaC6 as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_reservaC6 as date) <=cast('"&periodoA&"' as date)) as d6, "&_
		"(select COUNT(id) from agenda where tipo_servicio=3 and estado=1 and cast(fecha_reservaC7 as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_reservaC7 as date) <=cast('"&periodoA&"' as date)) as d7, "&_
		"(select COUNT(id) from agenda where tipo_servicio=3 and estado=1 and cast(fecha_reservaC8 as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_reservaC8 as date) <=cast('"&periodoA&"' as date)) as d8, "&_ 
        "(select ISNULL(sum(precio_renta),0) from agenda where tipo_servicio=1 and estado = 1 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <= cast('"&periodoA&"' as date)) as Totalrentanormal,"&_
		"(select ISNULL(sum(precio_renta),0) from agenda where tipo_servicio=2 and estado = 1 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <= cast('"&periodoA&"' as date)) as TotalWPT,"&_
		"(select ISNULL(sum(precio_renta),0) from agenda where tipo_servicio=4 and estado = 1 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <= cast('"&periodoA&"' as date)) as Totalgrupal,"&_
		"(select ISNULL(sum(precio_renta),0) from agenda where tipo_servicio=5 and estado = 1 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <= cast('"&periodoA&"' as date)) as Totalparticular,"&_
		"(select isnull(sum(descuento),0) from agenda where estado =1 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <= cast('"&periodoA&"' as date)) as sumdesc,"&_
        "(select COUNT(id) from agenda where tipo_servicio=8 and estado=1 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <=cast('"&periodoA&"' as date) )as acad1,"&_
		"(select ISNULL(sum(precio_renta),0) from agenda where tipo_servicio=8 and estado = 1 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <= cast('"&periodoA&"' as date)) as TotalAcad1, "&_
		"(select ISNULL(SUM(playtomic),0) FROM agenda WHERE estado =1 and playtomic>0 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <= cast('"&periodoA&"' as date) ) as totalPalyTomic, "&_
		"(select count(*) from agenda where estado =1 and playtomic>0 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <= cast('"&periodoA&"' as date)) as reservacionesPlaytomic "

     	  sql3="select"&_
	      "(select costo_hora from  admin_tipoServicio where id=3) as costoacademia"


     	for i=1 to 4
	 		sql2=" select "&_
		     "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_renta as date)>=CAST('"&periodoDesde&"'as date) and cast(fecha_renta as date)<=CAST('"&periodoA&"' as date))) as rca1, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC2 as date)>=CAST('"&periodoDesde&"'as date) and cast(fecha_reservaC2 as date)<=CAST('"&periodoA&"' as date))) as rca2, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC3 as date)>=CAST('"&periodoDesde&"'as date) and cast(fecha_reservaC3 as date)<=CAST('"&periodoA&"' as date))) as rca3, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC4 as date)>=CAST('"&periodoDesde&"'as date) and cast(fecha_reservaC4 as date)<=CAST('"&periodoA&"' as date))) as rca4, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC5 as date)>=CAST('"&periodoDesde&"'as date) and cast(fecha_reservaC5 as date)<=CAST('"&periodoA&"' as date))) as rca5, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC6 as date)>=CAST('"&periodoDesde&"'as date) and cast(fecha_reservaC6 as date)<=CAST('"&periodoA&"' as date))) as rca6, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC7 as date)>=CAST('"&periodoDesde&"'as date) and cast(fecha_reservaC7 as date)<=CAST('"&periodoA&"' as date))) as rca7, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC8 as date)>=CAST('"&periodoDesde&"'as date) and cast(fecha_reservaC8 as date)<=CAST('"&periodoA&"' as date))) as rca8 "
	 

			
			datos2= executee(sql2,dominio)

    		 if not IsEmpty(datos2) then 
					if i =1 then
					p1=datos2(0,l)+datos2(1,l)+datos2(2,l)+datos2(3,l)+datos2(4,l)+datos2(5,l)+datos2(6,l)+datos2(7,l)
            		elseif i=2 then
					p2=datos2(0,l)+datos2(1,l)+datos2(2,l)+datos2(3,l)+datos2(4,l)+datos2(5,l)+datos2(6,l)+datos2(7,l)
					elseif i=3 then
					p3=datos2(0,l)+datos2(1,l)+datos2(2,l)+datos2(3,l)+datos2(4,l)+datos2(5,l)+datos2(6,l)+datos2(7,l)			
					elseif i=4 then
					p4=datos2(0,l)+datos2(1,l)+datos2(2,l)+datos2(3,l)+datos2(4,l)+datos2(5,l)+datos2(6,l)+datos2(7,l)
					end if
			else
			p1=0
			p2=0
			p3=0
			p4=0
			end if
   		Next
	
	
		datos3=executee(sql3,dominio)

			if not IsEmpty(datos3) then
	  			costoaca=datos3(0,l)
	 			costoindivacad=CInt(costoaca)/8
	  			cp1 = Cint(p1)*costoindivacad
      			cp2 = Cint(p2)*(costoindivacad*2)
	  			cp3 = Cint(p3)*(costoindivacad*3)
	  			cp4 = Cint(p4)*(costoindivacad*4)
	  			igresorealacademia=cp1+cp2+cp3+cp4
			else 
			costoaca=datos3(0,l)
	 		costoindivacad=CInt(costoaca)/8
			igresorealacademia=0
			end if

	
		datos = executee(sql,dominio)

		if not IsEmpty(datos) then
	 
				r0=datos(0,l)
				r1=datos(1,l)
				r2=datos(2,l)
				r3=datos(3,l)
				d1=datos(4,l)
				d2=datos(8,l)
				d3=datos(9,l)
				d4=datos(10,l)
				d5=datos(11,l)
				d6=datos(12,l)
				d7=datos(13,l)
				d8=datos(14,l)
				totalacademia=CInt(d1)+CInt(d2)+CInt(d3)+CInt(d4)+CInt(d5)+CInt(d6)+CInt(d7)+CInt(d8)
				totalre=CInt(r0)+CInt(r1)+CInt(r2)+CInt(r3)+CInt(totalacademia)
				totalrno=datos(15,l)
				totalwptt=datos(16,l)
				totalgrup=datos(17,l)
				totalpart=datos(18,l)
				ttdescuentos=datos(19,l)
				tclasAc = datos(20,l)
				ingclasAc = datos(21,l)
				Egresoreal=CDbl(totalrno)+CDbl(totalwptt)+CDbl(totalgrup)+CDbl(totalpart)+CDbl(igresorealacademia)+CDbl(ingclasAc)

			
				' response.write("total rno: "&totalrno &"-")
				' response.write("total wpt: "&totalwptt &"-")
				' response.write("total gru: "&totalgrup &"-")
				' response.write("total part: "&totalpart &"-")
				' response.write("total egrerea: "&Egresoreal &"-")
				' ' response.write("total academia: "&totalacademia &"-")

		' info = "{'ok':'ok',  'renta_normal':'"&datos(0,l)&"', 'wpt':'"&datos(1,l)&"', 'grupal':'"&datos(2,l)&"', 'particular':'"&datos(3,l)&"', 'academia':'"&totalacademia&"', 'total_reservaciones':'"&totalre&"', 'reservaciones_descuento':'"&datos(6,l)&"', 'ingreso_total':'"&formatcurrency(Egresoreal,2)&"'},"
	   info = "{'ok':'ok',  'renta_normal':'"&datos(0,l)&"', 'wpt':'"&datos(1,l)&"', 'grupal':'"&datos(2,l)&"', 'particular':'"&datos(3,l)&"', 'academia':'"&totalacademia&"', 'total_reservaciones':'"&totalre&"', 'reservaciones_descuento':'"&datos(6,l)&"', 'ingreso_total':'"&formatcurrency(Egresoreal,2)&"', 'acaddia':'"&tclasAc&"', 'playtomic':'"&datos(23,l)&"'},"
		
	else
		info = "{'ok':'ok',  'renta_normal':'0', 'wpt':'0', 'grupal':'0', 'particular':'0', 'academia':'0', 'total_reservaciones':'0', 'reservaciones_descuento':'0', 'ingreso_total':'0', 'acaddia':'0', 'playtomic':'0'}"
		
	end if
	    info = info +"{'ok':'ok',  'renta_normal':'"&formatcurrency(totalrno,2)&"', 'wpt':'"&formatcurrency(totalwptt,2)&"', 'grupal':'"&formatcurrency(totalgrup,2)&"', 'particular':'"&formatcurrency(totalpart,2)&"', 'academia':'"&formatcurrency(igresorealacademia,2)&"', 'total_reservaciones':'"&totalre&"', 'reservaciones_descuento':'"&formatcurrency(ttdescuentos,2)&"', 'ingreso_total':'"&formatcurrency(Egresoreal,2)&"', 'acaddia':'"&formatcurrency(ingclasAc,2)&"', 'playtomic':'"&formatcurrency(datos(22,l),2)&"'}"
		
		if Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
		end if
	
		On Error GoTo 0
end if	





if com = "datosnuevos" then
	On Error Resume Next
	'consulta de clases grupales y particulares por persona
	sqlnuevaconsulta= "Select "&_ 
		"(select count(id) from agenda where tipo_servicio=5 and estado=1 and numero_personas=1 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <=cast('"&periodoA&"' as date)) as p1,"&_
		"(select count(id) from agenda where tipo_servicio=5 and estado=1 and numero_personas=2 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <=cast('"&periodoA&"' as date)) as p2,"&_
		"(select count(id) from agenda where tipo_servicio=5 and estado=1 and numero_personas=3 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <=cast('"&periodoA&"' as date)) as p3,"&_
		"(select count(id) from agenda where tipo_servicio=5 and estado=1 and numero_personas=4 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <=cast('"&periodoA&"' as date)) as p4,"&_
		"(select count(id) from agenda where tipo_servicio=4 and estado=1 and numero_personas=1 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <=cast('"&periodoA&"' as date)) as g1,"&_
		"(select count(id) from agenda where tipo_servicio=4 and estado=1 and numero_personas=2 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <=cast('"&periodoA&"' as date)) as g2,"&_
		"(select count(id) from agenda where tipo_servicio=4 and estado=1 and numero_personas=3 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <=cast('"&periodoA&"' as date)) as g3,"&_
		"(select count(id) from agenda where tipo_servicio=4 and estado=1 and numero_personas=4 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <=cast('"&periodoA&"' as date)) as g4"
        
    sqlcostos ="select"&_
					"(select costo_hora from admin_tipoServicio where id=5) as pp1, "&_
					"(select dos_personas from admin_tipoServicio where id=5) as pp2,"&_
					"(select tres_personas from admin_tipoServicio where id=5) as pp3,"&_
					"(select cuatro_personas from admin_tipoServicio where id=5) as pp4,"&_
					"(select costo_hora from admin_tipoServicio where id=4) as cg1,"&_
					"(select dos_personas from admin_tipoServicio where id=4) as cg2,"&_
					"(select tres_personas from admin_tipoServicio where id=4) as cg3,"&_
					"(select cuatro_personas from admin_tipoServicio where id=4) as cg4,"&_
					"(select costo_hora from admin_tipoServicio where id=3) as ca,"&_
					"(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=5 and numero_personas=1) as pf1p,"&_
					"(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=5 and numero_personas=2) as pf2p,"&_
					"(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=5 and numero_personas=3) as pf3p,"&_
					"(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=5 and numero_personas=4) as pf4p,"&_
					"(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=4 and numero_personas=2) as pf2g,"&_
					"(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=4 and numero_personas=3) as pf3g,"&_
					"(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=4 and numero_personas=4) as pf4g,"&_
					"(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=3 and numero_personas=1) as pf1ac,"&_
					"(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=3 and numero_personas=2) as pf2ac,"&_
					"(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=3 and numero_personas=3) as pf3ac,"&_
					"(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=3 and numero_personas=4) as pf4ac"
	
	conscostos= executee(sqlcostos,dominio)
	if not IsEmpty(conscostos) then 
		pp1 = conscostos(0,l)
		pp2 = conscostos(1,l)
		pp3 = conscostos(2,l)
		pp4 = conscostos(3,l)
		cg1 = conscostos(4,l)
		cg2 = conscostos(5,l)
		cg3 = conscostos(6,l)
		cg4 = conscostos(7,l)
		ca  = conscostos(8,l)
		pf1p = conscostos(9,l)
		pf2p = conscostos(10,l)
		pf3p = conscostos(11,l)
		pf4p = conscostos(12,l)
		pf2g = conscostos(13,l)
		pf3g = conscostos(14,l)
		pf4g = conscostos(15,l)
		pf1ac = conscostos(16,l)
		pf1ac = conscostos(17,l)
		pf1ac = conscostos(18,l)
		pf1ac = conscostos(19,l)
 
		else 
		pp1 = 0
		pp2 = 0
		pp3 = 0
		pp4 = 0
		cg1 = 0
		cg2 = 0
		cg3 = 0
		cg4 = 0
		ca  = 0
		pf1p = 0
		pf2p = 0
		pf3p = 0
		pf4p = 0
		pf2g = 0
		pf3g = 0
		pf4g = 0
		pf1ac = 0
		pf1ac = 0
		pf1ac = 0
		pf1ac = 0
	end if 

		nuevaconsulta = executee(sqlnuevaconsulta,dominio)
		if not IsEmpty(nuevaconsulta) then 
			pr1=nuevaconsulta(0,l)
			pr2=nuevaconsulta(1,l)
			pr3=nuevaconsulta(2,l)
			pr4=nuevaconsulta(3,l)
			gr1=nuevaconsulta(4,l) 	
			gr2=nuevaconsulta(5,l)
			gr3=nuevaconsulta(6,l)
			gr4=nuevaconsulta(7,l)
			else
				pr1=0
				pr2=0
				pr3=0
				pr4=0
				gr1=0
				gr2=0
				gr3=0
				gr4=0
		end if
		'calculo del costo por tipo de clases
		ip1=pr1*pp1
		ip2=pr2*pp2
		ip3=pr3*pp3
		ip4=pr4*pp4
		ig1=gr1*cg1
		ig2=gr2*cg2
		ig3=gr3*cg3
		ig4=gr4*cg4
		' calculo del pago a profesor
		pfp1= pr1*pf1p
		pfp2= pr2*pf2p
		pfp3= pr3*pf3p
		pfp4= pr4*pf4p
		pfg1= 0
		pfg2= gr2*pf2g
		pfg3= gr3*pf3g
		pfg4= gr4*pf4g

	 info = "{'ok':'ok',  'Concepto':'Total de Clases',  'Part 1':'"&pr1&"', 'Part 2':'"&pr2&"', 'Part 3':'"&pr3&"', 'Part 4':'"&pr4&"', 'Grup 1':'"&gr1&"', 'Grup 2':'"&gr2&"', 'Grup 3':'"&gr3&"', 'Grup 4':'"&gr4&"'}, {'ok':'ok',  'Concepto':'Ingreso Estimado',  'Part 1':'"&formatcurrency(ip1,2)&"', 'Part 2':'"&formatcurrency(ip2,2)&"', 'Part 3':'"&formatcurrency(ip3,2)&"', 'Part 4':'"&formatcurrency(ip4,2)&"', 'Grup 1':'"&formatcurrency(ig1,2)&"', 'Grup 2':'"&formatcurrency(ig2,2)&"', 'Grup 3':'"&formatcurrency(ig3,2)&"', 'Grup 4':'"&formatcurrency(ig4,2)&"'}, {'ok':'ok',    'Concepto':'Pago a profesor',  'Part 1':'"&formatcurrency(pfp1,2)&"', 'Part 2':'"&formatcurrency(pfp2,2)&"', 'Part 3':'"&formatcurrency(pfp3,2)&"', 'Part 4':'"&formatcurrency(pfp4,2)&"', 'Grup 1':'"&formatcurrency(pfg1,2)&"', 'Grup 2':'"&formatcurrency(pfg2,2)&"', 'Grup 3':'"&formatcurrency(pfg3,2)&"', 'Grup 4':'"&formatcurrency(pfg4,2)&"'}"
    ' info = "{'ok':'ok',  'Particulares 1':'0', 'Particulares 2':'0', 'Particulares 3':'0', 'Particulares 4':'0', 'Grupales 1':'0', 'Grupales 2':'0', 'Grupales 3':'0', 'Grupales 4':'0'}"

	'constula de error
	if Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
	
	On Error GoTo 0    


end if 

if com = "consultaAcad2" then
	On Error Resume Next
	'consulta de clases grupales y particulares por persona
	sqlnuevaconsulta= "Select "&_ 
		"(select count(id) from agenda where tipo_servicio=8 and estado=1 and numero_personas=1 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <=cast('"&periodoA&"' as date)) as p1,"&_
		"(select count(id) from agenda where tipo_servicio=8 and estado=1 and numero_personas=2 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <=cast('"&periodoA&"' as date)) as p2,"&_
		"(select count(id) from agenda where tipo_servicio=8 and estado=1 and numero_personas=3 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <=cast('"&periodoA&"' as date)) as p3,"&_
		"(select count(id) from agenda where tipo_servicio=8 and estado=1 and numero_personas=4 and cast(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and cast(fecha_renta as date) <=cast('"&periodoA&"' as date)) as p4"
  
    sqlcostos ="select"&_
					"(select costo_hora from admin_tipoServicio where id=8) as pp1, "&_
					"(select dos_personas from admin_tipoServicio where id=8) as pp2,"&_
					"(select tres_personas from admin_tipoServicio where id=8) as pp3,"&_
					"(select cuatro_personas from admin_tipoServicio where id=8) as pp4,"&_
					"(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=8 and numero_personas=1) as pf1p,"&_
					"(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=8 and numero_personas=2) as pf2p,"&_
					"(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=8 and numero_personas=3) as pf3p,"&_
					"(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=8 and numero_personas=4) as pf4p"
	
	conscostos= executee(sqlcostos,dominio)
	if not IsEmpty(conscostos) then 
		pp1 = conscostos(0,l)
		pp2 = conscostos(1,l)
		pp3 = conscostos(2,l)
		pp4 = conscostos(3,l)
		pf1p = conscostos(4,l)
		pf2p = conscostos(5,l)
		pf3p = conscostos(6,l)
		pf4p = conscostos(7,l)

 
		else 
		pp1 = 0
		pp2 = 0
		pp3 = 0
		pp4 = 0
		cg1 = 0
		cg2 = 0
		cg3 = 0
		cg4 = 0
	end if 

		nuevaconsulta = executee(sqlnuevaconsulta,dominio)
		if not IsEmpty(nuevaconsulta) then 
			pr1=nuevaconsulta(0,l)
			pr2=nuevaconsulta(1,l)
			pr3=nuevaconsulta(2,l)
			pr4=nuevaconsulta(3,l)
			else
				pr1=0
				pr2=0
				pr3=0
				pr4=0
		
		end if
		'calculo del costo por tipo de clases
		ip1=pr1*pp1
		ip2=pr2*pp2
		ip3=pr3*pp3
		ip4=pr4*pp4

		' calculo del pago a profesor
		pfp1= pr1*pf1p
		pfp2= pr2*pf2p
		pfp3= pr3*pf3p
		pfp4= pr4*pf4p


info = "{'ok':'ok',  'Concepto':'Total clases', 'Academia 1':'"&pr1&"', 'Academia 2':'"&pr2&"', 'Academia 3':'"&pr3&"', 'Academia 4':'"&pr4&"'}, {'ok':'ok',  'Concepto':'Ingreso Total', 'Academia 1':'"&formatcurrency(ip1,2)&"', 'Academia 2':'"&formatcurrency(ip2,2)&"', 'Academia 3':'"&formatcurrency(ip3,2)&"', 'Academia 4':'"&formatcurrency(ip4,2)&"'}, {'ok':'ok',  'Concepto':'Pago a profesor', 'Academia 1':'"&formatcurrency(pfp1,2)&"', 'Academia 2':'"&formatcurrency(pfp2,2)&"', 'Academia 3':'"&formatcurrency(pfp3,2)&"', 'Academia 4':'"&formatcurrency(pfp4,2)&"'}"

	'constula de error
	if Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
	
	On Error GoTo 0    
	
end if 

if com = "consultaAcad" then 
	On Error Resume Next
	
     	for i=1 to 4
	 		sqlacad=" select "&_
		     "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_renta as date)>=CAST('"&periodoDesde&"'as date) and cast(fecha_renta as date)<=CAST('"&periodoA&"' as date))) as rca1, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC2 as date)>=CAST('"&periodoDesde&"'as date) and cast(fecha_reservaC2 as date)<=CAST('"&periodoA&"' as date))) as rca2, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC3 as date)>=CAST('"&periodoDesde&"'as date) and cast(fecha_reservaC3 as date)<=CAST('"&periodoA&"' as date))) as rca3, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC4 as date)>=CAST('"&periodoDesde&"'as date) and cast(fecha_reservaC4 as date)<=CAST('"&periodoA&"' as date))) as rca4, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC5 as date)>=CAST('"&periodoDesde&"'as date) and cast(fecha_reservaC5 as date)<=CAST('"&periodoA&"' as date))) as rca5, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC6 as date)>=CAST('"&periodoDesde&"'as date) and cast(fecha_reservaC6 as date)<=CAST('"&periodoA&"' as date))) as rca6, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC7 as date)>=CAST('"&periodoDesde&"'as date) and cast(fecha_reservaC7 as date)<=CAST('"&periodoA&"' as date))) as rca7, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC8 as date)>=CAST('"&periodoDesde&"'as date) and cast(fecha_reservaC8 as date)<=CAST('"&periodoA&"' as date))) as rca8 "
	 

			
			cacad= executee(sqlacad,dominio)

    		 if not IsEmpty(cacad) then 
					if i =1 then
					p1=cacad(0,l)+cacad(1,l)+cacad(2,l)+cacad(3,l)+cacad(4,l)+cacad(5,l)+cacad(6,l)+cacad(7,l)
            		elseif i=2 then
					p2=cacad(0,l)+cacad(1,l)+cacad(2,l)+cacad(3,l)+cacad(4,l)+cacad(5,l)+cacad(6,l)+cacad(7,l)
					elseif i=3 then
					p3=cacad(0,l)+cacad(1,l)+cacad(2,l)+cacad(3,l)+cacad(4,l)+cacad(5,l)+cacad(6,l)+cacad(7,l)			
					elseif i=4 then
					p4=cacad(0,l)+cacad(1,l)+cacad(2,l)+cacad(3,l)+cacad(4,l)+cacad(5,l)+cacad(6,l)+cacad(7,l)
					end if
			else
			p1=0
			p2=0
			p3=0
			p4=0
			end if
   		Next

		sqcostAcad="select"&_
					"(select costo_hora from  admin_tipoServicio where id=3) as costoacademia,"&_
					"(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=3 and numero_personas=1) as acp1,"&_
					"(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=3 and numero_personas=2) as acp2,"&_
					"(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=3 and numero_personas=3) as acp3,"&_
					"(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=3 and numero_personas=4) as acp4"
					
		ingAcad=executee(sqcostAcad,dominio)

			if not IsEmpty(ingAcad) then
	  			costoaca=ingAcad(0,l)
				pa1=ingAcad(1,l)
				pa2=ingAcad(2,l)
				pa3=ingAcad(3,l)
				pa4=ingAcad(4,l)

	 			costoindivacad=CInt(costoaca)/8
	  			cp1 = Cint(p1)*costoindivacad
      			cp2 = Cint(p2)*(costoindivacad*2)
	  			cp3 = Cint(p3)*(costoindivacad*3)
	  			cp4 = Cint(p4)*(costoindivacad*4)
				ppa1 = pa1*p1
				ppa2 = pa2*p2
				ppa3 = pa3*p3
				ppa4 = pa4*p4

			else 
				cp1 = 0
      			cp2 = 0
	  			cp3 = 0
	  			cp4 = 0
			    ppa1 = 0
				ppa2 = 0
				ppa3 = 0
				ppa4 = 0

			end if


	 info = "{'ok':'ok',  'Concepto':'Total clases', 'Academia 1':'"&p1&"', 'Academia 2':'"&p2&"', 'Academia 3':'"&p3&"', 'Academia 4':'"&p4&"'}, {'ok':'ok',  'Concepto':'Ingreso Total', 'Academia 1':'"&formatcurrency(cp1,2)&"', 'Academia 2':'"&formatcurrency(cp2,2)&"', 'Academia 3':'"&formatcurrency(cp3,2)&"', 'Academia 4':'"&formatcurrency(cp4,2)&"'}, {'ok':'ok',  'Concepto':'Pago a profesor', 'Academia 1':'"&formatcurrency(ppa1,2)&"', 'Academia 2':'"&formatcurrency(ppa2,2)&"', 'Academia 3':'"&formatcurrency(ppa3,2)&"', 'Academia 4':'"&formatcurrency(ppa4,2)&"'}"


	'constula de error
	if Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
	
	On Error GoTo 0    

end if

if com="consultaAdOp" then 

		sqlconsAdOp="select"&_
						"(select ISNULL(sum(ingreso_total),0) from admin_ingresos where estatus=1 and  cast(fecha_realizo as date) >= CAST('"&periodoDesde&"'as date) and cast(fecha_realizo as date) <= CAST('"&periodoA&"' as date))  tIng,"&_
						"(select ISNULL(sum(egreso_total),0) from admin_egresos where estatus=1 and  cast(fecha_realizo as date) >= CAST('"&periodoDesde&"'as date) and cast(fecha_realizo as date) <= CAST('"&periodoA&"' as date))  tEgr"

		consAdOp=executee(sqlconsAdOp,dominio)

		if not IsEmpty(consAdOp) then
			ingVen=consAdOp(0,l)
			egrAd=consAdOp(1,l)
			else 
			ingVen=0
			egrAd =0
		
		end if 

info = "{'ok':'ok',  'Concepto':'Ingreso Estimado', 'Ingreso por venta':'"&formatcurrency(ingVen,2)&"', 'Egresos Generales':'"&formatcurrency(egrAd,2)&"'}"

end if 


if com="horariosconcurridos" then 
	On Error Resume Next
		sql=  "select"&_
		      "(select isnull(count(id),0) from agenda where estado = 1 and tipo_servicio=6 and CAST(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and CAST(fecha_renta as date) <= cast('"&periodoA&"' as date)) a,"&_
			  "(select ISNULL(sum(precio_renta),0) from agenda where estado = 1 and tipo_servicio=6 and CAST(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and CAST(fecha_renta as date) <= cast('"&periodoA&"' as date)) b,"&_
			  "(select isnull(count(id),0) from agenda where estado = 1 and tipo_servicio=7 and CAST(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and CAST(fecha_renta as date) <= cast('"&periodoA&"' as date)) c,"&_
			  "(select ISNULL(sum(precio_renta),0) from agenda where estado = 1 and tipo_servicio=7 and CAST(fecha_renta as date) >= cast('"&periodoDesde&"' as date) and CAST(fecha_renta as date) <= cast('"&periodoA&"' as date)) d"

		datos = executee(sql,dominio)

		if not IsEmpty(datos) then
		muerta = datos(0,l)
		cmuert = datos(1,l)
		conc = datos(2,l)
		cconc = datos(3,l)
		end if 
   
  clastot = muerta + conc
  captot = cmuert + cconc
info = "{'ok':'ok',  'concurrida':'"&conc&"', 'muerta':'"&muerta&"', 'total':'"&clastot&"', 'ingreso':'"&formatcurrency(captot,2)&"'}, {'ok':'ok',  'concurrida':'"&formatcurrency(cconc,2)&"', 'muerta':'"&formatcurrency(cmuert,2)&"', 'total':'"&clastot&"', 'ingreso':'"&formatcurrency(captot,2)&"'}"


	'constula de error
	if Err.Number <> 0 then
		Response.write(Err.Description)
		Response.End
	end if
	
	On Error GoTo 0  

end if 

if com="global" then 

ingtotal = captot + totalre

info = "{'ok':'ok', 'resumen': '"&ingtotal&"', 'adelantados': '0', 'ingresos': '"&ingVen&"', 'egresos': '"&egrAd&"'}"

end if 


' *** listamos todos los pagos realizados en su diferentes modalidades ***

if comm = "verPagos_modalidades" then
	sql = " select ISNULL(sum(ag.precio_renta),0), ISNULL(sum(ag.playtomic),0), ISNULL(sum(ag.transferencia),0), ISNULL(sum(ag.tarjeta),0), ISNULL(sum(ag.deposito),0), ISNULL(sum(ag.efectivo),0), ISNULL(sum(ag.descuento),0) "&_
		" from agenda ag "&_
		" where ag.estado = 1 and ag.pagado=1 and "&_
		" cast(fecha_renta as date) >= cast('"&fi&"' as date) and cast(fecha_renta as date) <=cast('"&ff&"' as date) "

	datos = executee(sql,dominio)

	if not IsEmpty(datos) then
		l=0
		porcentajePlaytomic = formatnumber((CDbl(datos(1,l))*100)/(CDbl(datos(0,l))),2)
		porcentajeTransferencia = formatnumber((CDbl(datos(2,l))*100)/(CDbl(datos(0,l))),2)
		porcentajeTarjeta = formatnumber((CDbl(datos(3,l))*100)/(CDbl(datos(0,l))),2)
		porcentajeDeposito = formatnumber((CDbl(datos(4,l))*100)/(CDbl(datos(0,l))),2)
		porcentajeEfectivo = formatnumber((CDbl(datos(5,l))*100)/(CDbl(datos(0,l))),2)

		info = "{'ok':'ok', 'total': '"&formatcurrency(datos(0,l),2)&"', 'playtomic': '"&formatcurrency(datos(1,l),2)&"', 'transferencia': '"&formatcurrency(datos(2,l),2)&"', 'tarjeta': '"&formatcurrency(datos(3,l),2)&"', 'deposito': '"&formatcurrency(datos(4,l),2)&"', 'efectivo': '"&formatcurrency(datos(5,l),2)&"', 'descuento': '"&formatcurrency(datos(6,l),2)&"', 'p_playtomic':'"&porcentajePlaytomic&"', 'p_transferencia':'"&porcentajeTransferencia&"', 'p_tarjeta':'"&porcentajeTarjeta&"', 'p_deposito':'"&porcentajeDeposito&"', 'p_efectivo':'"&porcentajeEfectivo&"'}"		
	end if
end if

' consultamos el monto de clases pagadass del dia

if comm = "verClasesPagadas" then

	sql = "select isnull(sum((pagos.total_pagado/pagos.total_clases)),0) costo from admi_registro_clases clases "&_ 
			"inner join admin_control_pagosAd pagos on pagos.id  = clases.id_controlPagos "&_
			"where clases.estado = 1 and CAST( clases.fecha_clase as date) >= cast('"&fi&"' as date) and CAST( clases.fecha_clase as date) <= cast('"&ff&"' as date) "

	datos = executee(sql,dominio)

	if not IsEmpty(datos) then
  
      total = datos(0,l)

		info = "{'ok':'ok', 'total': '"&formatcurrency(total,2)&"'}"		
	end if
end if



respuesta = "{'data':["&info&"]}"
respuesta = Replace(respuesta, "'", chr(34))
response.Write(respuesta)
%>