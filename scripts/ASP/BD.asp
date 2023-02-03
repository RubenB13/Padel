<!--#include file="connect.asp"-->
<%
Response.Expires = 0
public function executee(query, cn)
	set rsPregunta = server.CreateObject("ADODB.Recordset")
	rsPregunta.open query, conectate(cn)
	
	if not rsPregunta.eof then
		todosDatos = rsPregunta.getrows 
	end if
	'numrows = ubound(todosDatos,2)
	rsPregunta.Close()
	Set rsPregunta = Nothing
	executee = todosDatos
end function
public function executeeConnection(query, cnE)
	set cn = Server.CreateObject("ADODB.Connection")
	cn.Open conectate(cnE)
	cn.execute query
	cn.Close()
	Set cn = Nothing
end function
public function guardarDatos(table,campos,datos, cnE)
	set cn = Server.CreateObject("ADODB.Connection")
	cn.Open conectate(cnE)
	cn.execute "insert into "&table&" ("&campos&") values ("&datos&") "
	cn.Close()
	Set cn = Nothing
end function
public function ActualizarDatos(base,actua,cuando, cnE)
	set cn = Server.CreateObject("ADODB.Connection")
	cn.Open conectate(cnE)
	

	
	cn.execute "update "&base&" set "&actua&"  where "&cuando
	cn.Close()
	Set cn = Nothing
	ActualizarDatos = "exito"
end function
public function BorrarDatos(base,cuando, cnE)
	set cn = Server.CreateObject("ADODB.Connection")
	cn.Open conectate(cnE)
	cn.execute "delete from "&base&" where "&cuando
	cn.Close()
	Set cn = Nothing
	BorrarDatos = "exito"
end function
public function crearBD(nombre)
	set cn = Server.CreateObject("ADODB.Connection")
	cn.Open conectate("master")
	cn.execute "CREATE DATABASE [" & nombre &"]"
	cn.Close()
	Set cn = Nothing
end function

'Read CSV Files
public function executeeCSV(query)
	set rsPregunta = server.CreateObject("ADODB.Recordset")
	rsPregunta.open query ,session("cnCSV")
	
	if not rsPregunta.eof then
		todosDatos = rsPregunta.getrows 
	end if
	'numrows = ubound(todosDatos,2)
	
	rsPregunta.Close()
	Set rsPregunta = Nothing
	executeeCSV = todosDatos
end function

function conectate(cual)
	select case cual
		case "core":
			conectate = session("cn")
		case "master"
			conectate = session("cnMaster")
		case else:
			conectate = "Provider=SQLOLEDB;Server=sql5109.site4now.net,1433;Database=db_a88f20_bdupadel2022;User ID=db_a88f20_bdupadel2022_admin;Password=upadel777;Trusted_Connection=False;"
			'conectate = "Provider=SQLOLEDB;Server=SQL8001.site4now.net,1433;Database="&cual&";User ID=db_a8638d_bdupadel_admin;Password=upadel777;Trusted_Connection=False;"
			' conectate = "Provider=SQLOLEDB;Server=localhost;Database="&cual&";User ID=oscarjso;Password=A20agb;Trusted_Connection=False;"
	end select
end function

public function cerrarSesion()
		codCODACCESO = Request.Cookies ("kkii12")("id")
		if trim(codCODACCESO)<>"" then
			BorrarDatos "acceso", " acceso='"&codCODACCESO&"' ", "core"
		end if
		Response.Cookies ("kkii12")("us") = "err"
		Response.Cookies ("kkii12")("id")= "err"
		Response.Cookies ("kkii12")("idVal") = "err"
		Response.Cookies ("kkii12")("nom") = "err"
		Response.Cookies ("kkii12")("db") = "err"
		Response.Cookies ("kkii12")("per") = "err"
		Response.Cookies ("kkii12")("id_cli") = "err"
		Response.Cookies ("kkii12")("iVV")= "err"
		Response.Cookies ("kkii12").Expires = dateAdd("d",-1,date())
end function
public function cerrarSesion2()
		codCODACCESO = Request.Cookies ("kkii12")("id")
		if trim(codCODACCESO)<>"" then
			BorrarDatos "acceso", " acceso='"&codCODACCESO&"' ", "core"
			Response.Cookies ("kkii12")("us") = "err"
			Response.Cookies ("kkii12")("id")= "err"
			Response.Cookies ("kkii12")("idVal") = "err"
			Response.Cookies ("kkii12")("nom") = "err"
			Response.Cookies ("kkii12")("db") = "err"
			Response.Cookies ("kkii12")("per") = "err"
			Response.Cookies ("kkii12")("id_cli") = "err"
			Response.Cookies ("kkii12")("iVV")= "err"
			Response.Cookies ("kkii12").Expires = dateAdd("d",-1,date())
		end if
end function

public function validaAcceso()
	codCODACCESO = Request.Cookies ("kkii12")("id")
	datosCODACCESO = executee("select * from acceso where acceso='"&codCODACCESO&"'", "core")
	if not IsEmpty(datosCODACCESO) then
		for l=0 to ubound(datosCODACCESO,2)
			acceCODACCESO = Request.Cookies("kkii12")("id")&"|"&Request.Cookies("kkii12")("idVal")&"|"&Request.Cookies ("kkii12")("nom")&"|"&Request.Cookies ("kkii12")("us")&"|"&Request.Cookies ("kkii12")("db")&"|"&Request.Cookies("kkii12")("per")&"|"&Request.Cookies("kkii12")("id_cli")&"|"&Request.Cookies("kkii12")("iVV")
		next
	else
		acceCODACCESO = "false"
		cerrarSesion()
	end if		
	validaAcceso = acceCODACCESO
