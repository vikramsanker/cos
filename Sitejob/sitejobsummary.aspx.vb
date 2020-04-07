Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Public Class sitejobsummary
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
                    lbl.Text = "SITE JOB SUMMARY"
                    Dim Strquery As String = "Select EId, concat (EId, '-', FName, ' ', LName) as Name from Employee; 
                    Select Id, Client, [Requested Date], PPE, Salesperson, Status, Members from (Select Id, (Select Client from Client Where CId = JobRequest.CId) as Client, Concat(DAY([DOR]),'-',CONVERT(VARCHAR(3),Datename(month, [DOR])),'-',YEAR([DOR])) As [Requested Date], JobNo, PPE, [Risk Assessment], (Select concat (FName, ' ', LName) from Employee Where Eid = JobRequest.Salesperson) as Salesperson, Remarks, Status from JobRequest Where Status <> 'Cancelled') As Job
                    LEFT JOIN
                    (Select DISTINCT [Job ID], SUBSTRING((SELECT ',' + (Select concat (FName, ' ', LName) from Employee Where Eid = Sitejobassmtteam.EmpID) AS 'data()' FROM Sitejobassmtteam FOR XML PATH('')), 2 , 9999) As Members FROM Sitejobassmtteam) as Team
                    on Job.Id = Team.[Job ID]"
                    Dim Getdata As New GetdataSet()
                    Dim Sqldataset As DataSet = Getdata.GetDataset(Strquery)
                    Call usermsg("Message from COS: Site job assignment interface loaded successfully", LocalCall.Success_Back, LocalCall.Success_Front)
                End If
            End If
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Private Sub Calendar1_DayRender(sender As Object, e As DayRenderEventArgs) Handles Calendar1.DayRender
        Try
            Dim Strquery As String = "Select [Job ID], (Select Client from Client Where CId = (Select CId from JobRequest Where Id = [Job ID])) AS Client, (Select FNAme from Employee Where Eid = EmpID) As Name, DOR from (Select [Job Id], EmpID from Sitejobassmtteam) As A JOIN (Select Id, DOR from JobRequest) As B ON A.[Job ID] = B.Id"
            Dim Getdata As New GetdataSet()
            Dim Sqldataset As DataSet = Getdata.GetDataset(Strquery)
            For i = 0 To Sqldataset.Tables(0).Rows.Count - 1
                If e.Day.Date = Sqldataset.Tables(0).Rows(i).Item("DOR") Then
                    Dim Text1 As New Literal
                    Dim OldText As String = e.Cell.Text & ", " & Sqldataset.Tables(0).Rows(i).Item("Name") & " (" & Left(Sqldataset.Tables(0).Rows(i).Item("Client"), 10) & ")"
                    Text1.Text = OldText.ToString
                    Text1.Visible = True
                    e.Cell.Controls.Add(Text1)
                End If
            Next
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
End Class