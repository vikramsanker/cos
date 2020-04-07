Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Public Class Transporters
    Inherits System.Web.UI.Page
    Private LocalCall As New GlobalVar
    Private sqlCon As SqlConnection
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Session("Username") Is Nothing Then
                Response.Redirect("LoginWindow.aspx")
            Else
                If Not Page.IsPostBack Then
                    Dim lbl As Label = Me.Master.FindControl("LblHeader")
                    lbl.Text = "TRANSPORTER MANAGEMENT"
                    Searchbox.Attributes.Add("onkeydown", "return (event.keyCode!=13);")
                    Panel5.DefaultButton = "SearchButton"
                    Dim strQuery As String
                    strQuery = "select VID as [Vendor ID], Vendor, [Address Line 1] as Address, (select Country from Countries where CountryID = Vendor.Country) as Country, PostalCode as [Postal Code], concat(Salutation, Contact) as Contact, Status from Vendor;
                                select country from countries"
                    Dim Getdata As New GetdataSet()
                    Dim Sqldataset As DataSet = Getdata.GetDataset(strQuery)
                    GridView1.DataSource = Sqldataset.Tables(0)
                    GridView1.DataBind()
                    Country.DataSource = Sqldataset.Tables(1)
                    Country.DataTextField = "country"
                    Country.DataBind()
                    Save.Enabled = True
                    Update.Enabled = False
                    Delete.Enabled = False
                    'Dim SendCount As String = Getdata.RowCount("select count(*) as Count from Vendor") & " Record(s) Found"
                    Dim SendCount As String = GridView1.Rows.Count & " Record(s) Found"
                    Call usermsg(LocalCall.Load_Message, LocalCall.Success_Back, LocalCall.Success_Front, SendCount)
                End If
            End If
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Private Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView1.RowCommand
        Try
            Dim ID As Object = GridView1.Rows(Convert.ToInt32(e.CommandArgument)).Cells(1).Text
            Dim strQuery As String
            strQuery = "select VID as [Vendor ID], Vendor, [Address Line 1], [Address Line 2], [Address Line 3], (select Country from Countries where CountryID=Vendor.Country) as Country, PostalCode as [Postal Code], Salutation, Contact, Status, Handphone, [Email ID], Remarks, Telephone from Vendor Where VID = '" & ID & "'"
            Dim GetData As New GetdataSet()
            Dim SQLDataset As DataSet = GetData.GetDataset(strQuery)
            COSkey.Text = ID.ToString()
            TxtVendor.Text = SQLDataset.Tables(0).Rows(0).Item("Vendor").ToString()
            TxtAdd1.Text = SQLDataset.Tables(0).Rows(0).Item("Address Line 1").ToString()
            TxtAdd2.Text = SQLDataset.Tables(0).Rows(0).Item("Address Line 2").ToString()
            TxtAdd3.Text = SQLDataset.Tables(0).Rows(0).Item("Address Line 3").ToString()
            Country.Text = SQLDataset.Tables(0).Rows(0).Item("Country").ToString()
            Txtpostalcode.Text = SQLDataset.Tables(0).Rows(0).Item("Postal Code").ToString()
            TxtSal.Text = SQLDataset.Tables(0).Rows(0).Item("Salutation").ToString()
            TxtName.Text = SQLDataset.Tables(0).Rows(0).Item("Contact").ToString()
            Status.Text = SQLDataset.Tables(0).Rows(0).Item("Status").ToString()
            TxtHP.Text = SQLDataset.Tables(0).Rows(0).Item("Handphone").ToString()
            TxtEmail.Text = SQLDataset.Tables(0).Rows(0).Item("Email ID").ToString()
            TxtNote.Text = SQLDataset.Tables(0).Rows(0).Item("Remarks").ToString()
            TxtTel.Text = SQLDataset.Tables(0).Rows(0).Item("Telephone").ToString()
            'Dim SendCount As String = GetData.RowCount("select count(*) as Count from Vendor") & " Record(s) Found"
            Dim SendCount As String = GridView1.Rows.Count & " Record(s) Found"
            Save.Enabled = False
            Update.Enabled = True
            Delete.Enabled = True
            TxtVendor.Enabled = False
            Call usermsg(LocalCall.Edit_Message, LocalCall.Progress_Back, LocalCall.Progress_Front, SendCount)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Save_Click(sender As Object, e As EventArgs) Handles Save.Click
        Try
            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "Vendor_Insert"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("Vendor", TxtVendor.Text)
                sqlComm.Parameters.AddWithValue("Addressline1", TxtAdd1.Text)
                sqlComm.Parameters.AddWithValue("Addressline2", TxtAdd2.Text)
                sqlComm.Parameters.AddWithValue("Addressline3", TxtAdd3.Text)
                sqlComm.Parameters.AddWithValue("Country", Country.Text)
                sqlComm.Parameters.AddWithValue("Postalcode", Txtpostalcode.Text)
                sqlComm.Parameters.AddWithValue("Salutation", TxtSal.Text)
                sqlComm.Parameters.AddWithValue("Contact", TxtName.Text)
                sqlComm.Parameters.AddWithValue("Telephone", TxtTel.Text)
                sqlComm.Parameters.AddWithValue("Handphone", TxtHP.Text)
                sqlComm.Parameters.AddWithValue("EmailID", TxtEmail.Text)
                sqlComm.Parameters.AddWithValue("Status", Status.Text)
                sqlComm.Parameters.AddWithValue("Createduser", Session("Username"))
                sqlComm.Parameters.AddWithValue("Remarks", TxtNote.Text)
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("Transporters.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub Clear_Click(sender As Object, e As EventArgs) Handles Clear.Click
        Response.Redirect("Transporters.aspx", False)
    End Sub
    Protected Sub Update_Click(sender As Object, e As EventArgs) Handles Update.Click
        Try
            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "Vendor_Update"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("VID", COSkey.Text)
                sqlComm.Parameters.AddWithValue("Addressline1", TxtAdd1.Text)
                sqlComm.Parameters.AddWithValue("Addressline2", TxtAdd2.Text)
                sqlComm.Parameters.AddWithValue("Addressline3", TxtAdd3.Text)
                sqlComm.Parameters.AddWithValue("Country", Country.Text)
                sqlComm.Parameters.AddWithValue("Postalcode", Txtpostalcode.Text)
                sqlComm.Parameters.AddWithValue("Salutation", TxtSal.Text)
                sqlComm.Parameters.AddWithValue("Contact", TxtName.Text)
                sqlComm.Parameters.AddWithValue("Telephone", TxtTel.Text)
                sqlComm.Parameters.AddWithValue("Handphone", TxtHP.Text)
                sqlComm.Parameters.AddWithValue("EmailID", TxtEmail.Text)
                sqlComm.Parameters.AddWithValue("Status", Status.Text)
                sqlComm.Parameters.AddWithValue("Createduser", Session("Username"))
                sqlComm.Parameters.AddWithValue("Remarks", TxtNote.Text)
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("Transporters.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub SearchButton_Click(sender As Object, e As EventArgs) Handles SearchButton.Click
        Try
            Dim strQuery As String
            strQuery = "select VId as [Vendor ID], Vendor, [Address Line 1] as Address, (select Country from Countries where CountryID = Vendor.Country) as Country, PostalCode as [Postal Code], concat(Salutation, Contact) as Contact, Status from Vendor
                        Where 
                        concat (VId, Vendor, [Address Line 1], (select Country from Countries where CountryID = Vendor.Country), Postalcode, contact, Status) Like '%" & Searchbox.Text & "%'"
            Dim Getdata As New GetdataSet()
            Dim Sqldataset As DataSet = Getdata.GetDataset(strQuery)
            GridView1.DataSource = Sqldataset.Tables(0)
            GridView1.DataBind()
            Dim SendCount As String = GridView1.Rows.Count & " Record(s) Found"
            'Dim SendCount As String = Getdata.RowCount("select count(*)as Count from Vendor Where 
            '                                            concat (VId, Vendor, [Address Line 1], (select Country from Countries where CountryID = Vendor.Country), Postalcode, contact, Status) Like '%" & Searchbox.Text & "%'") & " Record(s) Found"
            Call usermsg(LocalCall.Search_Message, LocalCall.Success_Back, LocalCall.Success_Front, SendCount)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub Delete_Click(sender As Object, e As EventArgs) Handles Delete.Click
        Try
            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "Vendor_Delete"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("Vid", COSkey.Text)
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("Transporters.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub Export_Click(sender As Object, e As EventArgs) Handles Export.Click
        Try
            Dim ExporttoExcel As New Export
            Dim Filename As String = "Vendor_"
            ExporttoExcel.Export_Now(e, e, GridView1, Filename)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        ' Verifies that the control is rendered 
    End Sub
    Protected Sub usermsg(msg As String, BColor As Color, FColor As Color, Optional NCount As String = "0 Record(s) Found")
        Dim lbl As Label = Me.Master.FindControl("MessageFooter")
        lbl.Text = msg
        LblCount.Text = NCount
        lbl.BackColor = BColor
        lbl.ForeColor = FColor
    End Sub
End Class