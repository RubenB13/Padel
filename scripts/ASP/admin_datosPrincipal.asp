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

 'idUser = request.form("idUsuario")

fechaActual = request.form("fecha_actual")
periodoDesde = request.QueryString("de")
periodoA = request.QueryString("a")
fechaMes = request.QueryString("fecha_mes")


 comm = request.form("comm")
 idRegistro = request.form("idReg")
 com = request.queryString("com")




 'obtener total de ingresos venta del dia'
 If comm="ingresosVenta" Then
   sql = "select isnull(sum(ingreso_total),0)  from admin_ingresos where cast(fecha_realizo as date) = cast('"&fechaActual&"' as date) and estatus = 1"
   datos =executee(sql,dominio)
   if not IsEmpty(datos) then
 		l = 0
     for l=0 to ubound(datos,2)
       info = info & "{'ingreso_total':'"&formatcurrency(datos(0,l),2)&"'},"
       next
       info = left(info, len(info)-1)
       end if
 end if

 'obtener total de ingresos de canchas del dia'
' //// Consulta de egresos del dia sin Academia
 If comm="ingresosRenta" Then
   sql = "select "&_
            "(select ISNULL(sum(precio_renta),0) from agenda where tipo_servicio=1 and estado = 1 and cast(fecha_renta as date) = cast('"&fechaActual&"' as date)) as Totalrentanormal,"&_
		      "(select ISNULL(sum(precio_renta),0) from agenda where tipo_servicio=2 and estado = 1 and cast(fecha_renta as date) = cast('"&fechaActual&"' as date)) as TotalWPT,"&_
		      "(select ISNULL(sum(precio_renta),0) from agenda where tipo_servicio=4 and estado = 1 and cast(fecha_renta as date) = cast('"&fechaActual&"' as date)) as Totalgrupal,"&_
		      "(select ISNULL(sum(precio_renta),0) from agenda where tipo_servicio=5 and estado = 1 and cast(fecha_renta as date) = cast('"&fechaActual&"' as date)) as Totalparticular"
    datos=executee(sql,dominio)

   ' ////Consulta del precio de academia por 1 persona  se queda en $1600
   sql2="select"&_
	      "(select costo_hora from  admin_tipoServicio where id=3) as costoacademia"
' /////////////

' obtengo las clases de academia separado por dia
' //////////////
   	for i=1 to 4
	 		sql3="select "&_
		       "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_renta as date)=CAST('"&fechaActual&"'as date))) as rca1, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC2 as date)=CAST('"&fechaActual&"'as date))) as rca2, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC3 as date)=CAST('"&fechaActual&"'as date))) as rca3, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC4 as date)=CAST('"&fechaActual&"'as date))) as rca4, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC5 as date)=CAST('"&fechaActual&"'as date))) as rca5, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC6 as date)=CAST('"&fechaActual&"'as date))) as rca6, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC7 as date)=CAST('"&fechaActual&"'as date))) as rca7, "&_
             "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and (cast(fecha_reservaC8 as date)=CAST('"&fechaActual&"'as date))) as rca8 "
	             		
			datos4= executee(sql3,dominio)

    		 if not IsEmpty(datos4) then 
					if i =1 then
					p1=datos4(0,l)+datos4(1,l)+datos4(2,l)+datos4(3,l)+datos4(4,l)+datos4(5,l)+datos4(6,l)+datos4(7,l)
            		elseif i=2 then
					p2=datos4(0,l)+datos4(1,l)+datos4(2,l)+datos4(3,l)+datos4(4,l)+datos4(5,l)+datos4(6,l)+datos4(7,l)
					elseif i=3 then
					p3=datos4(0,l)+datos4(1,l)+datos4(2,l)+datos4(3,l)+datos4(4,l)+datos4(5,l)+datos4(6,l)+datos4(7,l)			
					elseif i=4 then
					p4=datos4(0,l)+datos4(1,l)+datos4(2,l)+datos4(3,l)+datos4(4,l)+datos4(5,l)+datos4(6,l)+datos4(7,l)
					end if
			else
			   p1=0
			   p2=0
			   p3=0
			   p4=0
			end if
   		Next
	
   'Se calcula el ingreso por clases separadas de la academia
        datos3=executee(sql2,dominio)

			if not IsEmpty(datos3) then
	  			costoaca=datos3(0,l)
	 			costoindivacad=CInt(costoaca)/8
	  			cp1 = Cint(p1)*costoindivacad
      		cp2 = Cint(p2)*(costoindivacad*2)
	  			cp3 = Cint(p3)*(costoindivacad*3)
	  			cp4 = Cint(p4)*(costoindivacad*4)
	  			ingresoAc=cp1+cp2+cp3+cp4
			else 
			costoaca=datos3(0,l)
	 		costoindivacad=CInt(costoaca)/8
			ingresoAc=0
			end if

'  se inserta toda la información de ingresos de renta del dia
      if not IsEmpty(datos) then 
         ingRn =  datos(0,l)
         ingWpt = datos(1,l)
         ingCg =  datos(2,l)
         ingCp =  datos(3,l)
         IngresoDia = CDbl(ingRn)+CDbl(ingWpt)+CDbl(ingCg)+CDbl(ingCp)+CDbl(ingresoAc)
         info = "{'ingresos_renta':'"&formatcurrency(IngresoDia,2)&"'}"
      end if
 end if

 'obtener resumen general del mes'
 If com="resumenMensual" Then
   fechaAnio = date
   anio = Year(fechaAnio)
  '' response.Write(com + fechaMes)
   sql = "Select ( Select isnull(sum(precio_renta),0) from agenda where MONTH(fecha_renta) = MONTH('"&fechaMes&"') and YEAR(fecha_renta) = '"&anio&"' and estado = 1 and tipo_servicio<>3), "&_  
      " (Select isnull(sum(egreso_total),0) from admin_egresos where  MONTH(fecha_realizo) = MONTH('"&fechaMes&"') and YEAR(fecha_realizo) = '"&anio&"' and estatus = 1), "&_  
      " (Select  isnull(sum(ingreso_total),0) from admin_ingresos where MONTH(fecha_realizo) = MONTH('"&fechaMes&"') and YEAR(fecha_realizo) = '"&anio&"' and estatus = 1),"&_
      " (select costo_hora from  admin_tipoServicio where id=3)"

   	for i=1 to 4
            nuevaconsulta="select"&_
		"(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and month(fecha_renta)= month('"&fechaMes&"') and year(fecha_renta) = ('"&anio&"')) as rca1,"&_
      "(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and month(fecha_reservaC2)= month('"&fechaMes&"') and year(fecha_reservaC2) = ('"&anio&"')) as rca2,"&_
		"(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and month(fecha_reservaC3)= month('"&fechaMes&"') and year(fecha_reservaC3) = ('"&anio&"')) as rca3,"&_
		"(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and month(fecha_reservaC4)= month('"&fechaMes&"') and year(fecha_reservaC4) = ('"&anio&"')) as rca4,"&_
		"(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and month(fecha_reservaC5)= month('"&fechaMes&"') and year(fecha_reservaC5) = ('"&anio&"')) as rca5,"&_
		"(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and month(fecha_reservaC6)= month('"&fechaMes&"') and year(fecha_reservaC6) = ('"&anio&"')) as rca6,"&_
		"(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and month(fecha_reservaC7)= month('"&fechaMes&"') and year(fecha_reservaC7) = ('"&anio&"')) as rca7,"&_
		"(select count(*) from agenda where tipo_servicio=3 and estado=1 and numero_personas = '"&i&"' and month(fecha_reservaC8)= month('"&fechaMes&"') and year(fecha_reservaC8) = ('"&anio&"')) as rca8"
      		
            datosnuevos= executee(nuevaconsulta,dominio)

    		 if not IsEmpty(datosnuevos) then 
					if i =1 then
					p1=datosnuevos(0,l)+datosnuevos(1,l)+datosnuevos(2,l)+datosnuevos(3,l)+datosnuevos(4,l)+datosnuevos(5,l)+datosnuevos(6,l)+datosnuevos(7,l)
            	elseif i=2 then
					p2=datosnuevos(0,l)+datosnuevos(1,l)+datosnuevos(2,l)+datosnuevos(3,l)+datosnuevos(4,l)+datosnuevos(5,l)+datosnuevos(6,l)+datosnuevos(7,l)
					elseif i=3 then
					p3=datosnuevos(0,l)+datosnuevos(1,l)+datosnuevos(2,l)+datosnuevos(3,l)+datosnuevos(4,l)+datosnuevos(5,l)+datosnuevos(6,l)+datosnuevos(7,l)			
					elseif i=4 then
					p4=datosnuevos(0,l)+datosnuevos(1,l)+datosnuevos(2,l)+datosnuevos(3,l)+datosnuevos(4,l)+datosnuevos(5,l)+datosnuevos(6,l)+datosnuevos(7,l)
					end if
			else
			   p1=0
			   p2=0
			   p3=0
			   p4=0
			end if
   		Next

  'capturo todas las clases PARTICULAR por número de persona
 
   clasesmesparticulares="select "&_
                           "(select count(*) from agenda where tipo_servicio=5 and estado=1 and month(fecha_renta) = month('"&fechaMes&"') and year(fecha_renta)='"&anio&"' and numero_personas=1),"&_
                           "(select count(*) from agenda where tipo_servicio=5 and estado=1 and month(fecha_renta) = month('"&fechaMes&"') and year(fecha_renta)='"&anio&"' and numero_personas=2),"&_
                           "(select count(*) from agenda where tipo_servicio=5 and estado=1 and month(fecha_renta) = month('"&fechaMes&"') and year(fecha_renta)='"&anio&"' and numero_personas=3),"&_
                           "(select count(*) from agenda where tipo_servicio=5 and estado=1 and month(fecha_renta) = month('"&fechaMes&"') and year(fecha_renta)='"&anio&"' and numero_personas=4)"
   'capturo todas las clases GRUPAL por número de personas
   consultaclasesgrupalesporpersona="select "&_
                           "(select count(*) from agenda where tipo_servicio=4 and estado=1 and month(fecha_renta) = month('"&fechaMes&"') and year(fecha_renta)='"&anio&"' and numero_personas=2),"&_
                           "(select count(*) from agenda where tipo_servicio=4 and estado=1 and month(fecha_renta) = month('"&fechaMes&"') and year(fecha_renta)='"&anio&"' and numero_personas=3),"&_
                           "(select count(*) from agenda where tipo_servicio=4 and estado=1 and month(fecha_renta) = month('"&fechaMes&"') and year(fecha_renta)='"&anio&"' and numero_personas=4)"
   'consulta del pago de profesor PARTICULAR por # personas
costopartcons="select "&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=5 and numero_personas=1),"&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=5 and numero_personas=2),"&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=5 and numero_personas=3),"&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=5 and numero_personas=4)"
'consulta de pago profesor clase GRUPAL por # de personas
consultacostogrupal="select "&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=4 and numero_personas=2),"&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=4 and numero_personas=3),"&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=4 and numero_personas=4)"
'se ejecuta consulta pago profesor clase GRUPAL por # de personas