end function

function quitarLetras(textt)
	textt = LCASE(textt)
	textt = replace(textt, "&#225;","a")
	textt = replace(textt,"&#233;","e")
	textt = replace(textt, "&#237;","i")
	textt = replace(textt,"&#243;","o")
	textt = replace(textt,"&#250;","u")
	textt = replace(textt,"&#241;","n")
	quitarLetras = textt
end function

Function tildes2Entities(texto)
        if tildes2Entities<>"" then
			 texto = convertCharSet(trim(texto) , "X-ANSI", "utf-8")
            texto = Replace(texto, "¡", "&iexcl;")
            texto = Replace(texto, "¿", "&iquest;")
            'texto = Replace(texto, "'", "&apos;")
 
            texto = Replace(texto, "á", "&aacute;")
            texto = Replace(texto, "é", "&eacute;")
            texto = Replace(texto, "í", "&iacute;")
            texto = Replace(texto, "ó", "&oacute;")
            texto = Replace(texto, "ú", "&uacute;")
            texto = Replace(texto, "ñ", "&ntilde;")
            texto = Replace(texto, "ç", "&ccedil;")
 
            texto = Replace(texto, "Á", "&Aacute;")
            texto = Replace(texto, "É", "&Eacute;")
            texto = Replace(texto, "Í", "&Iacute;")
            texto = Replace(texto, "Ó", "&Oacute;")
            texto = Replace(texto, "Ú", "&Uacute;")
            texto = Replace(texto, "Ñ", "&Ntilde;")
            texto = Replace(texto, "Ç", "&Ccedil;")
 
            texto = Replace(texto, "à", "&agrave;")
            texto = Replace(texto, "è", "&egrave;")
            texto = Replace(texto, "ì", "&igrave;")
            texto = Replace(texto, "ò", "&ograve;")
            texto = Replace(texto, "ù", "&ugrave;")
 
            texto = Replace(texto, "À", "&Agrave;")
            texto = Replace(texto, "È", "&Egrave;")
            texto = Replace(texto, "Ì", "&Igrave;")
            texto = Replace(texto, "Ò", "&Ograve;")
            texto = Replace(texto, "Ù", "&Ugrave;")
 
            texto = Replace(texto, "ä", "&auml;")
            texto = Replace(texto, "ë", "&euml;")
            texto = Replace(texto, "ï", "&iuml;")
            texto = Replace(texto, "ö", "&ouml;")
            texto = Replace(texto, "ü", "&uuml;")
 
            texto = Replace(texto, "Ä", "&Auml;")
            texto = Replace(texto, "Ë", "&Euml;")
            texto = Replace(texto, "Ï", "&Iuml;")
            texto = Replace(texto, "Ö", "&Ouml;")
            texto = Replace(texto, "Ü", "&Uuml;")
 
            texto = Replace(texto, "â", "&acirc;")
            texto = Replace(texto, "ê", "&ecirc;")
            texto = Replace(texto, "î", "&icirc;")
            texto = Replace(texto, "ô", "&ocirc;")
            texto = Replace(texto, "û", "&ucirc;")
 
            texto = Replace(texto, "Â", "&Acirc;")
            texto = Replace(texto, "Ê", "&Ecirc;")
            texto = Replace(texto, "Î", "&Icirc;")
            texto = Replace(texto, "Ô", "&Ocirc;")
            texto = Replace(texto, "Û", "&Ucirc;")
			
		end if
        tildes2Entities = texto
    End Function

Function StringToBinary(Text, CharSet)
Const adTypeText = 2
Const adTypeBinary = 1
'Create Stream object
Dim objStream 'As New Stream
Set objStream = CreateObject("ADODB.Stream")
'Specify stream type - we want To save text/string data.
objStream.Type = adTypeText
'Specify charset For the source text (unicode) data.
If Len(CharSet) > 0 Then
objStream.CharSet = CharSet
Else
Err.Raise vbObjectError + 1, "IllegalArgument", "Charset is required"
End If
'Open the stream And write text/string data To the object
objStream.Open
objStream.WriteText Text
'Change stream type To binary
objStream.Position = 0
objStream.Type = adTypeBinary
'Ignore first two bytes - sign of
objStream.Position = 0
'Open the stream And get binary data from the object
StringToBinary = objStream.Read
End Function
' convert a binary stream to text in a given encoding
Function BinaryToString(binData, CharSet)
Dim objStream
Dim strTmp
Const adTypeBinary = 1
Const adTypeText = 2
Const adModeReadWrite = 3
' init stream
Set objStream = server.CreateObject("ADODB.Stream")
If CharSet<>"" Then
objStream.CharSet = CharSet
Else
Err.Raise vbObjectError + 1, "IllegalArgument", "Charset is required"
End If
objStream.Mode = adModeReadWrite
objStream.Type = adTypeBinary
objStream.Open
' write bytes into stream
objStream.Write binData
objStream.Flush
' rewind stream and read text
objStream.Position = 0
objStream.Type = adTypeText
strTmp = objStream.ReadText
' close up and return
objStream.Close
BinaryToString = strTmp
End Function
' Function to bind the two: convert orig charset to a binary stream and then back again to the new charset
Function convertCharSet(text, origCharset, newCharSet)
Dim binaryData
binaryData = StringToBinary(text, origCharset)
convertCharSet = BinaryToString(binaryData, newCharSet)
End Function
%>

