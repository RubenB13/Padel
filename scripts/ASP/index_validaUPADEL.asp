<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="BD.asp"-->
<%
Response.Expires = 0
email = request.form("email")
pass = request.form("pass")

passDec = Base64Decode(pass)

LServerName = Request.ServerVariables("SERVER_NAME")
valSpl = split(LServerName,".")
dominio = "db_a8638d_bdupadel" 'valSpl(0)  
passDec = replace(passDec,"'","")
passDec = replace(passDec,chr(34),"")
passDec = replace(passDec,"=","")

'valida el acceso a la plataforma

' ip = Request.ServerVariables("remote_addr")
'buscamos usuarios administradores y profesores en su tabla para que visualicen su agenda'
sql = "select id, nombre, tipo from admin_usuarios where email='"&email&"' and clave='"&passDec&"' "
		' " union all "&_
		' " select id, nombre, tipo from admin_profesores where email='"&email&"' and clave='"&passDec&"' "

datos = executee(sql,dominio)

if not IsEmpty(datos) then
	l = 0
	Randomize()
	myToken = generateToken
	myToken2 = generateToken
	respuesta =  respuesta & "{'token':'"&myToken&myToken2&"', 'ok':'ok','tipo':'"&datos(0,l)&"','idUsuario':'"&datos(0,l)&"','dominio':'"&dominio&"'}"
	' ActualizarDatos "usuarios",  " token='"&myToken&"', fecha_ultimo=getdate() ", "id="&datos(0,l) , dominio 
	
	Response.Cookies ("kkii124655")("tokey") = myToken
	Response.Cookies ("kkii124655")("id")= datos(0,l)
	Response.Cookies ("kkii124655")("nom")= datos(1,l)
	Response.Cookies ("kkii124655")("tipo")= datos(2,l)
	' Response.Cookies ("kkii124655")("app")= 0
    ' if datos(2,l) <> 2 then
	   ' Response.Cookies ("kkii124655").Expires =  DateAdd("d",1,date())
    ' end if
    ' session("nip") = datos(3,l)
else
	respuesta =  respuesta & "{ 'ok':'no'}"	
end if

respuesta = Replace(respuesta, "'", chr(34))
response.Write(respuesta)
	
	
	
	
function generateToken

	aList = array("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","y","w","z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9","/","+","==")
	sb = ""

	For i=1 to 43
		aRand = getRandomNumber(55)
		sb = sb & aList(aRand)
	Next

	generateToken = sb
end function

Function getRandomNumber(theUpperBound)
	Dim intLowerBound    ' Lower bound of the random number range
	Dim intUpperBound    ' Upper bound of the random number range

	Dim intRangeSize     ' Size of the range
	Dim sngRandomValue   ' A random value from 0 to intRangeSize
	Dim intRandomInteger ' Our final result - random integer to return

	intLowerBound = 0

	If IsNumeric(theUpperBound) Then
		intUpperBound = CLng(theUpperBound)
	Else
		intUpperBound = 20
	End If

	If intLowerBound > intUpperBound Then
		Dim iTemp
		iTemp = intLowerBound
		intLowerBound = intUpperBound
		intUpperBound = iTemp
	End If

	intRangeSize = intUpperBound - intLowerBound + 1
	sngRandomValue = intRangeSize * Rnd()
	sngRandomValue = sngRandomValue + intLowerBound
	intRandomInteger = Int(sngRandomValue)

	getRandomNumber = intRandomInteger
end Function


Function Base64Decode(ByVal base64String)
  'rfc1521
  '1999 Antonin Foller, Motobit Software, http://Motobit.cz
  Const Base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  Dim dataLength, sOut, groupBegin
  
  'remove white spaces, If any
  base64String = Replace(base64String, vbCrLf, "")
  base64String = Replace(base64String, vbTab, "")
  base64String = Replace(base64String, " ", "")
  
  'The source must consists from groups with Len of 4 chars
  dataLength = Len(base64String)
  If dataLength Mod 4 <> 0 Then
    Err.Raise 1, "Base64Decode", "Bad Base64 string."
    Exit Function
  End If

  
  ' Now decode each group:
  For groupBegin = 1 To dataLength Step 4
    Dim numDataBytes, CharCounter, thisChar, thisData, nGroup, pOut
    ' Each data group encodes up To 3 actual bytes.
    numDataBytes = 3
    nGroup = 0

    For CharCounter = 0 To 3
      ' Convert each character into 6 bits of data, And add it To
      ' an integer For temporary storage.  If a character is a '=', there
      ' is one fewer data byte.  (There can only be a maximum of 2 '=' In
      ' the whole string.)

      thisChar = Mid(base64String, groupBegin + CharCounter, 1)

      If thisChar = "=" Then
        numDataBytes = numDataBytes - 1
        thisData = 0
      Else
        thisData = InStr(1, Base64, thisChar, vbBinaryCompare) - 1
      End If
      If thisData = -1 Then
        Err.Raise 2, "Base64Decode", "Bad character In Base64 string."
        Exit Function
      End If

      nGroup = 64 * nGroup + thisData
    Next
    
    'Hex splits the long To 6 groups with 4 bits
    nGroup = Hex(nGroup)
    
    'Add leading zeros
    nGroup = String(6 - Len(nGroup), "0") & nGroup
    
    'Convert the 3 byte hex integer (6 chars) To 3 characters
    pOut = Chr(CByte("&H" & Mid(nGroup, 1, 2))) + _
      Chr(CByte("&H" & Mid(nGroup, 3, 2))) + _
      Chr(CByte("&H" & Mid(nGroup, 5, 2)))
    
    'add numDataBytes characters To out string
    sOut = sOut & Left(pOut, numDataBytes)
  Next

  Base64Decode = sOut
End Function

%>