'Consulta pago profesor para ACADEMIA por # personas
consultaacademiapago="select "&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=3 and numero_personas=1),"&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=3 and numero_personas=2),"&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=3 and numero_personas=3),"&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=3 and numero_personas=4)"

pagoprofeacademia=executee(consultaacademiapago,dominio)
 if not IsEmpty(pagoprofeacademia) then          
         pago1aca=pagoprofeacademia(0,l)
         pago2aca=pagoprofeacademia(1,l)
         pago3aca=pagoprofeacademia(2,l)
         pago4aca=pagoprofeacademia(3,l)
       else
         pago1aca=0
         pago2aca=0
         pago3aca=0
         pago4aca=0
       end if

costogrupal=executee(consultacostogrupal,dominio)

      if not IsEmpty(costogrupal) then 
         precio2grup=costogrupal(0,l)
         precio3grup=costogrupal(1,l)
         precio4grup=costogrupal(2,l)
      else
      precio2grup=0
      precio3grup=0
      precio4grup=0
      end if
'se ejecuta consulta del número de clases grupales por # de personas

clasesgrupales=executee(consultaclasesgrupalesporpersona,dominio)
   if not IsEmpty(clasesgrupales) Then
       ttclsgrup2=clasesgrupales(0,l)
       ttclsgrup3=clasesgrupales(1,l)
       ttclsgrup4=clasesgrupales(2,l)
       else 
       ttclsgrup2=0
       ttclsgrup3=0
       ttclsgrup4=0
   end if
 'se ejecuta consulta pago profesor clase particular por # personas
costopart=executee(costopartcons,dominio)

      if not IsEmpty(costopart) then          
         precio1part=costopart(0,l)
         precio2part=costopart(1,l)
         precio3part=costopart(2,l)
         precio4part=costopart(3,l)
       else
       precio1part=0
       precio2part=0
       precio3part=0
       precio4part=0
       end if

   particulares=executee(clasesmesparticulares,dominio)
   
         if not IsEmpty(particulares) then
         part1=particulares(0,l)
         part2=particulares(1,l)
         part3=particulares(2,l)
         part4=particulares(3,l)
         end if
    
    
   datos = executee(sql,dominio)
   if not IsEmpty(datos) then
 	  
     'calculamos el egreso de maestros por clases particulares 
     egresomaestroclaseparticular=(precio1part*part1)+(precio2part*part2)+(precio3part*part3)+(precio4part*part4)
     'calculamos el egreso de maestros por clases grupales
     egresomaestroclasegrupal=(ttclsgrup2*precio2grup)+(ttclsgrup3*precio3grup)+(ttclsgrup4*precio4grup)
     'calculamos el egreso de maestros por clases de academia
     egresomaestroclaseacademia=(p1*pago1aca)+(p2*pago2aca)+(p3*pago3aca)+(p4*pago4aca)
     ingresocancha = datos(0,l)
     egresoOperati = datos(1,l)
     ingresoventa= datos(2,l)
     costoclaseacademia= datos(3,l)/8 'costo de clase sola
     ingresoacademia1= p1*(costoclaseacademia*1)
     ingresoacademia2= p2*(costoclaseacademia*2)
     ingresoacademia3= p3*(costoclaseacademia*3)
     ingresoacademia4= p4*(costoclaseacademia*4)
     ingresomesacademia= ingresoacademia1+ingresoacademia2+ingresoacademia3+ingresoacademia4
     egresosMaestros = egresomaestroclaseparticular+egresomaestroclasegrupal+egresomaestroclaseacademia
     ingresorealmes=ingresocancha+ingresomesacademia
   

        '' info = info & "{'ingreso_cancha':'"&ingresocancha&"','egreso_total':'"&ingresoventa&"', 'ingreso_total':'"&egresoOperati&"', 'egreso_maestros':'"&egresosMaestros&"'},"
     balance = (ingresorealmes + ingresoventa) - (egresoOperati + egresosMaestros)
     info = "{'ingreso_cancha':'"&formatcurrency(ingresorealmes,2)&"','egreso_total':'"&formatcurrency(egresoOperati,2)&"', 'ingreso_total':'"&formatcurrency(ingresoventa,2)&"', 'egreso_maestros':'"&formatcurrency(egresosMaestros,2)&"','balance':'"&formatcurrency(balance,2)&"'}"
  
     end if
 end if

'  /////////////////////////////// INICIA CONSULTA ANUAL, JORGE aqui estaba XD


