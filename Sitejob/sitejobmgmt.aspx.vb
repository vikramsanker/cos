Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Public Class sitejobmgmt
    Inherits System.Web.UI.Page
    Private LocalCall As New GlobalVar
    Private sqlCon As SqlConnection
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Session("Username") Is Nothing Then
                Response.Redirect("LoginWindow.aspx")
            Else
                If Not Me.IsPostBack Then
                    Dim lbl As Label = Me.Master.FindControl("LblHeader")
                    lbl.Text = "SITE JOB ASSIGNMENT"
                    Dim Strquery As String = "Select EId, concat (EId, '-', FName, ' ', LName) as Name from Employee; 
                        Select Id, Client, [Requested Date], PPE, Salesperson, Status, Employee from 
                        (Select Id, (Select Client from Client Where CId = JobRequest.CId) as Client, Concat(DAY([DOR]),'-',CONVERT(VARCHAR(3),Datename(month, [DOR])),'-',YEAR([DOR])) As [Requested Date], JobNo, PPE, [Risk Assessment], (Select concat (FName, ' ', LName) from Employee Where Eid = JobRequest.Salesperson) as Salesperson, Remarks, Status from JobRequest Where Status <> 'Cancelled') 
                        As Job
                        LEFT JOIN
                        (Select [Job ID], STUFF((SELECT ', ' + (Select concat (FName, ' ', LName) from Employee Where Eid = EmpID) FROM Sitejobassmtteam WHERE ([Job ID] = Results.[Job ID]) 
                        FOR XML PATH(''),TYPE).value('(./text())[1]','VARCHAR(MAX)'),1,2,'') AS Employee FROM Sitejobassmtteam Results GROUP BY [Job ID]) 
                        As Team 
                        on Team.[Job ID] = Job.Id"
                    Dim Getdata As New GetdataSet()
                    Dim Sqldataset As DataSet = Getdata.GetDataset(Strquery)
                    TxtTeam.DataSource = Sqldataset.Tables(0)
                    TxtTeam.DataTextField = ("Name")
                    TxtTeam.DataValueField = ("EId")
                    TxtTeam.DataBind()
                    GridView1.DataSource = Sqldataset.Tables(1)
                    GridView1.DataBind()
                    Call usermsg("Message from COS: Site job assignment interface loaded successfully", LocalCall.Success_Back, LocalCall.Success_Front)
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

    Protected Sub Save_Click(sender As Object, e As EventArgs) Handles Save.Click
        Try
            Dim dt As New DataTable
            dt.Columns.Add(New DataColumn("JobID", GetType(String)))
            dt.Columns.Add(New DataColumn("Employee", GetType(String)))
            For Each item As ListItem In TxtTeam.Items
                If item.Selected Then
                    dt.Rows.Add(COSkey.Text, item.Value)
                End If
            Next
            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "JobAssignment_Insert"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("Id", COSkey.Text)
                sqlComm.Parameters.AddWithValue("MgrNote", TxtMgrNote.Text)
                sqlComm.Parameters.AddWithValue("dt", dt)
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("sitejobmgmt.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub TxtClient_SelectedIndexChanged(sender As Object, e As EventArgs)
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
            TxtSal.Text = SQLDataset.Tables(0).Rows(0).Item("Salutation").ToString()
            TxtName.Text = SQLDataset.Tables(0).Rows(0).Item("Contact").ToString()
            TxtTel.Text = SQLDataset.Tables(0).Rows(0).Item("Telephone").ToString()
            TxtHP.Text = SQLDataset.Tables(0).Rows(0).Item("Handphone").ToString()
            TxtSalesperson.Text = SQLDataset.Tables(0).Rows(0).Item("Salesperson").ToString()
            TxtNote.Text = SQLDataset.Tables(0).Rows(0).Item("Remarks").ToString()
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Private Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView1.RowCommand
        Try
            For Each item As ListItem In TxtTeam.Items
                item.Selected = False
            Next
            TxtDOR.Attributes("min") = (Today()).ToString("yyyy-MM-dd")
            Dim ID As Object = GridView1.Rows(Convert.ToInt32(e.CommandArgument)).Cells(1).Text
            Dim strQuery As String
            strQuery = "Select Id, (Select Client from Client Where CId = JobRequest.CId) as Client, DOR, JobNo, PPE, [Risk Assessment], (Select concat (FName, ' ', LName) from Employee Where Eid = JobRequest.Salesperson) as Salesperson, Remarks, Status from JobRequest Where ID = '" & ID & "';
                        Select Instrument, Range, Make, Model, Quantity, [Cert. Type], [Pre. Cert.], [Cal. Points] from JobRequestInstruments Where JRID = '" & ID & "';
                        Select EmpID from Sitejobassmtteam Where [Job ID] = '" & ID & "'"
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
                    GridView2.DataSource = SQLDataset.Tables(1)
                    GridView2.DataBind()
                    For Each item As ListItem In TxtTeam.Items
                        For i = 0 To SQLDataset.Tables(2).Rows.Count - 1
                            If item.Value = SQLDataset.Tables(2).Rows(i).Item("EmpID").ToString Then
                                item.Selected = True
                            End If
                        Next
                    Next
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
    Protected Sub Search_Click(sender As Object, e As EventArgs) Handles Search.Click
        Try
            Dim strQuery As String
            strQuery = "Select Id, Client, [Requested Date], PPE, Salesperson, Status, Employee from 
                        (Select Id, (Select Client from Client Where CId = JobRequest.CId) as Client, Concat(DAY([DOR]),'-',CONVERT(VARCHAR(3),Datename(month, [DOR])),'-',YEAR([DOR])) As [Requested Date], JobNo, PPE, [Risk Assessment], (Select concat (FName, ' ', LName) from Employee Where Eid = JobRequest.Salesperson) as Salesperson, Remarks, Status from JobRequest Where Status <> 'Cancelled') 
                        As Job
                        LEFT JOIN
                        (Select [Job ID], STUFF((SELECT ', ' + (Select concat (FName, ' ', LName) from Employee Where Eid = EmpID) FROM Sitejobassmtteam WHERE ([Job ID] = Results.[Job ID]) 
                        FOR XML PATH(''),TYPE).value('(./text())[1]','VARCHAR(MAX)'),1,2,'') AS Employee FROM Sitejobassmtteam Results GROUP BY [Job ID]) 
                        As Team 
                        on Team.[Job ID] = Job.Id
                        Where [" + TxtSearch.Text + "] Like '%" & TxtKeyword.Text & "%'"
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
        Response.Redirect("sitejobmgmt.aspx", False)
    End Sub
End Class