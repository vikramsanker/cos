Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Imports System.Data
Imports System.Configuration
Public Class Jobstatus
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
                    lbl.Text = "JOB STATUS ENQUIRY"
                    Call usermsg(LocalCall.Load_Message, LocalCall.Success_Back, LocalCall.Success_Front)
                End If
            End If
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub Export_Click(sender As Object, e As EventArgs) Handles Export.Click
        Try
            Dim ExporttoExcel As New Export
            Dim Filename As String = "Job Status_"
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

    Protected Sub Search_Click(sender As Object, e As EventArgs) Handles Search.Click
        Try
            If TxtOption.Text <> Nothing Then
                Dim GetData As New GetdataSet()
                GridView1.DataSource = GetData.GetDataset("Select 
                Focusdata.Id, 
                FocusData.Instrument, 
                FocusData.[Delivery Type],
                Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received],
                FocusData.[Job Number], 
                FocusData.[Client Name], 
                FocusData.Quantity, 
                FocusData.Department, 
                FocusData.[Serial No],
                Concat(DAY([Delivery Date]),'-',CONVERT(VARCHAR(3),Datename(month, [Delivery Date])),'-',YEAR([Delivery Date])) As [Delivery Date],
                FocusData.Certification,
                OVERALL.Status, OVERALL.[With] from FocusData JOIN 
                (Select ID AS ID, Status = 'Unplanned', [With] = 'Logistics Coordinator' from FocusData Where ID NOT IN (Select ProductionID from ProductionPlan)  UNION
                Select ProductionID as ID, Status = 'Planned but unassigned', [With] = 'Tech Mgmt.' from ProductionPlan Where ProductionID NOT IN (Select ProductionID from ProductionAssigned) UNION
                Select ProductionID AS ID, Status = 'Assigned', (Select concat (FName, ' ', LName) from Employee where Eid = ProductionAssigned.Employee) as [With] from ProductionAssigned Where ProductionID NOT IN (Select ProductionID from ProductionStatus) UNION
                Select ProductionID AS ID, Status = 'Calibrated', [With] = 'Logistics Coordinator' from ProductionStatus Where Status = 'Completed' And ProductionID NOT IN (Select ProductionID from CertificateStatus) UNION
                Select ProductionID AS ID, Status = ' Calibration On-hold', (Select (Select concat (FName, ' ', LName) from Employee where Eid = ProductionAssigned.Employee) from ProductionAssigned Where ProductionID = ProductionStatus.ProductionID) as [With] from ProductionStatus Where Status = 'On-hold' And ProductionID NOT IN (Select ProductionID from CertificateStatus) UNION
                Select ProductionID AS ID, Status = 'Certificate Completed', [With] = 'Signature In-Progress' from CertificateStatus Where [Certificate Status] = 'Completed' And ProductionID NOT IN (Select ProductionID from Deliveryplan) UNION
                Select ProductionID AS ID, Status = 'Certificate Incomplete', (Select concat (FName, ' ', LName) from Employee where Eid = [Allocated To]) as [With] from WorksheetReception Where ProductionID NOT IN (Select ProductionID from CertificateStatus) UNION
                Select ProductionID AS ID, Status = 'Cert. Incomp. Del. Planned', (Select concat (FName, ' ', LName) from Employee where Eid = [Allocated To]) as [With] from WorksheetReception Where ProductionID IN (Select ProductionID from CertificateStatus Where ProductionID NOT IN (Select ProductionID from CertificateStatus Where MidState = '0')) UNION
                Select ProductionID AS ID, Status = 'Delivery Planned', [With] = 'Ready for Delivery' from Deliveryplan Where ProductionID NOT IN (Select Id from FocusData Where [Job Number] IN (Select ID from Agentupdate Where Type = 'Delivery' and status = 'completed')) UNION
                Select ProductionID AS ID, Status = 'Delivered', [With] = 'Reached Customer' from Deliveryplan Where ProductionID NOT IN (Select Id from FocusData Where [Job Number] NOT IN (Select ID from Agentupdate Where Type = 'Delivery' and status = 'completed'))) AS OVERALL
                ON FocusData.Id = Overall.ID 
                Where [" & TxtOption.Text & "] Like '%" & TxtKeyword.Text & "%' ORDER by [Date Received] ASC").Tables(0)
                GridView1.DataBind()
                'Dim SendCount As String = GetData.RowCount("select count(*) as Count from FocusData JOIN 
                '(Select ID AS ID, Status = 'Unplanned', [With] = 'Logistics Coordinator' from FocusData Where ID NOT IN (Select ProductionID from ProductionPlan)  UNION
                'Select ProductionID as ID, Status = 'Planned but unassigned', [With] = 'Tech Mgmt.' from ProductionPlan Where ProductionID NOT IN (Select ProductionID from ProductionAssigned) UNION
                'Select ProductionID AS ID, Status = 'Assigned', (Select concat (FName, ' ', LName) from Employee where Eid = ProductionAssigned.Employee) as [With] from ProductionAssigned Where ProductionID NOT IN (Select ProductionID from ProductionStatus) UNION
                'Select ProductionID AS ID, Status = 'Calibrated', [With] = 'Logistics Coordinator' from ProductionStatus Where Status = 'Completed' And ProductionID NOT IN (Select ProductionID from CertificateStatus) UNION
                'Select ProductionID AS ID, Status = ' Calibration On-hold', (Select (Select concat (FName, ' ', LName) from Employee where Eid = ProductionAssigned.Employee) from ProductionAssigned Where ProductionID = ProductionStatus.ProductionID) as [With] from ProductionStatus Where Status = 'On-hold' And ProductionID NOT IN (Select ProductionID from CertificateStatus) UNION
                'Select ProductionID AS ID, Status = 'Certificate Completed', [With] = 'Signature In-Progress' from CertificateStatus Where [Certificate Status] = 'Completed' And ProductionID NOT IN (Select ProductionID from Deliveryplan) UNION
                'Select ProductionID AS ID, Status = 'Certificate Incomplete', (Select concat (FName, ' ', LName) from Employee where Eid = [Allocated To]) as [With] from WorksheetReception Where ProductionID NOT IN (Select ProductionID from CertificateStatus) UNION
                'Select ProductionID AS ID, Status = 'Cert. Incomp. Del. Planned', (Select concat (FName, ' ', LName) from Employee where Eid = [Allocated To]) as [With] from WorksheetReception Where ProductionID IN (Select ProductionID from CertificateStatus Where ProductionID NOT IN (Select ProductionID from CertificateStatus Where MidState = '0')) UNION                
                'Select ProductionID AS ID, Status = 'Delivery Planned', [With] = 'Ready for Delivery' from Deliveryplan) AS OVERALL
                'ON FocusData.Id = Overall.ID 
                'Where [" & TxtOption.Text & "] Like '%" & TxtKeyword.Text & "%'") & " Records(s) Found"
                Dim SendCount As String = GridView1.Rows.Count & " Records(s) found"
                Call usermsg("Search Successfull", LocalCall.Success_Back, LocalCall.Success_Front, SendCount)
            Else
                Call usermsg("Input Error: Select parameter from dropdown!!", LocalCall.Failure_Back, LocalCall.Failure_Front)
            End If
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Refresh_Click(sender As Object, e As EventArgs) Handles Refresh.Click
        Response.Redirect("jobstatus.aspx")
    End Sub
End Class