'/////////////////// INICIA NUEVA CONSULTA ANUAL la chida
 If com="resumenAnual" Then
   On Error Resume Next
   fechaAnio = date
   anio = Year(fechaAnio)

   'consulta de ventas por mes
   consventasmeses= "select "&_
                        "(select ISNULL(sum(ingreso_total),0) from admin_ingresos where estatus=1 and month(fecha_realizo) =1 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select ISNULL(sum(ingreso_total),0) from admin_ingresos where estatus=1 and month(fecha_realizo) =2 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select ISNULL(sum(ingreso_total),0) from admin_ingresos where estatus=1 and month(fecha_realizo) =3 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select ISNULL(sum(ingreso_total),0) from admin_ingresos where estatus=1 and month(fecha_realizo) =4 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select ISNULL(sum(ingreso_total),0) from admin_ingresos where estatus=1 and month(fecha_realizo) =5 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select ISNULL(sum(ingreso_total),0) from admin_ingresos where estatus=1 and month(fecha_realizo) =6 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select ISNULL(sum(ingreso_total),0) from admin_ingresos where estatus=1 and month(fecha_realizo) =7 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select ISNULL(sum(ingreso_total),0) from admin_ingresos where estatus=1 and month(fecha_realizo) =8 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select ISNULL(sum(ingreso_total),0) from admin_ingresos where estatus=1 and month(fecha_realizo) =9 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select ISNULL(sum(ingreso_total),0) from admin_ingresos where estatus=1 and month(fecha_realizo) =10 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select ISNULL(sum(ingreso_total),0) from admin_ingresos where estatus=1 and month(fecha_realizo) =11 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select ISNULL(sum(ingreso_total),0) from admin_ingresos where estatus=1 and month(fecha_realizo) =12 and year(fecha_realizo)='"&anio&"')"
      'consulta egresos del mes
    consegresosmeses = "select "&_
                        "(select isnull(sum(egreso_total),0) from admin_egresos where estatus=1 and month(fecha_realizo) =1 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select isnull(sum(egreso_total),0) from admin_egresos where estatus=1 and month(fecha_realizo) =2 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select isnull(sum(egreso_total),0) from admin_egresos where estatus=1 and month(fecha_realizo) =3 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select isnull(sum(egreso_total),0) from admin_egresos where estatus=1 and month(fecha_realizo) =4 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select isnull(sum(egreso_total),0) from admin_egresos where estatus=1 and month(fecha_realizo) =5 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select isnull(sum(egreso_total),0) from admin_egresos where estatus=1 and month(fecha_realizo) =6 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select isnull(sum(egreso_total),0) from admin_egresos where estatus=1 and month(fecha_realizo) =7 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select isnull(sum(egreso_total),0) from admin_egresos where estatus=1 and month(fecha_realizo) =8 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select isnull(sum(egreso_total),0) from admin_egresos where estatus=1 and month(fecha_realizo) =9 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select isnull(sum(egreso_total),0) from admin_egresos where estatus=1 and month(fecha_realizo) =10 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select isnull(sum(egreso_total),0) from admin_egresos where estatus=1 and month(fecha_realizo) =11 and year(fecha_realizo)='"&anio&"'),"&_
                        "(select isnull(sum(egreso_total),0) from admin_egresos where estatus=1 and month(fecha_realizo) =12 and year(fecha_realizo)='"&anio&"')"
         'consulta descuentos del mes
      consdescuentosmes = "select "&_
                              "(select isnull(sum(descuento),0) from agenda where estado =1 and month(fecha_renta) = 1 and year(fecha_renta) = '"&anio&"'),"&_
                              "(select isnull(sum(descuento),0) from agenda where estado =1 and month(fecha_renta) = 2 and year(fecha_renta) = '"&anio&"'),"&_
                              "(select isnull(sum(descuento),0) from agenda where estado =1 and month(fecha_renta) = 3 and year(fecha_renta) = '"&anio&"'),"&_
                              "(select isnull(sum(descuento),0) from agenda where estado =1 and month(fecha_renta) = 4 and year(fecha_renta) = '"&anio&"'),"&_
                              "(select isnull(sum(descuento),0) from agenda where estado =1 and month(fecha_renta) = 5 and year(fecha_renta) = '"&anio&"'),"&_
                              "(select isnull(sum(descuento),0) from agenda where estado =1 and month(fecha_renta) = 6 and year(fecha_renta) = '"&anio&"'),"&_
                              "(select isnull(sum(descuento),0) from agenda where estado =1 and month(fecha_renta) = 7 and year(fecha_renta) = '"&anio&"'),"&_
                              "(select isnull(sum(descuento),0) from agenda where estado =1 and month(fecha_renta) = 8 and year(fecha_renta) = '"&anio&"'),"&_
                              "(select isnull(sum(descuento),0) from agenda where estado =1 and month(fecha_renta) = 9 and year(fecha_renta) = '"&anio&"'),"&_
                              "(select isnull(sum(descuento),0) from agenda where estado =1 and month(fecha_renta) = 10 and year(fecha_renta) = '"&anio&"'),"&_
                              "(select isnull(sum(descuento),0) from agenda where estado =1 and month(fecha_renta) = 11 and year(fecha_renta) = '"&anio&"'),"&_
                              "(select isnull(sum(descuento),0) from agenda where estado =1 and month(fecha_renta) = 12 and year(fecha_renta) = '"&anio&"')"
      
      'consulta de todos los servicios sin academias 

      consrentassinacademia= "select "&_
                                 "(select ISNULL(sum(precio_renta),0) from agenda where estado=1 and tipo_servicio <>3 and month(fecha_renta) = 1 and year(fecha_renta)='"&anio&"'),"&_
                                 "(select ISNULL(sum(precio_renta),0) from agenda where estado=1 and tipo_servicio <>3 and month(fecha_renta) = 2 and year(fecha_renta)='"&anio&"'),"&_
                                 "(select ISNULL(sum(precio_renta),0) from agenda where estado=1 and tipo_servicio <>3 and month(fecha_renta) = 3 and year(fecha_renta)='"&anio&"'),"&_
                                 "(select ISNULL(sum(precio_renta),0) from agenda where estado=1 and tipo_servicio <>3 and month(fecha_renta) = 4 and year(fecha_renta)='"&anio&"'),"&_
                                 "(select ISNULL(sum(precio_renta),0) from agenda where estado=1 and tipo_servicio <>3 and month(fecha_renta) = 5 and year(fecha_renta)='"&anio&"'),"&_
                                 "(select ISNULL(sum(precio_renta),0) from agenda where estado=1 and tipo_servicio <>3 and month(fecha_renta) = 6 and year(fecha_renta)='"&anio&"'),"&_
                                 "(select ISNULL(sum(precio_renta),0) from agenda where estado=1 and tipo_servicio <>3 and month(fecha_renta) = 7 and year(fecha_renta)='"&anio&"'),"&_
                                 "(select ISNULL(sum(precio_renta),0) from agenda where estado=1 and tipo_servicio <>3 and month(fecha_renta) = 8 and year(fecha_renta)='"&anio&"'),"&_
                                 "(select ISNULL(sum(precio_renta),0) from agenda where estado=1 and tipo_servicio <>3 and month(fecha_renta) = 9 and year(fecha_renta)='"&anio&"'),"&_
                                 "(select ISNULL(sum(precio_renta),0) from agenda where estado=1 and tipo_servicio <>3 and month(fecha_renta) = 10 and year(fecha_renta)='"&anio&"'),"&_
                                 "(select ISNULL(sum(precio_renta),0) from agenda where estado=1 and tipo_servicio <>3 and month(fecha_renta) = 11 and year(fecha_renta)='"&anio&"'),"&_
                                 "(select ISNULL(sum(precio_renta),0) from agenda where estado=1 and tipo_servicio <>3 and month(fecha_renta) = 12 and year(fecha_renta)='"&anio&"')"
      
      'consulta de academias2 por mes y año ////
      'consulta de 1 persona de enero a diciembre
      for j=1 to 12
            consultaAcad1persona="select"&_ 
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=1 and MONTH(fecha_renta)= '"&j&"' and year(fecha_renta)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=1 and MONTH(fecha_reservaC2)= '"&j&"' and year(fecha_reservaC2)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=1 and MONTH(fecha_reservaC3)= '"&j&"' and year(fecha_reservaC3)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=1 and MONTH(fecha_reservaC4)= '"&j&"' and year(fecha_reservaC4)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=1 and MONTH(fecha_reservaC5)= '"&j&"' and year(fecha_reservaC5)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=1 and MONTH(fecha_reservaC6)= '"&j&"' and year(fecha_reservaC6)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=1 and MONTH(fecha_reservaC7)= '"&j&"' and year(fecha_reservaC7)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=1 and MONTH(fecha_reservaC8)= '"&j&"' and year(fecha_reservaC8)='"&anio&"')"


            acad1persona= executee(consultaAcad1persona,dominio)

    		 if not IsEmpty(acad1persona) then 
					if j =1 then
					acadEne1P=acad1persona(0,l)+acad1persona(1,l)+acad1persona(2,l)+acad1persona(3,l)+acad1persona(4,l)+acad1persona(5,l)+acad1persona(6,l)+acad1persona(7,l)
            	elseif j=2 then
					acadFeb1P=acad1persona(0,l)+acad1persona(1,l)+acad1persona(2,l)+acad1persona(3,l)+acad1persona(4,l)+acad1persona(5,l)+acad1persona(6,l)+acad1persona(7,l)
					elseif j=3 then
					acadMar1P=acad1persona(0,l)+acad1persona(1,l)+acad1persona(2,l)+acad1persona(3,l)+acad1persona(4,l)+acad1persona(5,l)+acad1persona(6,l)+acad1persona(7,l)			
					elseif j=4 then
					acadAbr1P=acad1persona(0,l)+acad1persona(1,l)+acad1persona(2,l)+acad1persona(3,l)+acad1persona(4,l)+acad1persona(5,l)+acad1persona(6,l)+acad1persona(7,l)
				   elseif j=5 then
					acadMay1P=acad1persona(0,l)+acad1persona(1,l)+acad1persona(2,l)+acad1persona(3,l)+acad1persona(4,l)+acad1persona(5,l)+acad1persona(6,l)+acad1persona(7,l)
				   elseif j=6 then
					acadJun1P=acad1persona(0,l)+acad1persona(1,l)+acad1persona(2,l)+acad1persona(3,l)+acad1persona(4,l)+acad1persona(5,l)+acad1persona(6,l)+acad1persona(7,l)
               elseif j=7 then
					acadJul1P=acad1persona(0,l)+acad1persona(1,l)+acad1persona(2,l)+acad1persona(3,l)+acad1persona(4,l)+acad1persona(5,l)+acad1persona(6,l)+acad1persona(7,l)
               elseif j=8 then
					acadAgo1P=acad1persona(0,l)+acad1persona(1,l)+acad1persona(2,l)+acad1persona(3,l)+acad1persona(4,l)+acad1persona(5,l)+acad1persona(6,l)+acad1persona(7,l)
               elseif j=9 then
					acadSep1P=acad1persona(0,l)+acad1persona(1,l)+acad1persona(2,l)+acad1persona(3,l)+acad1persona(4,l)+acad1persona(5,l)+acad1persona(6,l)+acad1persona(7,l)
               elseif j=10 then
					acadOct1P=acad1persona(0,l)+acad1persona(1,l)+acad1persona(2,l)+acad1persona(3,l)+acad1persona(4,l)+acad1persona(5,l)+acad1persona(6,l)+acad1persona(7,l)
               elseif j=11 then
					acadNov1P=acad1persona(0,l)+acad1persona(1,l)+acad1persona(2,l)+acad1persona(3,l)+acad1persona(4,l)+acad1persona(5,l)+acad1persona(6,l)+acad1persona(7,l)
               elseif j=12 then
					acadDic1P=acad1persona(0,l)+acad1persona(1,l)+acad1persona(2,l)+acad1persona(3,l)+acad1persona(4,l)+acad1persona(5,l)+acad1persona(6,l)+acad1persona(7,l)
               end if
			else
			  acadEne1P  =0
           acadFeb1P  =0
           acadMar1P  =0
           acadAbr1P  =0
           acadMay1P  =0  
           acadJun1P  =0
           acadJul1P  =0
           acadAgo1P  =0
           acadSep1P  =0 
           acadOct1P  =0 
           acadNov1P  =0 
           acadDic1P  =0
 
			end if
   		Next  
        'se termina consulta de academia  1 persona por mes

        'inicia consulta de academia de 2 personas en el año 
  for k=1 to 12
            consultaAcad2persona="select"&_ 
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=2 and MONTH(fecha_renta)= '"&k&"' and year(fecha_renta)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=2 and MONTH(fecha_reservaC2)= '"&k&"' and year(fecha_reservaC2)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=2 and MONTH(fecha_reservaC3)= '"&k&"' and year(fecha_reservaC3)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=2 and MONTH(fecha_reservaC4)= '"&k&"' and year(fecha_reservaC4)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=2 and MONTH(fecha_reservaC5)= '"&k&"' and year(fecha_reservaC5)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=2 and MONTH(fecha_reservaC6)= '"&k&"' and year(fecha_reservaC6)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=2 and MONTH(fecha_reservaC7)= '"&k&"' and year(fecha_reservaC7)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=2 and MONTH(fecha_reservaC8)= '"&k&"' and year(fecha_reservaC8)='"&anio&"')"


            acad2persona= executee(consultaAcad2persona,dominio)

    		 if not IsEmpty(acad2persona) then 
					if k =1 then
					acadEne2P=acad2persona(0,l)+acad2persona(1,l)+acad2persona(2,l)+acad2persona(3,l)+acad2persona(4,l)+acad2persona(5,l)+acad2persona(6,l)+acad2persona(7,l)
            	elseif k=2 then
					acadFeb2P=acad2persona(0,l)+acad2persona(1,l)+acad2persona(2,l)+acad2persona(3,l)+acad2persona(4,l)+acad2persona(5,l)+acad2persona(6,l)+acad2persona(7,l)
					elseif k=3 then
					acadMar2P=acad2persona(0,l)+acad2persona(1,l)+acad2persona(2,l)+acad2persona(3,l)+acad2persona(4,l)+acad2persona(5,l)+acad2persona(6,l)+acad2persona(7,l)			
					elseif k=4 then
					acadAbr2P=acad2persona(0,l)+acad2persona(1,l)+acad2persona(2,l)+acad2persona(3,l)+acad2persona(4,l)+acad2persona(5,l)+acad2persona(6,l)+acad2persona(7,l)
				   elseif k=5 then
					acadMay2P=acad2persona(0,l)+acad2persona(1,l)+acad2persona(2,l)+acad2persona(3,l)+acad2persona(4,l)+acad2persona(5,l)+acad2persona(6,l)+acad2persona(7,l)
				   elseif k=6 then
					acadJun2P=acad2persona(0,l)+acad2persona(1,l)+acad2persona(2,l)+acad2persona(3,l)+acad2persona(4,l)+acad2persona(5,l)+acad2persona(6,l)+acad2persona(7,l)
               elseif k=7 then
					acadJul2P=acad2persona(0,l)+acad2persona(1,l)+acad2persona(2,l)+acad2persona(3,l)+acad2persona(4,l)+acad2persona(5,l)+acad2persona(6,l)+acad2persona(7,l)
               elseif k=8 then
					acadAgo2P=acad2persona(0,l)+acad2persona(1,l)+acad2persona(2,l)+acad2persona(3,l)+acad2persona(4,l)+acad2persona(5,l)+acad2persona(6,l)+acad2persona(7,l)
               elseif k=9 then
					acadSep2P=acad2persona(0,l)+acad2persona(1,l)+acad2persona(2,l)+acad2persona(3,l)+acad2persona(4,l)+acad2persona(5,l)+acad2persona(6,l)+acad2persona(7,l)
               elseif k=10 then
					acadOct2P=acad2persona(0,l)+acad2persona(1,l)+acad2persona(2,l)+acad2persona(3,l)+acad2persona(4,l)+acad2persona(5,l)+acad2persona(6,l)+acad2persona(7,l)
               elseif k=11 then
					acadNov2P=acad2persona(0,l)+acad2persona(1,l)+acad2persona(2,l)+acad2persona(3,l)+acad2persona(4,l)+acad2persona(5,l)+acad2persona(6,l)+acad2persona(7,l)
               elseif k=12 then
					acadDic2P=acad2persona(0,l)+acad2persona(1,l)+acad2persona(2,l)+acad2persona(3,l)+acad2persona(4,l)+acad2persona(5,l)+acad2persona(6,l)+acad2persona(7,l)
               end if
			else
			  acadEne2P =0
           acadFeb2P  =0
           acadMar2P  =0
           acadAbr2P  =0
           acadMay2P  =0  
           acadJun2P  =0
           acadJul2P  =0
           acadAgo2P  =0
           acadSep2P  =0 
           acadOct2P  =0 
           acadNov2P  =0 
           acadDic2P  =0
 
			end if
   		Next 
         'se termina consulta de academia 2 persona por mes
         'Inicia consulta de academia 3 personas por mes

