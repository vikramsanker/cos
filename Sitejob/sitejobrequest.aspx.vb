Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Public Class sitejobrequest
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
                If Not Me.IsPostBack Then
                    Dim lbl As Label = Me.Master.FindControl("LblHeader")
                    lbl.Text = "SITE JOB REQUEST"
                    Dim dt As New DataTable
                    dt.Columns.Add(New DataColumn("Instrument", GetType(String)))
                    dt.Columns.Add(New DataColumn("Range", GetType(String)))
                    dt.Columns.Add(New DataColumn("Make", GetType(String)))
                    dt.Columns.Add(New DataColumn("Model", GetType(String)))
                    dt.Columns.Add(New DataColumn("Qty", GetType(String)))
                    dt.Columns.Add(New DataColumn("Cert. Type", GetType(String)))
                    dt.Columns.Add(New DataColumn("Pre Cert.", GetType(String)))
                    dt.Columns.Add(New DataColumn("Cal. Pts.", GetType(String)))
                    ViewState("temptable") = dt
                    GridView2.DataSource = DirectCast(ViewState("temptable"), DataTable)
                    GridView2.DataBind()
                    Dim Strquery As String = "Select Client from Client; Select concat (FName, ' ', LName) as Name from Employee; Select Country from Countries; Select Instruments from Instruments; 
                    Select Id, (Select Client from Client Where CId = JobRequest.CId) as Client, Concat(DAY([DOR]),'-',CONVERT(VARCHAR(3),Datename(month, [DOR])),'-',YEAR([DOR])) As [Requested Date], JobNo, PPE, [Risk Assessment], (Select concat (FName, ' ', LName) from Employee Where Eid = JobRequest.Salesperson) as Salesperson, Remarks, Status from JobRequest"
                    Dim Getdata As New GetdataSet()
                    Dim Sqldataset As DataSet = Getdata.GetDataset(Strquery)
                    TxtClient.DataSource = Sqldataset.Tables(0)
                    TxtClient.DataTextField = ("Client")
                    TxtClient.DataBind()
                    TxtSalesperson.DataSource = Sqldataset.Tables(1)
                    TxtSalesperson.DataTextField = ("Name")
                    TxtSalesperson.DataBind()
                    TxtCountry.DataSource = Sqldataset.Tables(2)
                    TxtCountry.DataTextField = ("Country")
                    TxtCountry.DataBind()
                    TxtInstrument.DataSource = Sqldataset.Tables(3)
                    TxtInstrument.DataTextField = ("Instruments")
                    TxtInstrument.DataBind()
                    GridView1.DataSource = Sqldataset.Tables(4)
                    GridView1.DataBind()
                    Call usermsg("Message from COS: Site job interface loaded successfully", LocalCall.Success_Back, LocalCall.Success_Front)
                End If
            End If
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub usermsg(msg As String, BColor As Color, FColor As Color)
        Dim lbl As Label = Me.Master.FindControl("MessageFooter")
        lbl.Text = msg
        lbl.BackColor = BColor
        lbl.ForeColor = FColor
    End Sub
    Protected Sub TxtAdd_Click(sender As Object, e As EventArgs) Handles TxtAdd.Click
        Dim dt1 As DataTable = DirectCast(ViewState("temptable"), DataTable)
        dt1.Rows.Add(TxtInstrument.Text, TxtRange.Text, TxtMake.Text, TxtModel.Text, TxtQty.Text, TxtCertType.Text, TxtPreCert.Text, TxtCalpts.Text)
        ViewState("temptable") = dt1
        GridView2.DataSource = DirectCast(ViewState("temptable"), DataTable)
        GridView2.DataBind()
        TxtInstrument.Text = String.Empty
        TxtRange.Text = String.Empty
        TxtMake.Text = String.Empty
        TxtModel.Text = String.Empty
        TxtQty.Text = String.Empty
        TxtCertType.Text = String.Empty
        TxtPreCert.Text = String.Empty
        TxtCalpts.Text = String.Empty
    End Sub
    Private Sub GridView2_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView2.RowCommand
        Dim index As Integer = Convert.ToInt32(e.CommandArgument)
        Dim dt2 As DataTable = DirectCast(ViewState("temptable"), DataTable)
        dt2.Rows(index).Delete()
        ViewState("temptable") = dt2
        GridView2.DataSource = DirectCast(ViewState("temptable"), DataTable)
        GridView2.DataBind()
    End Sub

    Protected Sub Save_Click(sender As Object, e As EventArgs) Handles Save.Click
        Try
            Dim dt3 As DataTable = DirectCast(ViewState("temptable"), DataTable)
            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "JobRequest_Insert"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("CId", COSkey.Text)
                sqlComm.Parameters.AddWithValue("Remarks", TxtNote.Text)
                sqlComm.Parameters.AddWithValue("DOR", TxtDOR.Text)
                sqlComm.Parameters.AddWithValue("JobNo", TxtJobNo.Text)
                sqlComm.Parameters.AddWithValue("PPE", ListPPE.Text)
                sqlComm.Parameters.AddWithValue("RA", TxtRisk.Text)
                sqlComm.Parameters.AddWithValue("Salesperson", TxtSalesperson.Text)
                sqlComm.Parameters.AddWithValue("Createduser", Session("Username"))
                sqlComm.Parameters.AddWithValue("Created", Now())
                sqlComm.Parameters.AddWithValue("Modifieduser", "NA")
                sqlComm.Parameters.AddWithValue("Modified", "NA")
                sqlComm.Parameters.AddWithValue("Status", "New")
                sqlComm.Parameters.AddWithValue("dt", dt3)
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("sitejobrequest.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub TxtClient_SelectedIndexChanged(sender As Object, e As EventArgs) Handles TxtClient.SelectedIndexChanged
        Try
            Dim strQuery As String
            strQuery = "select CId, [Address Line 1], [Address Line 2], [Address Line 3], (select Country from Countries where CountryID = Client.Country) as Country, PostalCode, Salutation, Contact, Telephone, Handphone, (select concat(FName, ' ', LName) from Employee where Eid = Client.[Caltek Sales]) as Salesperson, Remarks from Client Where Client = '" & TxtClient.Text & "'"
            Dim GetData As New GetdataSet()
            Dim SQLDataset As DataSet = GetData.GetDataset(strQuery)
            TxtAdd1.Text = SQLDataset.Tables(0).Rows(0).Item("Address Line 1").ToString()
            TxtAdd2.Text = SQLDataset.Tables(0).Rows(0).Item("Address Line 2").ToString()
            TxtAdd3.Text = SQLDataset.Tables(0).Rows(0).Item("Address Line 3").ToString()
            TxtCountry.Text = SQLDataset.Tables(0).Rows(0).Item("Country").ToString()
            Txtpostalcode.Text = SQLDataset.Tables(0).Rows(0).Item("PostalCode").ToString()
            TxtSal.SelectedValue = SQLDataset.Tables(0).Rows(0).Item("Salutation").ToString()
            TxtName.Text = SQLDataset.Tables(0).Rows(0).Item("Contact").ToString()
            TxtTel.Text = SQLDataset.Tables(0).Rows(0).Item("Telephone").ToString()
            TxtHP.Text = SQLDataset.Tables(0).Rows(0).Item("Handphone").ToString()
            TxtSalesperson.Text = SQLDataset.Tables(0).Rows(0).Item("Salesperson").ToString()
            TxtNote.Text = SQLDataset.Tables(0).Rows(0).Item("Remarks").ToString()
            COSkey.Text = SQLDataset.Tables(0).Rows(0).Item("CId").ToString()
            Save.Enabled = True
            Update.Enabled = False
            Cancel.Enabled = False
            Call usermsg("Message from COS: Client details loaded successfully", LocalCall.Success_Back, LocalCall.Success_Front)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Private Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView1.RowCommand
        Try
            Timecheck()
            Dim ID As Object = GridView1.Rows(Convert.ToInt32(e.CommandArgument)).Cells(1).Text
            Dim strQuery As String
            strQuery = "Select Id, (Select Client from Client Where CId = JobRequest.CId) as Client, DOR, JobNo, PPE, [Risk Assessment], (Select concat (FName, ' ', LName) from Employee Where Eid = JobRequest.Salesperson) as Salesperson, Remarks, Status from JobRequest Where ID = '" & ID & "';
                        Select Instrument, Range, Make, Model, Quantity, [Cert. Type], [Pre. Cert.], [Cal. Points] from JobRequestInstruments Where JRID = '" & ID & "'"
            Dim GetData As New GetdataSet()
            Dim SQLDataset As DataSet = GetData.GetDataset(strQuery)
            If SQLDataset.Tables(0).Rows(0).Item("Status").ToString() <> "Cancelled" Then
                If SQLDataset.Tables(0).Rows(0).Item("DOR").ToString() > Today() Then
                    TxtClient.Text = SQLDataset.Tables(0).Rows(0).Item("Client").ToString()
                    TxtDOR.Text = SQLDataset.Tables(0).Rows(0).Item("DOR").ToString()
                    TxtNote.Text = SQLDataset.Tables(0).Rows(0).Item("Remarks").ToString()
                    TxtRisk.Text = SQLDataset.Tables(0).Rows(0).Item("Risk Assessment").ToString()
                    TxtJobNo.Text = SQLDataset.Tables(0).Rows(0).Item("JobNo").ToString()
                    ListPPE.Text = SQLDataset.Tables(0).Rows(0).Item("PPE").ToString()
                    TxtClient_SelectedIndexChanged(e, e)
                    COSkey.Text = ID.ToString()
                    TxtClient.Enabled = False
                    GridView2.DataSource = SQLDataset.Tables(1)
                    GridView2.DataBind()
                    ViewState("temptable") = GridView2.DataSource
                    Save.Enabled = False
                    Update.Enabled = True
                    Cancel.Enabled = True
                    Call usermsg("Message from COS: Site job arrangement loaded successfully!!", LocalCall.Success_Back, LocalCall.Success_Front)
                Else
                    Call usermsg("Message from COS: The site job arrangement is too late to modify now!!", LocalCall.Failure_Back, LocalCall.Failure_Front)
                End If
            Else
                Call usermsg("Message from COS: The site job arrangement that you are trying to edit has already been cancelled!! Hence it cannot be edited!!", LocalCall.Failure_Back, LocalCall.Failure_Front)
            End If
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
                        TxtDOR.Attributes("min") = (Today.AddDays(2)).ToString("yyyy-MM-dd")
                    Else
                        TxtDOR.Attributes("min") = (Today.AddDays(1)).ToString("yyyy-MM-dd")
                    End If
                Case "2"
                    If Now.TimeOfDay.TotalSeconds >= (timecheckhour * 60 * 60) + (timecheckmin * 60) + timechecksec Then
                        TxtDOR.Attributes("min") = (Today.AddDays(4)).ToString("yyyy-MM-dd")
                    Else
                        TxtDOR.Attributes("min") = (Today.AddDays(3)).ToString("yyyy-MM-dd")
                    End If
            End Select
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Update_Click(sender As Object, e As EventArgs) Handles Update.Click
        Try
            Dim dt4 As DataTable = DirectCast(ViewState("temptable"), DataTable)
            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "JobRequest_Update"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("Id", COSkey.Text)
                sqlComm.Parameters.AddWithValue("Remarks", TxtNote.Text)
                sqlComm.Parameters.AddWithValue("DOR", TxtDOR.Text)
                sqlComm.Parameters.AddWithValue("JobNo", TxtJobNo.Text)
                sqlComm.Parameters.AddWithValue("PPE", ListPPE.Text)
                sqlComm.Parameters.AddWithValue("RA", TxtRisk.Text)
                sqlComm.Parameters.AddWithValue("Salesperson", TxtSalesperson.Text)
                sqlComm.Parameters.AddWithValue("Modifieduser", Session("Username"))
                sqlComm.Parameters.AddWithValue("Modified", Now())
                sqlComm.Parameters.AddWithValue("Status", "Modified")
                sqlComm.Parameters.AddWithValue("dt", dt4)
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("sitejobrequest.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Cancel_Click(sender As Object, e As EventArgs) Handles Cancel.Click
        Try
            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "JobRequest_Delete"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("Id", COSkey.Text)
                sqlComm.Parameters.AddWithValue("Modifieduser", Session("Username"))
                sqlComm.Parameters.AddWithValue("Modified", Now())
                sqlComm.Parameters.AddWithValue("Status", "Cancelled")
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("sitejobrequest.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Search_Click(sender As Object, e As EventArgs) Handles Search.Click
        Try
            Dim strQuery As String
            strQuery = "Select * from (Select Id, (Select Client from Client Where CId = JobRequest.CId) as Client, Concat(DAY([DOR]),'-',CONVERT(VARCHAR(3),Datename(month, [DOR])),'-',YEAR([DOR])) As [Requested Date], JobNo as [Job No.], PPE, [Risk Assessment], (Select concat (FName, ' ', LName) from Employee Where Eid = JobRequest.Salesperson) as Salesperson, Remarks, Status from JobRequest) As Overall Where [" + TxtSearch.Text + "] Like '%" & TxtKeyword.Text & "%'"
            Dim Getdata As New GetdataSet()
            Dim Sqldataset As DataSet = Getdata.GetDataset(strQuery)
            GridView1.DataSource = Sqldataset.Tables(0)
            GridView1.DataBind()
            Call usermsg(LocalCall.Search_Message, LocalCall.Success_Back, LocalCall.Success_Front)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub Export_Click(sender As Object, e As EventArgs) Handles Export.Click
        Try
            Dim ExporttoExcel As New Export
            Dim Filename As String = "Site Jobs_"
            ExporttoExcel.Export_Now(e, e, GridView1, Filename)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        ' Verifies that the control is rendered 
    End Sub

    Protected Sub Refresh_Click(sender As Object, e As EventArgs) Handles Refresh.Click
        Response.Redirect("sitejobrequest.aspx", False)
    End Sub
End Class