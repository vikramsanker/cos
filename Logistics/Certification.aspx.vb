﻿Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Imports System.Data
Imports System.Data.OleDb
Imports System.Configuration
Public Class Certification
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
                    lbl.Text = "CERTIFICATE STATUS"
                    Dim GetData As New GetdataSet()
                    Loadgrid()
                    'Dim SendCount As String = GetData.RowCount("select count(*) as Count from FocusData Where Id IN (Select ProductionID from worksheetreception Where [Allocated To] = (select EmpID from Usertable Where Username = '" & Session("Username") & "')) and ID NOT IN (select ProductionID from Certificatestatus Where Midstate = 0)") & " Record(s) Found"
                    Dim SendCount As String = GridView1.Rows.Count & " Record(s) Found"
                    Call usermsg(LocalCall.Load_Message, LocalCall.Success_Back, LocalCall.Success_Front, SendCount)
                End If
            End If
            Update.Enabled = False
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub Export_Click(sender As Object, e As EventArgs) Handles Export.Click
        Try
            Dim ExporttoExcel As New Export
            Dim Filename As String = "Certificate Status_"
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

    Public Sub Loadgrid()
        Dim GetData As New GetdataSet()
        GridView1.DataSource = GetData.GetDataset("Select Id as ID, TAT, [Delivery Type], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], Certification, [Certificate To], [Certificate Address] from FocusData 
                                            Where Id IN (Select ProductionID from worksheetreception Where [Allocated To] = (select EmpID from Usertable Where Username = '" & Session("Username") & "')) and ID NOT IN (select ProductionID from Certificatestatus Where Midstate = 0) ORDER by [TAT], [Date Received] ASC").Tables(0)
        GridView1.DataBind()
    End Sub

    Protected Sub Update_Click(sender As Object, e As EventArgs) Handles Update.Click
        Try
            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "Certificatestatus_Insert"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("@ProductionID", LblCOSKey.Text)
                sqlComm.Parameters.AddWithValue("@Certstatus", "Completed")
                sqlComm.Parameters.AddWithValue("@Date", Now())
                sqlComm.Parameters.AddWithValue("@Note", TxtNote.Text)
                sqlComm.Parameters.AddWithValue("@MidState", 0)
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("certification.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Private Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView1.RowCommand
        Try
            Dim ID As Object = GridView1.Rows(Convert.ToInt32(e.CommandArgument)).Cells(1).Text
            Dim strQuery As String
            strQuery = "Select Id as ID, [Job Number], [Client Name], Quantity, Instrument, [Cal. Interval], [Serial No], Certification, [Certificate To], [Certificate Address] from FocusData Where Id = '" & ID & "'"
            Dim GetData As New GetdataSet()
            Dim SQLDataset As DataSet = GetData.GetDataset(strQuery)
            LblCOSKey.Text = ID
            TxtJob.Text = SQLDataset.Tables(0).Rows(0).Item("Job Number").ToString()
            TxtClient.Text = SQLDataset.Tables(0).Rows(0).Item("Client Name").ToString()
            TxtInstrument.Text = SQLDataset.Tables(0).Rows(0).Item("Instrument").ToString()
            TxtSerialNo.Text = SQLDataset.Tables(0).Rows(0).Item("Serial No").ToString()
            TxtCertification.Text = SQLDataset.Tables(0).Rows(0).Item("Certification").ToString()
            TxtQuantity.Text = SQLDataset.Tables(0).Rows(0).Item("Quantity").ToString()
            TxtCertClient.Text = SQLDataset.Tables(0).Rows(0).Item("Certificate To").ToString()
            TxtCertAddress.Text = SQLDataset.Tables(0).Rows(0).Item("Certificate Address").ToString()
            Update.Enabled = True
            'Dim SendCount As String = GetData.RowCount("select count(*) as Count from FocusData Where Id IN (Select ProductionID from worksheetreception Where [Allocated To] = (select EmpID from Usertable Where Username = '" & Session("Username") & "')) and ID NOT IN (select ProductionID from Certificatestatus Where Midstate = 0)") & " Record(s) Found"
            Dim SendCount As String = GridView1.Rows.Count & " Record(s) Found"
            Call usermsg(LocalCall.Edit_Message, LocalCall.Progress_Back, LocalCall.Progress_Front, SendCount)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Refresh_Click(sender As Object, e As EventArgs) Handles Refresh.Click
        Response.Redirect("certification.aspx", False)
    End Sub

    Protected Sub Search_Click(sender As Object, e As EventArgs) Handles Search.Click
        Try
            If TxtOption.Text <> Nothing Then
                Dim GetData As New GetdataSet()
                GridView1.DataSource = GetData.GetDataset("Select Id as ID, TAT, [Delivery Type], CONVERT(Date, Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], Certification, [Certificate To], [Certificate Address] from FocusData 
                                            Where Id IN (Select ProductionID from worksheetreception Where [Allocated To] = (select EmpID from Usertable Where Username = '" & Session("Username") & "')) and ID NOT IN (select ProductionID from CertificateStatus Where Midstate = 0) AND [" & TxtOption.Text & "] Like '%" & TxtKeyword.Text & "%' ORDER by [TAT], [Date Received] ASC").Tables(0)
                GridView1.DataBind()
                'Dim SendCount As String = GetData.RowCount("select count(*) as Count from FocusData Where Id IN (Select ProductionID from worksheetreception Where [Allocated To] = (select EmpID from Usertable Where Username = '" & Session("Username") & "')) and ID NOT IN (select ProductionID from Certificatestatus Where Midstate = 0) AND [" & TxtOption.Text & "] Like '%" & TxtKeyword.Text & "%'") & " Record(s) Found"
                Dim SendCount As String = GridView1.Rows.Count & " Record(s) Found"
                Call usermsg("Search Successfull", LocalCall.Success_Back, LocalCall.Success_Front, SendCount)
            Else
                Call usermsg("Input Error: Select parameter from dropdown!!", LocalCall.Failure_Back, LocalCall.Failure_Front)
            End If
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
End Class