for m=1 to 12
            consultaAcad3persona="select"&_ 
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=3 and MONTH(fecha_renta)= '"&m&"' and year(fecha_renta)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=3 and MONTH(fecha_reservaC2)= '"&m&"' and year(fecha_reservaC2)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=3 and MONTH(fecha_reservaC3)= '"&m&"' and year(fecha_reservaC3)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=3 and MONTH(fecha_reservaC4)= '"&m&"' and year(fecha_reservaC4)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=3 and MONTH(fecha_reservaC5)= '"&m&"' and year(fecha_reservaC5)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=3 and MONTH(fecha_reservaC6)= '"&m&"' and year(fecha_reservaC6)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=3 and MONTH(fecha_reservaC7)= '"&m&"' and year(fecha_reservaC7)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=3 and MONTH(fecha_reservaC8)= '"&m&"' and year(fecha_reservaC8)='"&anio&"')"


            acad3persona= executee(consultaAcad3persona,dominio)

    		 if not IsEmpty(acad3persona) then 
					if m=1 then
					acadEne3P=acad3persona(0,l)+acad3persona(1,l)+acad3persona(2,l)+acad3persona(3,l)+acad3persona(4,l)+acad3persona(5,l)+acad3persona(6,l)+acad3persona(7,l)
            	elseif m=2 then
					acadFeb3P=acad3persona(0,l)+acad3persona(1,l)+acad3persona(2,l)+acad3persona(3,l)+acad3persona(4,l)+acad3persona(5,l)+acad3persona(6,l)+acad3persona(7,l)
					elseif m=3 then
					acadMar3P=acad3persona(0,l)+acad3persona(1,l)+acad3persona(2,l)+acad3persona(3,l)+acad3persona(4,l)+acad3persona(5,l)+acad3persona(6,l)+acad3persona(7,l)			
					elseif m=4 then
					acadAbr3P=acad3persona(0,l)+acad3persona(1,l)+acad3persona(2,l)+acad3persona(3,l)+acad3persona(4,l)+acad3persona(5,l)+acad3persona(6,l)+acad3persona(7,l)
				   elseif m=5 then
					acadMay3P=acad3persona(0,l)+acad3persona(1,l)+acad3persona(2,l)+acad3persona(3,l)+acad3persona(4,l)+acad3persona(5,l)+acad3persona(6,l)+acad3persona(7,l)
				   elseif m=6 then
					acadJun3P=acad3persona(0,l)+acad3persona(1,l)+acad3persona(2,l)+acad3persona(3,l)+acad3persona(4,l)+acad3persona(5,l)+acad3persona(6,l)+acad3persona(7,l)
               elseif m=7 then
					acadJul3P=acad3persona(0,l)+acad3persona(1,l)+acad3persona(2,l)+acad3persona(3,l)+acad3persona(4,l)+acad3persona(5,l)+acad3persona(6,l)+acad3persona(7,l)
               elseif m=8 then
					acadAgo3P=acad3persona(0,l)+acad3persona(1,l)+acad3persona(2,l)+acad3persona(3,l)+acad3persona(4,l)+acad3persona(5,l)+acad3persona(6,l)+acad3persona(7,l)
               elseif m=9 then
					acadSep3P=acad3persona(0,l)+acad3persona(1,l)+acad3persona(2,l)+acad3persona(3,l)+acad3persona(4,l)+acad3persona(5,l)+acad3persona(6,l)+acad3persona(7,l)
               elseif m=10 then
					acadOct3P=acad3persona(0,l)+acad3persona(1,l)+acad3persona(2,l)+acad3persona(3,l)+acad3persona(4,l)+acad3persona(5,l)+acad3persona(6,l)+acad3persona(7,l)
               elseif m=11 then
					acadNov3P=acad3persona(0,l)+acad3persona(1,l)+acad3persona(2,l)+acad3persona(3,l)+acad3persona(4,l)+acad3persona(5,l)+acad3persona(6,l)+acad3persona(7,l)
               elseif m=12 then
					acadDic3P=acad3persona(0,l)+acad3persona(1,l)+acad3persona(2,l)+acad3persona(3,l)+acad3persona(4,l)+acad3persona(5,l)+acad3persona(6,l)+acad3persona(7,l)
               end if
			else
			  acadEne3P =0
           acadFeb3P  =0
           acadMar3P  =0
           acadAbr3P  =0
           acadMay3P  =0  
           acadJun3P  =0
           acadJul3P  =0
           acadAgo3P  =0
           acadSep3P  =0 
           acadOct3P  =0 
           acadNov3P  =0 
           acadDic3P  =0
 
			end if
   		Next 
      ' Termina consulta academia 3 personas por mes

      ' inicia consulta academia 4 personas por mes
for n=1 to 12
            consultaAcad4persona="select"&_ 
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=4 and MONTH(fecha_renta)= '"&n&"' and year(fecha_renta)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=4 and MONTH(fecha_reservaC2)= '"&n&"' and year(fecha_reservaC2)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=4 and MONTH(fecha_reservaC3)= '"&n&"' and year(fecha_reservaC3)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=4 and MONTH(fecha_reservaC4)= '"&n&"' and year(fecha_reservaC4)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=4 and MONTH(fecha_reservaC5)= '"&n&"' and year(fecha_reservaC5)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=4 and MONTH(fecha_reservaC6)= '"&n&"' and year(fecha_reservaC6)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=4 and MONTH(fecha_reservaC7)= '"&n&"' and year(fecha_reservaC7)='"&anio&"'),"&_
	                        "(select count(*) from agenda where estado=1 and tipo_servicio =3 and numero_personas=4 and MONTH(fecha_reservaC8)= '"&n&"' and year(fecha_reservaC8)='"&anio&"')"


            acad4persona= executee(consultaAcad4persona,dominio)

    		 if not IsEmpty(acad4persona) then 
					if n=1 then
					acadEne4P=acad4persona(0,l)+acad4persona(1,l)+acad4persona(2,l)+acad4persona(3,l)+acad4persona(4,l)+acad4persona(5,l)+acad4persona(6,l)+acad4persona(7,l)
            	elseif n=2 then
					acadFeb4P=acad4persona(0,l)+acad4persona(1,l)+acad4persona(2,l)+acad4persona(3,l)+acad4persona(4,l)+acad4persona(5,l)+acad4persona(6,l)+acad4persona(7,l)
					elseif n=3 then
					acadMar4P=acad4persona(0,l)+acad4persona(1,l)+acad4persona(2,l)+acad4persona(3,l)+acad4persona(4,l)+acad4persona(5,l)+acad4persona(6,l)+acad4persona(7,l)			
					elseif n=4 then
					acadAbr4P=acad4persona(0,l)+acad4persona(1,l)+acad4persona(2,l)+acad4persona(3,l)+acad4persona(4,l)+acad4persona(5,l)+acad4persona(6,l)+acad4persona(7,l)
				   elseif n=5 then
					acadMay4P=acad4persona(0,l)+acad4persona(1,l)+acad4persona(2,l)+acad4persona(3,l)+acad4persona(4,l)+acad4persona(5,l)+acad4persona(6,l)+acad4persona(7,l)
				   elseif n=6 then
					acadJun4P=acad4persona(0,l)+acad4persona(1,l)+acad4persona(2,l)+acad4persona(3,l)+acad4persona(4,l)+acad4persona(5,l)+acad4persona(6,l)+acad4persona(7,l)
               elseif n=7 then
					acadJul4P=acad4persona(0,l)+acad4persona(1,l)+acad4persona(2,l)+acad4persona(3,l)+acad4persona(4,l)+acad4persona(5,l)+acad4persona(6,l)+acad4persona(7,l)
               elseif n=8 then
					acadAgo4P=acad4persona(0,l)+acad4persona(1,l)+acad4persona(2,l)+acad4persona(3,l)+acad4persona(4,l)+acad4persona(5,l)+acad4persona(6,l)+acad4persona(7,l)
               elseif n=9 then
					acadSep4P=acad4persona(0,l)+acad4persona(1,l)+acad4persona(2,l)+acad4persona(3,l)+acad4persona(4,l)+acad4persona(5,l)+acad4persona(6,l)+acad4persona(7,l)
               elseif n=10 then
					acadOct4P=acad4persona(0,l)+acad4persona(1,l)+acad4persona(2,l)+acad4persona(3,l)+acad4persona(4,l)+acad4persona(5,l)+acad4persona(6,l)+acad4persona(7,l)
               elseif n=11 then
					acadNov4P=acad4persona(0,l)+acad4persona(1,l)+acad4persona(2,l)+acad4persona(3,l)+acad4persona(4,l)+acad4persona(5,l)+acad4persona(6,l)+acad4persona(7,l)
               elseif n=12 then
					acadDic4P=acad4persona(0,l)+acad4persona(1,l)+acad4persona(2,l)+acad4persona(3,l)+acad4persona(4,l)+acad4persona(5,l)+acad4persona(6,l)+acad4persona(7,l)
               end if
			else
			  acadEne4P  =0
           acadFeb4P  =0
           acadMar4P  =0
           acadAbr4P  =0
           acadMay4P  =0  
           acadJun4P  =0
           acadJul4P  =0
           acadAgo4P  =0
           acadSep4P  =0 
           acadOct4P  =0 
           acadNov4P  =0 
           acadDic4P  =0
 
			end if
   		Next 
      'Termina consulta 4 personas academia por mes

      'se consulta el número de clases particulares por mes
       
