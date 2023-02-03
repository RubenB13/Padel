<%@ Page Language="VB" Debug="true" CODEPAGE="65001"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>

<script runat="server">
Sub Page_Load()  
	dim infoPrint as string
	dim file = request.files(0)
	dim area as string = request.form("txtArea")
	dim nombreArchivoBorrar as string = request.form("txtNombreArchivoActual")
	dim txtNumEmpleado as string = request.form("txtNumEmpleado")

	dim cboInfraestructura as string = request.form("cboInfraestructura")
	dim txtConcepto as string = request.form("txtConcepto")
    dim txtUso as string = request.form("txtUso")
    dim txtSerie as string = request.form("txtSerie")
    dim txtVidaUtil as string = request.form("txtVidaUtil")
    dim cboResponsable as string = request.form("cboResponsable")
    dim txtMarca as string = request.form("txtMarca")
    dim txtModelo as string = request.form("txtModelo")
    dim txtVersion as string = request.form("txtVersion")
    dim txtPlaca as string = request.form("txtPlaca")
    dim txtArea as string = request.form("txtAreaINFRA")
    dim txtFechaAdquisicion as string = request.form("txtFechaAdquisicion")

    dim txtGuardoInfoOK as string = request.form("txtGuardoInfoOk")
    dim idReg as integer = request.form("hdIdInfra")

    dim txtNombreEmpleado as string = request.form("txtNombreEmpleado")
    dim txtFechaRealizada as string = request.form("txtFechaRealizada")
    dim txtDepartamento as string = request.form("txtDepartamento")

    dim guardarActualizar  as string
    dim guardarActualizarM  as string
    dim textFileName  as string
    dim infoPrintTextFile  as string
    dim oknoOK  as string
    dim nombrefoto as string

    dim insertedID as string

    ' dim dbbb as string = "Server=sql5109.site4now.net,1433;Database=db_a88f20_bdupadel2022;User ID=db_a88f20_bdupadel2022_admin;Password=upadel777;Trusted_Connection=False;"
    dim dbbb as string = "Data Source=SQL5109.site4now.net;Initial Catalog=db_a88f20_bdupadel2022;User Id=db_a88f20_bdupadel2022_admin;Password=upadel777"
    Dim myConnection As New SqlConnection(dbbb)
	' response.write(idCliente)
	Try

		
		if file.ContentLength > 0 and file.ContentLength < 1171875 then
			Dim ext As String = System.IO.Path.GetExtension(file.FileName)
	        if ext = ".jpg" or ext = ".png" or ext = ".jpeg" or ext = ".JPG" or ext = ".JPEG" or ext = ".PNG" then
				

				dim fileExt as string = System.IO.Path.GetExtension(file.FileName)

				If Not Directory.Exists(Server.MapPath("\fotosAcceso")) = True Then
					Directory.CreateDirectory(Server.MapPath("\fotosAcceso"))
				End If

				textFileName = RemoveAccentMarks(file.FileName)

				nombrefoto = "empleado"+txtNumEmpleado+textFileName
	         
	            file.SaveAs(Server.MapPath("/")& "fotosAcceso\"+nombrefoto)
	          
	            
	            infoPrint = "{'ok':'ok','nombre':'"+nombrefoto+"', 'guardoInfo':'ok'}"
	            
	            oknoOK = "ok"
				
			else
	            infoPrint = "{'ok':'noOk', 'guardoInfo':'ok'}"
	            oknoOK = "noOk"
			end if
		else
			oknoOK = "noOk"
			textFileName = nombreArchivoBorrar
			if file.ContentLength = 0 then
				infoPrintTextFile = "Se guardo sin archivo de evidencia"
			else
	        	infoPrintTextFile = "El archivo tiene que ser menor de 1.2 mb "+file.ContentLength.toString()
	        end if
		end if


		if idReg > 0 then
			' myConnection.Open()
			' guardarActualizarM =  "update crmt_calidad_infraestructura set concepto='"+txtConcepto+"', uso='"+txtUso+"', serie='"+txtSerie+"', vida_util='"+txtVidaUtil+"', usuario='"+cboResponsable+"', fecha_adquisicion='"+txtFechaAdquisicion+"', marca='"+txtMarca+"', modelo='"+txtModelo+"', version='"+txtVersion+"', placa='"+txtPlaca+"', area='"+txtArea+"', tipo_infraestructura='"+cboInfraestructura+"', nombre_archivo='"+textFileName+"'  where id="+idReg.toString
			' Dim myCommand As New SqlCommand(guardarActualizarM, myConnection)
			' myCommand.ExecuteNonQuery()
			' myConnection.Close()
			' insertedID = idReg.toString
		else if txtGuardoInfoOK = "noOk" then
			
			guardarActualizar = "insert into admin_alta_socios (nombre, fecha_laboral, departamento, foto, fecha_alta, tipo, estado ) values ('"+txtNombreEmpleado+"','"+txtFechaRealizada+"','"+txtDepartamento+"','"+nombrefoto+"', getDate(), 1, 1 ); SELECT SCOPE_IDENTITY(); "

			Dim myCommand As New SqlCommand(guardarActualizar, myConnection)
			myConnection.Open()
			insertedID= myCommand.ExecuteScalar().toString()
			myConnection.Close()
		end if

		infoPrint = "{'ok':'"+oknoOK+"', 'nombre':'"+nombrefoto+"', 'error':'"+infoPrintTextFile+"', 'guardoInfo':'ok', 'idReg':'"+insertedID+"'}"

	Catch ex As Exception
    	infoPrint = "{'ok':'noOk','error':'ERROR: " + ex.Message.ToString() +"', 'guardoInfo':'noOk'}"
   	End Try

	infoPrint = Replace(infoPrint, "'", chr(34))
	response.write(infoPrint)
End Sub

Function RemoveAccentMarks(ByVal s As String) As String

    Dim normalizedString As String = s.Normalize(NormalizationForm.FormD)
    Dim stringBuilder As New StringBuilder()

    Dim c As Char
    For i = 0 To normalizedString.Length - 1
        c = normalizedString(i)
        If System.Globalization.CharUnicodeInfo.GetUnicodeCategory(c) <> System.Globalization.UnicodeCategory.NonSpacingMark Then
            stringBuilder.Append(c)
        End If
    Next
    Return stringBuilder.ToString

End Function

</script>

