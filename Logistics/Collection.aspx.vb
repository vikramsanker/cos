Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Public Class Collection
    Inherits System.Web.UI.Page
    Private LocalCall As New GlobalVar
    Private sqlCon As SqlConnection
    Private timecheckhour As Integer = 17
    Private timecheckmin As Integer = 0
    Private timechecksec As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Session("Username") Is Nothing Then
                Response.Redirect("LoginWindow.aspx")
            Else
                If Not Page.IsPostBack Then
                    Timecheck()
                    Dim lbl As Label = Me.Master.FindControl("LblHeader")
                    lbl.Text = "COLLECTION MANAGEMENT"
                    Searchbox.Attributes.Add("onkeydown", "return (event.keyCode!=13);")
                    Panel5.DefaultButton = "SearchButton"
                    Dim strQuery As String
                    strQuery = "select CollectionID, Client, [Address Line 1], [Address Line 2], [Address Line 3], (select Country from Countries where CountryID = Collection.Country) as Country, PostalCode as [Postal Code], concat(Salutation, Contact) as Contact, Telephone, Handphone, Concat(DAY([DOC]),'-',CONVERT(VARCHAR(3),Datename(month, [DOC])),'-',YEAR([DOC])) As [Collection Date], (Select concat(FName, ' ', LName) from Employee Where Eid = [Caltek Sales]) as Salesperson, (select Vendor from Vendor where VID = Collection.Transporter) as Transporter, Note as [Note to Driver], Collection.Status, AG.Status As [Agent Status], AG.Remarks As [Reason] from Collection LEFT JOIN (Select * from Agentupdate Where Type <> 'Delivery') AS AG on CollectionId=AG.ID Where CollectionId NOT IN (Select ID from Agentupdate Where Type = 'Collection' And Status = 'Completed');
                                select country from countries; Select Client from Client; select Vendor from vendor; Select concat(FName,' ' ,LName) as Employee from Employee"
                    Dim Getdata As New GetdataSet()
                    Dim Sqldataset As DataSet = Getdata.GetDataset(strQuery)
                    GridView1.DataSource = Sqldataset.Tables(0)
                    GridView1.DataBind()
                    Country.DataSource = Sqldataset.Tables(1)
                    Country.DataTextField = "country"
                    Country.DataBind()
                    TxtClient.DataSource = Sqldataset.Tables(2)
                    TxtClient.DataTextField = "Client"
                    TxtClient.DataBind()
                    TxtTrans.DataSource = Sqldataset.Tables(3)
                    TxtTrans.DataTextField = "Vendor"
                    TxtTrans.DataBind()
                    TxtSalesperson.DataSource = Sqldataset.Tables(4)
                    TxtSalesperson.DataTextField = "Employee"
                    TxtSalesperson.DataBind()
                    Save.Enabled = True
                    Update.Enabled = False
                    Delete.Enabled = False
                    'Dim SendCount As String = Getdata.RowCount("select count(*) as Count from Collection") & " Record(s) Found"
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
            Timecheck()
            Dim ID As Object = GridView1.Rows(Convert.ToInt32(e.CommandArgument)).Cells(1).Text
            Dim strQuery As String
            strQuery = "select Client, [Address Line 1], [Address Line 2], [Address Line 3], (select Country from Countries where CountryID = Collection.Country) as Country, PostalCode as [Postal Code], Salutation, Contact, Telephone, Handphone, DOC, (select concat(FName, ' ', LName) from Employee where Eid = Collection.[Caltek Sales]) as Salesperson, (select Vendor from Vendor where VID = Collection.Transporter) as Transporter, Note, Status from Collection Where CollectionID = '" & ID & "'"
            Dim GetData As New GetdataSet()
            Dim SQLDataset As DataSet = GetData.GetDataset(strQuery)
            'Dim SendCount As String = GetData.RowCount("select count(*) as Count from Collection") & " Record(s) Found"
            Dim SendCount As String = GridView1.Rows.Count & " Record(s) Found"
            If SQLDataset.Tables(0).Rows(0).Item("Status").ToString() <> "Deleted" Then
                If SQLDataset.Tables(0).Rows(0).Item("DOC").ToString() > Today.AddDays(-1) Then
                    COSkey.Text = ID.ToString()
                    TxtClient.Text = SQLDataset.Tables(0).Rows(0).Item("Client").ToString()
                    TxtAdd1.Text = SQLDataset.Tables(0).Rows(0).Item("Address Line 1").ToString()
                    TxtAdd2.Text = SQLDataset.Tables(0).Rows(0).Item("Address Line 2").ToString()
                    TxtAdd3.Text = SQLDataset.Tables(0).Rows(0).Item("Address Line 3").ToString()
                    Country.Text = SQLDataset.Tables(0).Rows(0).Item("Country").ToString()
                    Txtpostalcode.Text = SQLDataset.Tables(0).Rows(0).Item("Postal Code").ToString()
                    TxtSal.Text = SQLDataset.Tables(0).Rows(0).Item("Salutation").ToString()
                    TxtName.Text = SQLDataset.Tables(0).Rows(0).Item("Contact").ToString()
                    TxtTel.Text = SQLDataset.Tables(0).Rows(0).Item("Telephone").ToString()
                    TxtHP.Text = SQLDataset.Tables(0).Rows(0).Item("Handphone").ToString()
                    TxtDOC.Text = SQLDataset.Tables(0).Rows(0).Item("DOC").ToString()
                    TxtSalesperson.Text = SQLDataset.Tables(0).Rows(0).Item("Salesperson").ToString()
                    TxtTrans.Text = SQLDataset.Tables(0).Rows(0).Item("Transporter").ToString()
                    TxtNote.Text = SQLDataset.Tables(0).Rows(0).Item("Note").ToString()
                    Save.Enabled = False
                    Update.Enabled = True
                    Delete.Enabled = True
                    TxtClient.Enabled = False
                    Call usermsg("Message from COS: Collection arrangement loaded successfully!!", LocalCall.Success_Back, LocalCall.Success_Front, SendCount)
                Else
                    Call usermsg("Message from COS: The collection arrangement is too late to modify now!!", LocalCall.Failure_Back, LocalCall.Failure_Front, SendCount)
                End If
            Else
                Call usermsg("Message from COS: The collection arrangement that you are trying to edit has already been cancelled!! Hence it cannot be edited!!", LocalCall.Failure_Back, LocalCall.Failure_Front, SendCount)
            End If
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
                sqlComm.CommandText = "Collection_Insert"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("Client", TxtClient.Text)
                sqlComm.Parameters.AddWithValue("Addressline1", TxtAdd1.Text)
                sqlComm.Parameters.AddWithValue("Addressline2", TxtAdd2.Text)
                sqlComm.Parameters.AddWithValue("Addressline3", TxtAdd3.Text)
                sqlComm.Parameters.AddWithValue("Country", Country.Text)
                sqlComm.Parameters.AddWithValue("Postalcode", Txtpostalcode.Text)
                sqlComm.Parameters.AddWithValue("Salutation", TxtSal.Text)
                sqlComm.Parameters.AddWithValue("Contact", TxtName.Text)
                sqlComm.Parameters.AddWithValue("Telephone", TxtTel.Text)
                sqlComm.Parameters.AddWithValue("Handphone", TxtHP.Text)
                sqlComm.Parameters.AddWithValue("DOC", TxtDOC.Text)
                sqlComm.Parameters.AddWithValue("CaltekSales", TxtSalesperson.Text)
                sqlComm.Parameters.AddWithValue("Transporter", TxtTrans.Text)
                sqlComm.Parameters.AddWithValue("Note", TxtNote.Text)
                sqlComm.Parameters.AddWithValue("Createduser", Session("Username"))
                sqlComm.Parameters.AddWithValue("Created", Now())
                sqlComm.Parameters.AddWithValue("Modifieduser", "NA")
                sqlComm.Parameters.AddWithValue("Modified", Now())
                sqlComm.Parameters.AddWithValue("Status", "New")
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("Collection.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub Clear_Click(sender As Object, e As EventArgs) Handles Clear.Click
        Response.Redirect("Collection.aspx", False)
    End Sub
    Protected Sub Update_Click(sender As Object, e As EventArgs) Handles Update.Click
        Try
            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "Collection_Update"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("CollectionID", COSkey.Text)
                sqlComm.Parameters.AddWithValue("Addressline1", TxtAdd1.Text)
                sqlComm.Parameters.AddWithValue("Addressline2", TxtAdd2.Text)
                sqlComm.Parameters.AddWithValue("Addressline3", TxtAdd3.Text)
                sqlComm.Parameters.AddWithValue("Country", Country.Text)
                sqlComm.Parameters.AddWithValue("Postalcode", Txtpostalcode.Text)
                sqlComm.Parameters.AddWithValue("Salutation", TxtSal.Text)
                sqlComm.Parameters.AddWithValue("Contact", TxtName.Text)
                sqlComm.Parameters.AddWithValue("Telephone", TxtTel.Text)
                sqlComm.Parameters.AddWithValue("Handphone", TxtHP.Text)
                sqlComm.Parameters.AddWithValue("DOC", TxtDOC.Text)
                sqlComm.Parameters.AddWithValue("CaltekSales", TxtSalesperson.Text)
                sqlComm.Parameters.AddWithValue("Transporter", TxtTrans.Text)
                sqlComm.Parameters.AddWithValue("Note", TxtNote.Text)
                sqlComm.Parameters.AddWithValue("Modifieduser", Session("Username"))
                sqlComm.Parameters.AddWithValue("Modified", Now())
                sqlComm.Parameters.AddWithValue("Status", "Updated")
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("Collection.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub SearchButton_Click(sender As Object, e As EventArgs) Handles SearchButton.Click
        Try
            Dim strQuery As String
            strQuery = "select CollectionID as [Reference ID], Client, [Address Line 1], [Address Line 2], [Address Line 3], (select Country from Countries where CountryID = Collection.Country) as Country, PostalCode as [Postal Code], concat(Salutation, Contact) as Contact, Telephone, Handphone, Concat(DAY([DOC]),'-',CONVERT(VARCHAR(3),Datename(month, [DOC])),'-',YEAR([DOC])) As [Collection Date], [Caltek Sales] as Salesperson, (select Vendor from Vendor where VID = Collection.Transporter) as Transporter, Note as [Note to Driver] from Collection
                        Where 
                        concat (CollectionID, Client, [Address Line 1], [Address Line 2], [Address Line 3], (select Country from Countries where CountryID = Collection.Country), Postalcode, contact, Telephone, Handphone, Concat(DAY([DOC]),'-',CONVERT(VARCHAR(3),Datename(month, [DOC])),'-',YEAR([DOC])), [Caltek Sales], (select Vendor from Vendor where VID = Collection.Transporter), Note) Like '%" & Searchbox.Text & "%'"
            Dim Getdata As New GetdataSet()
            Dim Sqldataset As DataSet = Getdata.GetDataset(strQuery)
            GridView1.DataSource = Sqldataset.Tables(0)
            GridView1.DataBind()
            'Dim SendCount As String = Getdata.RowCount("select count(*)as Count from Collection Where 
            '                                            concat (CollectionID, Client, [Address Line 1], [Address Line 2], [Address Line 3], (select Country from Countries where CountryID = Collection.Country), Postalcode, contact, Telephone, Handphone, DOC, [Caltek Sales], (select Vendor from Vendor where VID = Collection.Transporter), Note) Like '%" & Searchbox.Text & "%'") & " Record(s) Found"
            Dim SendCount As String = GridView1.Rows.Count & " Record(s) Found"
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
                sqlComm.CommandText = "Collection_Delete"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("CollectionID", COSkey.Text)
                sqlComm.Parameters.AddWithValue("Status", "Deleted")
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("Collection.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Export_Click(sender As Object, e As EventArgs) Handles Export.Click
        Try
            Dim ExporttoExcel As New Export
            Dim Filename As String = "Collection_"
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

    Protected Sub TxtClient_SelectedIndexChanged(sender As Object, e As EventArgs) Handles TxtClient.SelectedIndexChanged
        Try
            Dim strQuery As String
            strQuery = "select [Address Line 1], [Address Line 2], [Address Line 3], (select Country from Countries where CountryID = Client.Country) as Country, PostalCode, Salutation, Contact, Telephone, Handphone, (select concat(FName, ' ', LName) from Employee where Eid = Client.[Caltek Sales]) as Salesperson, Remarks from Client Where Client = '" & TxtClient.Text & "'"
            Dim GetData As New GetdataSet()
            Dim SQLDataset As DataSet = GetData.GetDataset(strQuery)
            TxtAdd1.Text = SQLDataset.Tables(0).Rows(0).Item("Address Line 1").ToString()
            TxtAdd2.Text = SQLDataset.Tables(0).Rows(0).Item("Address Line 2").ToString()
            TxtAdd3.Text = SQLDataset.Tables(0).Rows(0).Item("Address Line 3").ToString()
            Country.Text = SQLDataset.Tables(0).Rows(0).Item("Country").ToString()
            Txtpostalcode.Text = SQLDataset.Tables(0).Rows(0).Item("PostalCode").ToString()
            TxtSal.SelectedValue = SQLDataset.Tables(0).Rows(0).Item("Salutation").ToString()
            TxtName.Text = SQLDataset.Tables(0).Rows(0).Item("Contact").ToString()
            TxtTel.Text = SQLDataset.Tables(0).Rows(0).Item("Telephone").ToString()
            TxtHP.Text = SQLDataset.Tables(0).Rows(0).Item("Handphone").ToString()
            TxtSalesperson.Text = SQLDataset.Tables(0).Rows(0).Item("Salesperson").ToString()
            TxtNote.Text = SQLDataset.Tables(0).Rows(0).Item("Remarks").ToString()
            'Dim SendCount As String = GetData.RowCount("select count(*) as Count from Collection") & " Record(s) Found"
            Dim SendCount As String = GridView1.Rows.Count & " Record(s) Found"
            Save.Enabled = True
            Update.Enabled = False
            Delete.Enabled = False
            Call usermsg("Message from COS: Client details loaded successfully", LocalCall.Success_Back, LocalCall.Success_Front, SendCount)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Timecheck()
        Try
            Dim Caseselect As Integer
            If Today().DayOfWeek <> 5 Then
                Caseselect = 1
            Else
                Caseselect = 2
            End If
            Select Case Caseselect
                Case "1"
                    If Now.TimeOfDay.TotalSeconds >= (timecheckhour * 60 * 60) + (timecheckmin * 60) + timechecksec Then
                        TxtDOC.Attributes("min") = (Today.AddDays(2)).ToString("yyyy-MM-dd")
                    Else
                        TxtDOC.Attributes("min") = (Today.AddDays(1)).ToString("yyyy-MM-dd")
                    End If
                Case "2"
                    If Now.TimeOfDay.TotalSeconds >= (timecheckhour * 60 * 60) + (timecheckmin * 60) + timechecksec Then
                        TxtDOC.Attributes("min") = (Today.AddDays(4)).ToString("yyyy-MM-dd")
                    Else
                        TxtDOC.Attributes("min") = (Today.AddDays(3)).ToString("yyyy-MM-dd")
                    End If
            End Select
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
End Class