'capturo todas las clases PARTICULAR  persona por meses 
      for h=1 to 12
                   consclaPartmeses="select "&_
                                     "(select count(*) from agenda where tipo_servicio=5 and estado=1 and month(fecha_renta) =1  and year(fecha_renta)='"&anio&"' and numero_personas='"&h&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=5 and estado=1 and month(fecha_renta) =2  and year(fecha_renta)='"&anio&"' and numero_personas='"&h&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=5 and estado=1 and month(fecha_renta) =3  and year(fecha_renta)='"&anio&"' and numero_personas='"&h&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=5 and estado=1 and month(fecha_renta) =4  and year(fecha_renta)='"&anio&"' and numero_personas='"&h&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=5 and estado=1 and month(fecha_renta) =5  and year(fecha_renta)='"&anio&"' and numero_personas='"&h&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=5 and estado=1 and month(fecha_renta) =6  and year(fecha_renta)='"&anio&"' and numero_personas='"&h&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=5 and estado=1 and month(fecha_renta) =7  and year(fecha_renta)='"&anio&"' and numero_personas='"&h&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=5 and estado=1 and month(fecha_renta) =8  and year(fecha_renta)='"&anio&"' and numero_personas='"&h&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=5 and estado=1 and month(fecha_renta) =9  and year(fecha_renta)='"&anio&"' and numero_personas='"&h&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=5 and estado=1 and month(fecha_renta) =10 and year(fecha_renta)='"&anio&"' and numero_personas='"&h&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=5 and estado=1 and month(fecha_renta) =11 and year(fecha_renta)='"&anio&"' and numero_personas='"&h&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=5 and estado=1 and month(fecha_renta) =12 and year(fecha_renta)='"&anio&"' and numero_personas='"&h&"')"
         claspartmeses=executee(consclaPartmeses,dominio)

         if not IsEmpty(claspartmeses) then
               if h=1  then 
                     part1Ene = claspartmeses(0,l)
                     part1Feb = claspartmeses(1,l)
                     part1Mar = claspartmeses(2,l)
                     part1Abr = claspartmeses(3,l)
                     part1May = claspartmeses(4,l)
                     part1Jun = claspartmeses(5,l)
                     part1Jul = claspartmeses(6,l)
                     part1Ago = claspartmeses(7,l)
                     part1Sep = claspartmeses(8,l)
                     part1Oct = claspartmeses(9,l)
                     part1Nov = claspartmeses(10,l)
                     part1Dic = claspartmeses(11,l)
                elseif h=2  then 
                     part2Ene = claspartmeses(0,l)
                     part2Feb = claspartmeses(1,l)
                     part2Mar = claspartmeses(2,l)
                     part2Abr = claspartmeses(3,l)
                     part2May = claspartmeses(4,l)
                     part2Jun = claspartmeses(5,l)
                     part2Jul = claspartmeses(6,l)
                     part2Ago = claspartmeses(7,l)
                     part2Sep = claspartmeses(8,l)
                     part2Oct = claspartmeses(9,l)
                     part2Nov = claspartmeses(10,l)
                     part2Dic = claspartmeses(11,l)
                elseif h=3  then 
                     part3Ene = claspartmeses(0,l)
                     part3Feb = claspartmeses(1,l)
                     part3Mar = claspartmeses(2,l)
                     part3Abr = claspartmeses(3,l)
                     part3May = claspartmeses(4,l)
                     part3Jun = claspartmeses(5,l)
                     part3Jul = claspartmeses(6,l)
                     part3Ago = claspartmeses(7,l)
                     part3Sep = claspartmeses(8,l)
                     part3Oct = claspartmeses(9,l)
                     part3Nov = claspartmeses(10,l)
                     part3Dic = claspartmeses(11,l)
                elseif h=4  then 
                     part4Ene = claspartmeses(0,l)
                     part4Feb = claspartmeses(1,l)
                     part4Mar = claspartmeses(2,l)
                     part4Abr = claspartmeses(3,l)
                     part4May = claspartmeses(4,l)
                     part4Jun = claspartmeses(5,l)
                     part4Jul = claspartmeses(6,l)
                     part4Ago = claspartmeses(7,l)
                     part4Sep = claspartmeses(8,l)
                     part4Oct = claspartmeses(9,l)
                     part4Nov = claspartmeses(10,l)
                     part4Dic = claspartmeses(11,l)
                end if 
            else 
            part1Ene, part2Ene, part3Ene, part4Ene = 0
            part1Feb, part2Feb, part3Feb, part4Feb = 0
            part1Mar, part1Mar, part1Mar, part1Mar = 0
            part1Abr, part2Abr, part3Abr, part4Abr = 0
            part1May, part2May, part3May, part4May = 0
            part1Jun, part2Jun, part3Jun, part4Jun = 0
            part1Jul, part2Jul, part3Jul, part4Jul = 0
            part1Ago, part2Ago, part3Ago, part4Ago = 0
            part1Sep, part2Sep, part3Sep, part4Sep = 0
            part1Oct, part2Oct, part3Oct, part4Oct = 0
            part1Nov, part2Nov, part3Nov, part4Nov = 0
            part1Dic, part2Dic, part3Dic, part4Dic = 0
         end if
      next
'/////////////////
'capturo todas las clases GRUPALES  persona por meses 
      for o=1 to 12
                   consclaGrumeses="select "&_
                                     "(select count(*) from agenda where tipo_servicio=4 and estado=1 and month(fecha_renta) =1  and year(fecha_renta)='"&anio&"' and numero_personas='"&o&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=4 and estado=1 and month(fecha_renta) =2  and year(fecha_renta)='"&anio&"' and numero_personas='"&o&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=4 and estado=1 and month(fecha_renta) =3  and year(fecha_renta)='"&anio&"' and numero_personas='"&o&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=4 and estado=1 and month(fecha_renta) =4  and year(fecha_renta)='"&anio&"' and numero_personas='"&o&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=4 and estado=1 and month(fecha_renta) =5  and year(fecha_renta)='"&anio&"' and numero_personas='"&o&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=4 and estado=1 and month(fecha_renta) =6  and year(fecha_renta)='"&anio&"' and numero_personas='"&o&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=4 and estado=1 and month(fecha_renta) =7  and year(fecha_renta)='"&anio&"' and numero_personas='"&o&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=4 and estado=1 and month(fecha_renta) =8  and year(fecha_renta)='"&anio&"' and numero_personas='"&o&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=4 and estado=1 and month(fecha_renta) =9  and year(fecha_renta)='"&anio&"' and numero_personas='"&o&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=4 and estado=1 and month(fecha_renta) =10 and year(fecha_renta)='"&anio&"' and numero_personas='"&o&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=4 and estado=1 and month(fecha_renta) =11 and year(fecha_renta)='"&anio&"' and numero_personas='"&o&"'),"&_
                                     "(select count(*) from agenda where tipo_servicio=4 and estado=1 and month(fecha_renta) =12 and year(fecha_renta)='"&anio&"' and numero_personas='"&o&"')"
         clasGrumeses=executee(consclaGrumeses,dominio)

         if not IsEmpty(clasGrumeses) then
               if o=1  then 
                     Gru1Ene = clasGrumeses(0,l)
                     Gru1Feb = clasGrumeses(1,l)
                     Gru1Mar = clasGrumeses(2,l)
                     Gru1Abr = clasGrumeses(3,l)
                     Gru1May = clasGrumeses(4,l)
                     Gru1Jun = clasGrumeses(5,l)
                     Gru1Jul = clasGrumeses(6,l)
                     Gru1Ago = clasGrumeses(7,l)
                     Gru1Sep = clasGrumeses(8,l)
                     Gru1Oct = clasGrumeses(9,l)
                     Gru1Nov = clasGrumeses(10,l)
                     Gru1Dic = clasGrumeses(11,l)
                elseif o=2  then 
                     Gru2Ene = clasGrumeses(0,l)
                     Gru2Feb = clasGrumeses(1,l)
                     Gru2Mar = clasGrumeses(2,l)
                     Gru2Abr = clasGrumeses(3,l)
                     Gru2May = clasGrumeses(4,l)
                     Gru2Jun = clasGrumeses(5,l)
                     Gru2Jul = clasGrumeses(6,l)
                     Gru2Ago = clasGrumeses(7,l)
                     Gru2Sep = clasGrumeses(8,l)
                     Gru2Oct = clasGrumeses(9,l)
                     Gru2Nov = clasGrumeses(10,l)
                     Gru2Dic = clasGrumeses(11,l)
                elseif o=3  then 
                     Gru3Ene = clasGrumeses(0,l)
                     Gru3Feb = clasGrumeses(1,l)
                     Gru3Mar = clasGrumeses(2,l)
                     Gru3Abr = clasGrumeses(3,l)
                     Gru3May = clasGrumeses(4,l)
                     Gru3Jun = clasGrumeses(5,l)
                     Gru3Jul = clasGrumeses(6,l)
                     Gru3Ago = clasGrumeses(7,l)
                     Gru3Sep = clasGrumeses(8,l)
                     Gru3Oct = clasGrumeses(9,l)
                     Gru3Nov = clasGrumeses(10,l)
                     Gru3Dic = clasGrumeses(11,l)
                elseif o=4  then 
                     Gru4Ene = clasGrumeses(0,l)
                     Gru4Feb = clasGrumeses(1,l)
                     Gru4Mar = clasGrumeses(2,l)
                     Gru4Abr = clasGrumeses(3,l)
                     Gru4May = clasGrumeses(4,l)
                     Gru4Jun = clasGrumeses(5,l)
                     Gru4Jul = clasGrumeses(6,l)
                     Gru4Ago = clasGrumeses(7,l)
                     Gru4Sep = clasGrumeses(8,l)
                     Gru4Oct = clasGrumeses(9,l)
                     Gru4Nov = clasGrumeses(10,l)
                     Gru4Dic = clasGrumeses(11,l)
                end if 
            else 
            Gru1Ene, Gru2Ene, Gru3Ene, Gru4Ene = 0
            Gru1Feb, Gru2Feb, Gru3Feb, Gru4Feb = 0
            Gru1Mar, Gru1Mar, Gru1Mar, Gru1Mar = 0
            Gru1Abr, Gru2Abr, Gru3Abr, Gru4Abr = 0
            Gru1May, Gru2May, Gru3May, Gru4May = 0
            Gru1Jun, Gru2Jun, Gru3Jun, Gru4Jun = 0
            Gru1Jul, Gru2Jul, Gru3Jul, Gru4Jul = 0
            Gru1Ago, Gru2Ago, Gru3Ago, Gru4Ago = 0
            Gru1Sep, Gru2Sep, Gru3Sep, Gru4Sep = 0
            Gru1Oct, Gru2Oct, Gru3Oct, Gru4Oct = 0
            Gru1Nov, Gru2Nov, Gru3Nov, Gru4Nov = 0
            Gru1Dic, Gru2Dic, Gru3Dic, Gru4Dic = 0
         end if
      next

'consulta del pago de profesor PARTICULAR por # personas
costopartcons="select "&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=5 and numero_personas=1),"&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=5 and numero_personas=2),"&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=5 and numero_personas=3),"&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=5 and numero_personas=4)"
'consulta de pago profesor clase GRUPAL por # de personas
consultacostogrupal="select "&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=4 and numero_personas=2),"&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=4 and numero_personas=3),"&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=4 and numero_personas=4)"
'se ejecuta consulta pago profesor clase GRUPAL por # de personas

'Consulta pago profesor para ACADEMIA por # personas
consultaacademiapago="select "&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=3 and numero_personas=1),"&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=3 and numero_personas=2),"&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=3 and numero_personas=3),"&_
                        "(select pago_a_profesor from admin_pago_profesor where id_tipo_servicio=3 and numero_personas=4)"

'consultamos el precio mensual de la acdemia
      consCostAcad="select"&_
	                "(select costo_hora from  admin_tipoServicio where id=3) as costoacademia"
      costAcad=executee(consCostAcad,dominio)
 'consultamos el precio de pago a profesor por clase particular y número de personas
   'calculamos las tarifas de las academias por diferente tipo de personas
      costo1personaAcad=costAcad(0,l)/8
      costo2personaAcad=costo1personaAcad*2
      costo3personaAcad=costo1personaAcad*3
      costo4personaAcad=costo1personaAcad*4

'consultamos el pago de profesor por tipo particular y numero de personas
costopart=executee(costopartcons,dominio)
      if not IsEmpty(costopart) then          
         precio1part=costopart(0,l)
         precio2part=costopart(1,l)
         precio3part=costopart(2,l)
         precio4part=costopart(3,l)
       else
       precio1part=0
       precio2part=0
       precio3part=0
       precio4part=0
       end if

'consulta pago a profesor para clases grupals por numero de personas
costogrupal=executee(consultacostogrupal,dominio)
      if not IsEmpty(costogrupal) then 
         precio2grup=costogrupal(0,l)
         precio3grup=costogrupal(1,l)
         precio4grup=costogrupal(2,l)
      else
      precio2grup=0
      precio3grup=0
      precio4grup=0
      end if
'consulta de pago de profesor para clases de academia por numero de personas
pagoprofeacademia=executee(consultaacademiapago,dominio)
    if not IsEmpty(pagoprofeacademia) then          
         pago1aca=pagoprofeacademia(0,l)
         pago2aca=pagoprofeacademia(1,l)
         pago3aca=pagoprofeacademia(2,l)
         pago4aca=pagoprofeacademia(3,l)
       else
         pago1aca=0
         pago2aca=0
         pago3aca=0
         pago4aca=0
   end if

   'calculamos los ingresos de la academia por mes en global
         ingAcadEne= CDbl((acadEne1P*costo1personaAcad)+(acadEne2P*costo2personaAcad)+(acadEne3P*costo3personaAcad)+(acadEne4P*costo4personaAcad))
         ingAcadFeb= CDbl((acadFeb1P*costo1personaAcad)+(acadFeb2P*costo2personaAcad)+(acadFeb3P*costo3personaAcad)+(acadFeb4P*costo4personaAcad))
         ingAcadMar= CDbl((acadMar1P*costo1personaAcad)+(acadMar2P*costo2personaAcad)+(acadMar3P*costo3personaAcad)+(acadMar4P*costo4personaAcad))
         ingAcadAbr= CDbl((acadAbr1P*costo1personaAcad)+(acadAbr2P*costo2personaAcad)+(acadAbr3P*costo3personaAcad)+(acadAbr4P*costo4personaAcad))
         ingAcadMay= CDbl((acadMay1P*costo1personaAcad)+(acadMay2P*costo2personaAcad)+(acadMay3P*costo3personaAcad)+(acadMay4P*costo4personaAcad))
         ingAcadJun= CDbl((acadJun1P*costo1personaAcad)+(acadJun2P*costo2personaAcad)+(acadJun3P*costo3personaAcad)+(acadJun4P*costo4personaAcad))
         ingAcadJul= CDbl((acadJul1P*costo1personaAcad)+(acadJul2P*costo2personaAcad)+(acadJul3P*costo3personaAcad)+(acadJul4P*costo4personaAcad))
         ingAcadAgo= CDbl((acadAgo1P*costo1personaAcad)+(acadAgo2P*costo2personaAcad)+(acadAgo3P*costo3personaAcad)+(acadAgo4P*costo4personaAcad))
         ingAcadSep= CDbl((acadSep1P*costo1personaAcad)+(acadSep2P*costo2personaAcad)+(acadSep3P*costo3personaAcad)+(acadSep4P*costo4personaAcad))
         ingAcadOct= CDbl((acadOct1P*costo1personaAcad)+(acadOct2P*costo2personaAcad)+(acadOct3P*costo3personaAcad)+(acadOct4P*costo4personaAcad))
         ingAcadNov= CDbl((acadNov1P*costo1personaAcad)+(acadNov2P*costo2personaAcad)+(acadNov3P*costo3personaAcad)+(acadNov4P*costo4personaAcad))
         ingAcadDic= CDbl((acadDic1P*costo1personaAcad)+(acadDic2P*costo2personaAcad)+(acadDic3P*costo3personaAcad)+(acadDic4P*costo4personaAcad))

      'empieza consulta de todal de rentas por mes en el año sin academia
      rentasmessinacademia= executee(consrentassinacademia,dominio)
      if not IsEmpty(rentasmessinacademia) then 
         subrentasEne   = rentasmessinacademia(0,l)
         subrentasFeb   = rentasmessinacademia(1,l)
         subrentasMar   = rentasmessinacademia(2,l)
         subrentasAbr   = rentasmessinacademia(3,l)
         subrentasMay   = rentasmessinacademia(4,l)
         subrentasJun   = rentasmessinacademia(5,l)
         subrentasJul   = rentasmessinacademia(6,l)
         subrentaseAgo  = rentasmessinacademia(7,l)
         subrentaseSep  = rentasmessinacademia(8,l)
         subrentasOct   = rentasmessinacademia(9,l)
         subrentasNov   = rentasmessinacademia(10,l)
         subrentasDic   = rentasmessinacademia(11,l)
         else
         subrentasEne   = 0
         subrentasFeb   = 0
         subrentasMar   = 0
         subrentasAbr   = 0
         subrentasMay   = 0
         subrentasJun   = 0
         subrentasJul   = 0
         subrentaseAgo  = 0
         subrentaseSep  = 0
         subrentasOct   = 0
         subrentasNov   = 0
         subrentasDic   = 0
      end if

   descuentosmes= executee(consdescuentosmes,dominio)
      if not IsEmpty(descuentosmes) then
         'variables descuentos por mes
         descuentoEnero = descuentosmes(0,l)
         descuentoFebrero = descuentosmes(1,l)
         descuentoMarzo = descuentosmes(2,l)
         descuentoAbril = descuentosmes(3,l)
         descuentoMayo = descuentosmes(4,l)
         descuentoJunio = descuentosmes(5,l)
         descuentoJulio = descuentosmes(6,l)
         descuentoAgosto = descuentosmes(7,l)
         descuentoSept = descuentosmes(8,l)
         descuentoOctubre = descuentosmes(9,l)
         descuentoNoviembre = descuentosmes(10,l)
         descuentoDiciembre = descuentosmes(11,l)
     else 
      'variables descuentos por mes
       descuentoEnero = 0
       descuentoFebrero = 0
       descuentoMarzo = 0
       descuentoAbril = 0
       descuentoMayo = 0
       descuentoJunio = 0
       descuentoJulio = 0
       descuentoAgosto = 0
       descuentoSept = 0
       descuentoOctubre = 0
       descuentoNoviembre = 0
       descuentoDiciembre = 0
       end if

   egresosmes=executee(consegresosmeses,dominio)
   if not IsEmpty(egresosmes) then 
      '//variablesegresos de meses
       egreOperaEnero   = egresosmes(0,l)
       egreOperaFebrero = egresosmes(1,l)
       egreOperaMarzo   = egresosmes(2,l)
       egreOperaAbril   = egresosmes(3,l)
       egreOperaMayo    = egresosmes(4,l)
       egreOperaJunio   = egresosmes(5,l)
       egreOperaJulio   = egresosmes(6,l)
       egreOperaAgosto  = egresosmes(7,l)
       egreOperaSept    = egresosmes(8,l)
       egreOperaOctubre = egresosmes(9,l)
       egreOperaNoviembre = egresosmes(10,l)
       egreOperaDiciembre = egresosmes(11,l)
   else 
       egreOperaEnero=0
       egreOperaFebrero=0
       egreOperaMarzo=0
       egreOperaAbril=0
       egreOperaMayo=0
       egreOperaJunio=0
       egreOperaJulio=0
       egreOperaAgosto=0
       egreOperaSept=0
       egreOperaOctubre=0
       egreOperaNoviembre=0
       egreOperaDiciembre=0
   end if


   ventameses=executee(consventasmeses,dominio)
      if not IsEmpty(ventameses) then 
         ingreVentaEnero = ventameses(0,l)
         ingreVentaFebrero = ventameses(1,l)
         ingreVentaMarzo = ventameses(2,l)
         ingreVentaAbril = ventameses(3,l)
         ingreVentaMayo = ventameses(4,l)
         ingreVentaJunio = ventameses(5,l)
         ingreVentaJulio = ventameses(6,l)
         ingreVentaAgosto = ventameses(7,l)
         ingreVentaSept = ventameses(8,l)
         ingreVentaOctubre = ventameses(9,l)
         ingreVentaNoviembre = ventameses(10,l)
         ingreVentaDiciembre = ventameses(11,l)
     else 
         ingreVentaEnero=0
         ingreVentaFebrero=0
         ingreVentaMarzo=0
         ingreVentaAbril=0
         ingreVentaMayo=0
         ingreVentaJunio=0
         ingreVentaJulio=0
         ingreVentaAgosto=0
         ingreVentaSept=0
         ingreVentaOctubre=0
         ingreVentaNoviembre=0
         ingreVentaDiciembre=0
      end if


'//variable rentas de meses
       rentaEnero     = CDbl(subrentasEne + ingAcadEne)
       rentaFebrero   = CDbl(subrentasFeb + ingAcadFeb)
       rentaMarzo     = CDbl(subrentasMar + ingAcadMar)
       rentaAbril     = CDbl(subrentasAbr + ingAcadAbr)
       rentaMayo      = CDbl(subrentasMay + ingAcadMay)
       rentaJunio     = CDbl(subrentasJun + ingAcadJun)
       rentaJulio     = CDbl(subrentasJul + ingAcadJul)
       rentaAgosto    = CDbl(subrentaseAgo  + ingAcadAgo)
       rentaSept      = CDbl(subrentaseSep + ingAcadSep)
       rentaOctubre   = CDbl(subrentasOct + ingAcadOct)
       rentaNoviembre = CDbl(subrentasNov + ingAcadNov)
       rentaDiciembre = CDbl(subrentasDic + ingAcadDic)
 
       'variables maestros por mes
       'calculamos el egreso por tipo de servicio PARTICULAR
       egresparticularEne = CDbl((part1Ene*precio1part)+(part2Ene*precio2part)+(part3Ene*precio3part)+(part4Ene*precio4part))
       egresparticularFeb = CDbl((part1Feb*precio1part)+(part2Feb*precio2part)+(part3Feb*precio3part)+(part4Feb*precio4part))
       egresparticularMar = CDbl((part1Mar*precio1part)+(part2Mar*precio2part)+(part3Mar*precio3part)+(part4Mar*precio4part))
       egresparticularAbr = CDbl((part1Abr*precio1part)+(part2Abr*precio2part)+(part3Abr*precio3part)+(part4Abr*precio4part))
       egresparticularMay = CDbl((part1May*precio1part)+(part2May*precio2part)+(part3May*precio3part)+(part4May*precio4part))
       egresparticularJun = CDbl((part1Jun*precio1part)+(part2Jun*precio2part)+(part3Jun*precio3part)+(part4Jun*precio4part))
       egresparticularJul = CDbl((part1Jul*precio1part)+(part2Jul*precio2part)+(part3Jul*precio3part)+(part4Jul*precio4part))
       egresparticularAgo = CDbl((part1Ago*precio1part)+(part2Ago*precio2part)+(part3Ago*precio3part)+(part4Ago*precio4part))
       egresparticularSep = CDbl((part1Sep*precio1part)+(part2Sep*precio2part)+(part3Sep*precio3part)+(part4Sep*precio4part))
       egresparticularOct = CDbl((part1Oct*precio1part)+(part2Oct*precio2part)+(part3Oct*precio3part)+(part4Oct*precio4part))
       egresparticularNov = CDbl((part1Nov*precio1part)+(part2Nov*precio2part)+(part3Nov*precio3part)+(part4Nov*precio4part))
       egresparticularDic = CDbl((part1Dic*precio1part)+(part2Dic*precio2part)+(part3Dic*precio3part)+(part4Dic*precio4part))
            'calculamos el egreso por tipo de servicio GRUPAL
       egresgrupalEne = CDbl((Gru2Ene*precio2grup)+(Gru3Ene*precio3grup)+(Gru4Ene*precio4grup))
       egresgrupalFeb = CDbl((Gru2Feb*precio2grup)+(Gru3Feb*precio3grup)+(Gru4Feb*precio4grup))
       egresgrupalMar = CDbl((Gru2Mar*precio2grup)+(Gru3Mar*precio3grup)+(Gru4Mar*precio4grup))
       egresgrupalAbr = CDbl((Gru2Abr*precio2grup)+(Gru3Abr*precio3grup)+(Gru4Abr*precio4grup))
       egresgrupalMay = CDbl((Gru2May*precio2grup)+(Gru3May*precio3grup)+(Gru4May*precio4grup))
       egresgrupalJun = CDbl((Gru2Jun*precio2grup)+(Gru3Jun*precio3grup)+(Gru4Jun*precio4grup))
       egresgrupalJul = CDbl((Gru2Jul*precio2grup)+(Gru3Jul*precio3grup)+(Gru4Jul*precio4grup))
       egresgrupalAgo = CDbl((Gru2Ago*precio2grup)+(Gru3Ago*precio3grup)+(Gru4Ago*precio4grup))
       egresgrupalSep = CDbl((Gru2Sep*precio2grup)+(Gru3Sep*precio3grup)+(Gru4Sep*precio4grup))
       egresgrupalOct = CDbl((Gru2Oct*precio2grup)+(Gru3Oct*precio3grup)+(Gru4Oct*precio4grup))
       egresgrupalNov = CDbl((Gru2Nov*precio2grup)+(Gru3Nov*precio3grup)+(Gru4Nov*precio4grup))
       egresgrupalDic = CDbl((Gru2Dic*precio2grup)+(Gru3Dic*precio3grup)+(Gru4Dic*precio4grup))

              'calculamos el egreso por tipo de servicio ACADEMIA
       egresAcaEne = CDbl((acadEne1P*pago1aca)+(acadEne2P*pago2aca)+(acadEne3P*pago3aca)+(acadEne4P*pago4aca))
       egresAcaFeb = CDbl((acadFeb1P*pago1aca)+(acadFeb2P*pago2aca)+(acadFeb3P*pago3aca)+(acadFeb4P*pago4aca))
       egresAcaMar = CDbl((acadMar1P*pago1aca)+(acadMar2P*pago2aca)+(acadMar3P*pago3aca)+(acadMar4P*pago4aca))
       egresAcaAbr = CDbl((acadAbr1P*pago1aca)+(acadAbr2P*pago2aca)+(acadAbr3P*pago3aca)+(acadAbr4P*pago4aca))
       egresAcaMay = CDbl((acadMay1P*pago1aca)+(acadMay2P*pago2aca)+(acadMay3P*pago3aca)+(acadMay4P*pago4aca))
       egresAcaJun = CDbl((acadJun1P*pago1aca)+(acadJun2P*pago2aca)+(acadJun3P*pago3aca)+(acadJun4P*pago4aca))
       egresAcaJul = CDbl((acadJul1P*pago1aca)+(acadJul2P*pago2aca)+(acadJul3P*pago3aca)+(acadJul4P*pago4aca))
       egresAcaAgo = CDbl((acadAgo1P*pago1aca)+(acadAgo2P*pago2aca)+(acadAgo3P*pago3aca)+(acadAgo4P*pago4aca))
       egresAcaSep = CDbl((acadSep1P*pago1aca)+(acadSep2P*pago2aca)+(acadSep3P*pago3aca)+(acadSep4P*pago4aca))
       egresAcaOct = CDbl((acadOct1P*pago1aca)+(acadOct2P*pago2aca)+(acadOct3P*pago3aca)+(acadOct4P*pago4aca))
       egresAcaNov = CDbl((acadNov1P*pago1aca)+(acadNov2P*pago2aca)+(acadNov3P*pago3aca)+(acadNov4P*pago4aca))
       egresAcaDic = CDbl((acadDic1P*pago1aca)+(acadDic2P*pago2aca)+(acadDic3P*pago3aca)+(acadDic4P*pago4aca))

       egresoEneroMaestros= CDbl(egresparticularEne+egresgrupalEne+egresAcaEne)
       egresoFebreroMaestros= CDbl(egresparticularFeb+egresgrupalFeb+egresAcaFeb)
       egresoMarzoMaestros= CDbl(egresparticularMar+egresgrupalMar+egresAcaMar)
       egresoAbrilMaestros= CDbl(egresparticularAbr+egresgrupalAbr+egresAcaAbr)
       egresoMayoMaestros= CDbl(egresparticularMay+egresgrupalMay+egresAcaMay)
       egresoJunioMaestros= CDbl(egresparticularJun+egresgrupalJun+egresAcaJun)
       egresoJulioMaestros= CDbl(egresparticularJul+egresgrupalJul+egresAcaJul)
       egresoAgosMaestros= CDbl(egresparticularAgo+egresgrupalAgo+egresAcaAgo)
       egresoSeptMaestros= CDbl(egresparticularSep+egresgrupalSep+egresAcaSep)
       egresoOctMaestros= CDbl(egresparticularOct+egresgrupalOct+egresAcaOct)
       egresoNovMaestros= CDbl(egresparticularNov+egresgrupalNov+egresAcaNov)
       egresoDicMaestros= CDbl(egresparticularDic+egresgrupalDic+egresAcaDic)
       

       balanceEnero    = CDbl((rentaEnero+ingreVentaEnero)-(egreOperaEnero+egresoEneroMaestros))
       balanceFebrero  = CDbl((rentaFebrero+ingreVentaFebrero)-(egreOperaFebrero+egresoFebreroMaestros))
       balanceMarzo    = CDbl((rentaMarzo+ingreVentaMarzo)-(egreOperaMarzo+egresoMarzoMaestros))
       balanceAbril    = CDbl((rentaAbril+ingreVentaAbril)-(egreOperaAbril+egresoAbrilMaestros))
       balanceMayo     = CDbl((rentaMayo+ingreVentaMayo)-(egreOperaMayo+egresoMayoMaestros))
       balanceJunio    = CDbl((rentaJunio+ingreVentaJunio)-(egreOperaJunio+egresoJunioMaestros))
       balanceJulio    = CDbl((rentaJulio+ingreVentaJulio)-(egreOperaJulio+egresoJulioMaestros))
       balanceAgosto   = CDbl((rentaAgosto+ingreVentaAgosto)-(egreOperaAgosto+egresoAgosMaestros))
       balanceSept     = CDbl((rentaSept+ingreVentaSept)-(egreOperaSept+egresoSeptMaestros))
       balanceOctu     = CDbl((rentaOctubre+ingreVentaOctubre)-(egreOperaOctubre+egresoOctMaestros))
       balanceNov      = CDbl((rentaNoviembre+ingreVentaNoviembre)-(egreOperaNoviembre+egresoNovMaestros))
       balanceDic      = CDbl((rentaDiciembre+ingreVentaDiciembre)-(egreOperaDiciembre+egresoDicMaestros))


          info = info & "{'mes':'Enero','ingreso_cancha':'"&formatcurrency(rentaEnero,2)&"','ingreso_total':'"&formatcurrency(ingreVentaEnero,2)&"','egreso_total':'"&formatcurrency(egreOperaEnero,2)&"','egreso_maestros':'"&formatcurrency(egresoEneroMaestros,2)&"','balance':'"&formatcurrency(balanceEnero,2)&"', 'balance1':'"&balanceEnero&"', 'descuento':'"&formatcurrency(descuentoEnero,2)&"'}, {'mes':'Febrero','ingreso_cancha':'"&formatcurrency(rentaFebrero,2)&"','ingreso_total':'"&formatcurrency(ingreVentaFebrero,2)&"','egreso_total':'"&formatcurrency(egreOperaFebrero,2)&"','egreso_maestros':'"&formatcurrency(egresoFebreroMaestros,2)&"','balance':'"&formatcurrency(balanceFebrero,2)&"', 'balance1':'"&balanceFebrero&"', 'descuento':'"&formatcurrency(descuentoFebrero,2)&"'},{'mes':'Marzo','ingreso_cancha':'"&formatcurrency(rentaMarzo,2)&"','ingreso_total':'"&formatcurrency(ingreVentaMarzo,2)&"','egreso_total':'"&formatcurrency(egreOperaMarzo,2)&"','egreso_maestros':'"&formatcurrency(egresoMarzoMaestros,2)&"','balance':'"&formatcurrency(balanceMarzo,,,-1)&"', 'balance1':'"&balanceMarzo&"', 'descuento':'"&formatcurrency(descuentoMarzo,2)&"'},{'mes':'Abril','ingreso_cancha':'"&formatcurrency(rentaAbril,2)&"','ingreso_total':'"&formatcurrency(ingreVentaAbril,2)&"','egreso_total':'"&formatcurrency(egreOperaAbril,2)&"','egreso_maestros':'"&formatcurrency(egresoAbrilMaestros,2)&"','balance':'"&formatcurrency(balanceAbril,2)&"', 'balance1':'"&balanceAbril&"', 'descuento':'"&formatcurrency(descuentoAbril,2)&"'},{'mes':'Mayo','ingreso_cancha':'"&formatcurrency(rentaMayo,2)&"','ingreso_total':'"&formatcurrency(ingreVentaMayo,2)&"','egreso_total':'"&formatcurrency(egreOperaMayo,2)&"','egreso_maestros':'"&formatcurrency(egresoMayoMaestros,2)&"','balance':'"&formatcurrency(balanceMayo,2)&"', 'balance1':'"&balanceMayo&"', 'descuento':'"&formatcurrency(descuentoMayo,2)&"'},{'mes':'Junio','ingreso_cancha':'"&formatcurrency(rentaJunio,2)&"','ingreso_total':'"&formatcurrency(ingreVentaJunio,2)&"','egreso_total':'"&formatcurrency(egreOperaJunio,2)&"','egreso_maestros':'"&formatcurrency(egresoJunioMaestros,2)&"','balance':'"&formatcurrency(balanceJunio,2)&"', 'balance1':'"&balanceJunio&"', 'descuento':'"&formatcurrency(descuentoJunio,2)&"'},{'mes':'Julio','ingreso_cancha':'"&formatcurrency(rentaJulio,2)&"','ingreso_total':'"&formatcurrency(ingreVentaJulio,2)&"','egreso_total':'"&formatcurrency(egreOperaJulio,2)&"','egreso_maestros':'"&formatcurrency(egresoJulioMaestros,2)&"','balance':'"&formatcurrency(balanceJulio,2)&"', 'balance1':'"&balanceJulio&"', 'descuento':'"&formatcurrency(descuentoJulio,2)&"'},{'mes':'Agosto','ingreso_cancha':'"&formatcurrency(rentaAgosto,2)&"','ingreso_total':'"&formatcurrency(ingreVentaAgosto,2)&"','egreso_total':'"&formatcurrency(egreOperaAgosto,2)&"','egreso_maestros':'"&formatcurrency(egresoAgosMaestros,2)&"','balance':'"&formatcurrency(balanceAgosto,2)&"', 'balance1':'"&balanceAgosto&"', 'descuento':'"&formatcurrency(descuentoAgosto,2)&"'},{'mes':'Semptiembre','ingreso_cancha':'"&formatcurrency(rentaSept,2)&"','ingreso_total':'"&formatcurrency(ingreVentaSept,2)&"','egreso_total':'"&formatcurrency(egreOperaSept,2)&"','egreso_maestros':'"&formatcurrency(egresoSeptMaestros,2)&"','balance':'"&formatcurrency(balanceSept,2)&"', 'balance1':'"&balanceSept&"', 'descuento':'"&formatcurrency(descuentoSept,2)&"'},{'mes':'Octubre','ingreso_cancha':'"&formatcurrency(rentaOctubre,2)&"','ingreso_total':'"&formatcurrency(ingreVentaOctubre,2)&"','egreso_total':'"&formatcurrency(egreOperaOctubre,2)&"','egreso_maestros':'"&formatcurrency(egresoOctMaestros,2)&"','balance':'"&formatcurrency(balanceOctu,2)&"', 'balance1':'"&balanceOctu&"', 'descuento':'"&formatcurrency(descuentoOctubre,2)&"'},{'mes':'Nomviembre','ingreso_cancha':'"&formatcurrency(rentaNoviembre,2)&"','ingreso_total':'"&formatcurrency(ingreVentaNoviembre,2)&"','egreso_total':'"&formatcurrency(egreOperaNoviembre,2)&"','egreso_maestros':'"&formatcurrency(egresoNovMaestros,2)&"','balance':'"&formatcurrency(balanceNov,2)&"', 'balance1':'"&balanceNov&"', 'descuento':'"&formatcurrency(descuentoNoviembre,2)&"'},{'mes':'Diciembre','ingreso_cancha':'"&formatcurrency(rentaDiciembre,2)&"','ingreso_total':'"&formatcurrency(ingreVentaDiciembre,2)&"','egreso_total':'"&formatcurrency(egreOperaDiciembre,2)&"','egreso_maestros':'"&formatcurrency(egresoDicMaestros,2)&"','balance':'"&formatcurrency(balanceDic,2)&"', 'balance1':'"&balanceDic&"', 'descuento':'"&formatcurrency(descuentoDiciembre,2)&"'},"
          info = left(info, len(info)-1)
    

      if Err.Number <> 0 then
         Response.write(Err.Description)
         Response.End
      end if
      On Error GoTo 0
 end if





'/////////////////////obtener total de agendas del dia con las de academia por separado'
If comm="agendaPordia" Then
  sql4 = " select"&_
            "(select count(id) from agenda where estado =1 and fecha_renta = cast('"&fechaActual&"' as date)) as sinAC,"&_
            "(select COUNT(id) from agenda where tipo_servicio=3 and estado=1 and cast(fecha_reservaC2 as date) = cast('"&fechaActual&"' as date))as ac2,"&_
            "(select COUNT(id) from agenda where tipo_servicio=3 and estado=1 and cast(fecha_reservaC3 as date) = cast('"&fechaActual&"' as date)) as ac3,"&_
            "(select COUNT(id) from agenda where tipo_servicio=3 and estado=1 and cast(fecha_reservaC4 as date) = cast('"&fechaActual&"' as date)) as ac4,"&_
            "(select COUNT(id) from agenda where tipo_servicio=3 and estado=1 and cast(fecha_reservaC5 as date) = cast('"&fechaActual&"' as date)) as ac5,"&_ 
            "(select COUNT(id) from agenda where tipo_servicio=3 and estado=1 and cast(fecha_reservaC6 as date) = cast('"&fechaActual&"' as date)) as ac6,"&_
            "(select COUNT(id) from agenda where tipo_servicio=3 and estado=1 and cast(fecha_reservaC7 as date) = cast('"&fechaActual&"' as date)) as ac7,"&_ 
            "(select COUNT(id) from agenda where tipo_servicio=3 and estado=1 and cast(fecha_reservaC8 as date) = cast('"&fechaActual&"' as date)) as ac8"
 
 
  datos =executee(sql4,dominio)

  if not IsEmpty(datos) then
     sinAC= datos(0,l)
	  ac2= datos(1,l)
     ac3= datos(2,l)
     ac4= datos(3,l)
     ac5= datos(4,l)
     ac6= datos(5,l)
     ac7= datos(6,l)
     ac8= datos(7,l)
     agendadiareal=CInt(sinAC)+CInt(ac2)+CInt(ac3)+CInt(ac4)+CInt(ac5)+CInt(ac6)+CInt(ac7)+CInt(ac8)
    	info ="{'fecha_renta':'"&agendadiareal&"'}"
    end if
end if







'//////////////////////////////////////////////////////////
'obtener total de los Egresos del dia'
If comm="egresosDia" Then
  sql = "select isnull(sum(egreso_total),0)  from admin_egresos where cast(fecha_realizo as date) = cast('"&fechaActual&"' as date) and estatus = 1"
  datos = executee(sql,dominio)
  if not IsEmpty(datos) then
		l = 0
    for l=0 to ubound(datos,2)
    	info = info & "{'egreso_total':'"&formatcurrency(datos(0,l),2)&"'},"
      next
      info = left(info, len(info)-1)
      end if
end if


' listar egresos
if com = "listarEgresos" then
if periodoDesde <> "" and periodoA <> "" then
  ss = " and ( cast(fecha_realizo as date) >= '"&periodoDesde&"' and cast(fecha_realizo as date) <= '"&periodoA&"' )"
else
  ss = ""
end if

	sql = "select id, concepto, descripcion, CONVERT(VARCHAR,fecha_realizo,101), tipo_egreso, frecuencia_egreso, justificacion, responsable, costo_unitario, cantidad_total, egreso_total from admin_egresos where estatus = 1 "&ss&" order by fecha_realizo desc "
	datos = executee(sql,dominio)

	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			tipo_egreso = datos(4,l)
			if tipo_egreso =  1 then
				tipo_egreso = "Fijo"
				'color  = "success"
			elseif tipo_egreso = 2 then
				tipo_egreso = "Variable"
				'color = "primary"
			end if

  		tipo_frecuencia = datos(5,l)
  		if tipo_frecuencia =  1 then
  			 tipo_frecuencia = "Diario"
			elseif tipo_frecuencia = 2 then
  			 tipo_frecuencia = "Semanal"
      elseif tipo_frecuencia = 3 then
    		 tipo_frecuencia = "Quincenal"
      elseif tipo_frecuencia = 4 then
      	 tipo_frecuencia = "Mensual"
      elseif tipo_frecuencia = 5 then
         tipo_frecuencia = "Bimenstral"
      elseif tipo_frecuencia = 6 then
         tipo_frecuencia = "Semestral"
      elseif tipo_frecuencia = 7 then
      	 tipo_frecuencia = "Anual"
      elseif tipo_frecuencia = 8 then
    		 tipo_frecuencia = "Indefinido"
  				'color = "primary"
  			end if

		'	tipo_servicioSPAN = "<span class=//badge badge-pill "&color&"//>"&tipo_servicio&"</span>"

     eliminarRegistro = "<button class=//md-btn md-raised mb-2 w-xs blue// onclick=javascript:eliminarRegistro("&datos(0,l)&")><i class=//fa fa-trash//></i></button>"

			info = info & "{'id':'"&datos(0,l)&"', 'concepto':'"&datos(1,l)&"', 'descripcion':'"&datos(2,l)&"', 'fecha_realizo':'"&datos(3,l)&"', 'tipo_egreso':'"&tipo_egreso&"', 'frecuencia_egreso':'"&tipo_frecuencia&"', 'justificacion':'"&datos(6,l)&"','responsable':'"&datos(7,l)&"', 'costo_unitario':'"&formatcurrency(datos(8,l),2)&"', 'cantidad_total':'"&datos(9,l)&"', 'egreso_total':'"&formatcurrency(datos(10,l),2)&"', 'eliminar': '"&eliminarRegistro&"'},"
		next

		info = left(info, len(info)-1)


	end if

end if


' listar egresos eliminados, historico
if com = "listarEgresosEliminados" then

	sql = "select id, concepto, descripcion, CONVERT(VARCHAR,fecha_realizo,101), tipo_egreso, frecuencia_egreso, justificacion, responsable, costo_unitario, cantidad_total, egreso_total, CONVERT(VARCHAR,fecha_baja,101) from admin_egresos where estatus = 0 order by fecha_realizo desc "
	datos = executee(sql,dominio)

	if not IsEmpty(datos) then
		l = 0
		for l=0 to ubound(datos,2)
			tipo_egreso = datos(4,l)
			if tipo_egreso =  1 then
				tipo_egreso = "Fijo"
				'color  = "success"
			elseif tipo_egreso = 2 then
				tipo_egreso = "Variable"
				'color = "primary"
			end if
      tipo_frecuencia = datos(5,l)
      if tipo_frecuencia =  1 then
         tipo_frecuencia = "Diario"
      elseif tipo_frecuencia = 2 then
         tipo_frecuencia = "Semanal"
      elseif tipo_frecuencia = 3 then
         tipo_frecuencia = "Quincenal"
      elseif tipo_frecuencia = 4 then
         tipo_frecuencia = "Mensual"
      elseif tipo_frecuencia = 5 then
         tipo_frecuencia = "Bimenstral"
      elseif tipo_frecuencia = 6 then
         tipo_frecuencia = "Semestral"
      elseif tipo_frecuencia = 7 then
         tipo_frecuencia = "Anual"
      elseif tipo_frecuencia = 8 then
         tipo_frecuencia = "Indefinido"
          'color = "primary"
        end if
		'	tipo_servicioSPAN = "<span class=//badge badge-pill "&color&"//>"&tipo_servicio&"</span>"

			'eliminarAgenda = "<button class=//md-btn md-raised mb-2 w-xs blue// onclick=javascript:eliminarAgenda("&datos(0,l)&")><i class=//fa fa-trash//></i></button>"

			info = info & "{'id':'"&datos(0,l)&"', 'concepto':'"&datos(1,l)&"', 'descripcion':'"&datos(2,l)&"', 'fecha_realizo':'"&datos(3,l)&"', 'tipo_egreso':'"&tipo_egreso&"', 'frecuencia_egreso':'"&tipo_frecuencia&"', 'justificacion':'"&datos(6,l)&"','responsable':'"&datos(7,l)&"', 'costo_unitario':'"&formatcurrency(datos(8,l),2)&"', 'cantidad_total':'"&datos(9,l)&"', 'egreso_total':'"&formatcurrency(datos(10,l),2)&"','fecha_baja':'"&datos(11,l)&"'},"
		next

		info = left(info, len(info)-1)


	end if

end if

'abre incidencia con envio de notificacion
' if comm = "abrirIncidencia" and idRegistro > 0 then
'     if idRegistro >0 then
' 		'sql = "update "+tabla+" set estado='1', fecha_cierre=getDate() where id="+idRegistro
' 		ActualizarDatos tabla, "estado='0', fecha_cierre='' ", "id='"&idRegistro&"' ", dominio
' 		info = "{'ok':'ok'}"

' 		titulo = "Se abrio incidencia: "&cliente
' 		mensaje = "Se ha abierto la incidencia: "&idRegistro

' 		enviarNotificacion titulo, mensaje, dominio

' 	end if
' end if

respuesta = "{'data':["&info&"]}"
respuesta = Replace(respuesta, "'", chr(34))
respuesta = replace(respuesta,"//","'")
response.Write(respuesta)
%>
