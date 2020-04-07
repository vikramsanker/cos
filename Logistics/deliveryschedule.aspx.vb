Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Imports System.Data
Imports System.Data.OleDb
Imports System.Configuration
Public Class deliveryschedule
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
                    lbl.Text = "COMMIT DELIVERY"
                    TxtDDate.Attributes("min") = Today().ToString("yyyy-MM-dd")
                    Dim GetData As New GetdataSet()
                    Dim Dt As DataSet = GetData.GetDataset("select Vendor from Vendor; 
                                    Select DISTINCT [Job Number] from FocusData Where Id in (Select ProductionID from Deliveryplan) and [Job Number] NOT IN (Select JobID from DeliveryRemarks); 
                                    Select JobID from DeliveryRemarks")
                    TxtAgent.DataSource = Dt.Tables(0)
                    TxtAgent.DataTextField = "Vendor"
                    TxtAgent.DataBind()
                    TxtJobRemarks.DataSource = Dt.Tables(1)
                    TxtJobRemarks.DataTextField = "Job Number"
                    TxtJobRemarks.DataBind()
                    TxtJobSelect.DataSource = Dt.Tables(2)
                    TxtJobSelect.DataTextField = "JobID"
                    TxtJobSelect.DataBind()
                    Loadgrid()
                    'Dim SendCount As String = GetData.RowCount("select count(*) as Count from FocusData Where Id IN (Select ProductionID from Deliveryplan)") & " Record(s) Found"
                    LblCount.Text = GridView1.Rows.Count & " Record(s) Found"
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
            Dim Filename As String = "Delivery Schedule_"
            ExporttoExcel.Export_Now(e, e, GridView1, Filename)
            Dim Filename1 As String = "Collection Schedule_"
            ExporttoExcel.Export_Now(e, e, GridView2, Filename1)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        ' Verifies that the control is rendered 
    End Sub
    Protected Sub usermsg(msg As String, BColor As Color, FColor As Color)
        Dim lbl As Label = Me.Master.FindControl("MessageFooter")
        lbl.Text = msg
        lbl.BackColor = BColor
        lbl.ForeColor = FColor
    End Sub
    Public Sub Loadgrid()
        Try
            Dim GetData As New GetdataSet()
            GridView1.DataSource = GetData.GetDataset("Select Id as ID, Concat(DAY([DDate]),'-',CONVERT(VARCHAR(3),Datename(month, [DDate])),'-',YEAR([DDate])) As [Delivery date], T.[Certificate Status], (Select Vendor from Vendor Where VID = Deliveryplan.Agent) As Agent, [Deliver To], [Delivery Address], DeliveryRemarks.Remarks, Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name] 
                                from FocusData Join Deliveryplan on FocusData.Id = Deliveryplan.ProductionID LEFT Join DeliveryRemarks on FocusData.[Job Number] = DeliveryRemarks.JobID
                                Join (Select * from CertificateStatus Where CONCAT(ProductionID, '-', MidState) IN (Select CONCAT(ProductionID, '-', MIN(MidState)) from CertificateStatus GROUP by ProductionID)) as T on FocusData.Id=T.ProductionID 
                                Where FocusData.Id IN (Select ProductionID from Deliveryplan) And FocusData.[Job Number] NOT IN (Select ID from Agentupdate Where Type = 'Delivery' and status = 'completed')").Tables(0)
            GridView1.DataBind()
            LblCount.Text = GridView1.Rows.Count & " Record(s) Found"
            GridView2.DataSource = GetData.GetDataset("Select CollectionID, Concat(DAY(DOC),'-',CONVERT(VARCHAR(3),Datename(month, DOC)),'-',YEAR(DOC)) As [Collection Date], (Select Vendor from Vendor Where VID = Collection.Transporter) As Agent, Client, CONCAT([Address Line 1], ' ', [Address Line 2], ' ',[Address Line 3], ' ',(Select Country from Countries Where CountryId=Collection.Country), ' ', PostalCode) as Address, Note from Collection Where NOT [Status]='Deleted'
                                    And CollectionId NOT IN (Select ID from Agentupdate Where Type = 'Collection' and Status = 'Completed')").Tables(0)
            GridView2.DataBind()
            LblCollectionCount.Text = GridView2.Rows.Count & " Record(s) Found"
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Refresh_Click(sender As Object, e As EventArgs) Handles Refresh.Click
        Response.Redirect("deliveryschedule.aspx", False)
    End Sub

    Protected Sub Collectionsearch_Click(sender As Object, e As EventArgs) Handles Collectionsearch.Click
        Try
            Dim GetData As New GetdataSet()
            GridView2.DataSource = GetData.GetDataset("Select * from (Select CollectionID as [Collection ID], Concat(DAY(DOC),'-',CONVERT(VARCHAR(3),Datename(month, DOC)),'-',YEAR(DOC)) As [Collection Date], Client, CONCAT([Address Line 1], ' ', [Address Line 2], ' ',[Address Line 3], ' ',(Select Country from Countries Where CountryId=Collection.Country), ' ', PostalCode) as Address, Note from Collection) As Temp
                                Where Temp.[" & TxtCollectionOption.Text & "] Like '%" & TxtCollectionKeyword.Text & "%'").Tables(0)
            GridView2.DataBind()
            LblCollectionCount.Text = GridView2.Rows.Count & " Record(s) Found"
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Private Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView1.RowCommand
        Try
            Dim ID As Object = GridView1.Rows(Convert.ToInt32(e.CommandArgument)).Cells(2).Text
            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "Delete Deliveryplan Where ProductionID = '" + ID.ToString + "'"
                sqlComm.CommandType = CommandType.Text
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("deliveryschedule.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Commit_Click(sender As Object, e As EventArgs) Handles Commit.Click
        Try
            Dim dt As New DataTable
            dt.Columns.Add("ProductionID", GetType(String))
            For i As Integer = GridView1.Rows.Count - 1 To 0 Step -1
                If GridView1.Rows(i).RowType = DataControlRowType.DataRow Then
                    Dim chkRow As CheckBox = TryCast(GridView1.Rows(i).Cells(1).FindControl("cbselect2"), CheckBox)
                    If chkRow.Checked Then
                        Dim ProductionID As String = GridView1.Rows(i).Cells(2).Text
                        dt.Rows.Add(ProductionID)
                    End If
                End If
            Next

            Dim dt1 As New DataTable
            dt1.Columns.Add("ProductionID", GetType(String))
            For i As Integer = GridView2.Rows.Count - 1 To 0 Step -1
                If GridView2.Rows(i).RowType = DataControlRowType.DataRow Then
                    Dim chkRow As CheckBox = TryCast(GridView2.Rows(i).Cells(0).FindControl("cbselect"), CheckBox)
                    If chkRow.Checked Then
                        Dim ProductionID As String = GridView2.Rows(i).Cells(1).Text
                        dt1.Rows.Add(ProductionID)
                    End If
                End If
            Next

            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "DeliveryplanAgent_Update"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("@Dt", dt)
                sqlComm.Parameters.AddWithValue("@Dt1", dt1)
                sqlComm.Parameters.AddWithValue("@Agent", TxtAgent.Text)
                sqlComm.Parameters.AddWithValue("@DDate", TxtDDate.Text)
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Loadgrid()
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Add_Click(sender As Object, e As EventArgs) Handles Add.Click
        Try
            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "Insert into DeliveryRemarks Values ('" & TxtJobRemarks.Text & "', '" & TxtDeliveryRemarks.Text & "')"
                sqlComm.CommandType = CommandType.Text
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
                Refresh_Click(e, e)
            End Using
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub TxtJobSelect_SelectedIndexChanged(sender As Object, e As EventArgs) Handles TxtJobSelect.SelectedIndexChanged
        Try
            Dim GetData As New GetdataSet()
            Dim SQLDataset As DataSet = GetData.GetDataset("Select Remarks from DeliveryRemarks Where JobID = '" + TxtJobSelect.Text + "'")
            TxtUpRemarks.Text = SQLDataset.Tables(0).Rows(0).Item("Remarks").ToString()
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Update_Click(sender As Object, e As EventArgs) Handles Update.Click
        Try
            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "Update DeliveryRemarks Set Remarks = '" & TxtUpRemarks.Text & "' Where JobID = '" & TxtJobSelect.Text & "'"
                sqlComm.CommandType = CommandType.Text
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
                Refresh_Click(e, e)
            End Using
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Search_Click(sender As Object, e As EventArgs) Handles Search.Click
        Try
            Dim GetData As New GetdataSet()
            GridView1.DataSource = GetData.GetDataset("Select * from (Select Id as ID, Concat(DAY([DDate]),'-',CONVERT(VARCHAR(3),Datename(month, [DDate])),'-',YEAR([DDate])) As [Delivery date], T.[Certificate Status], (Select Vendor from Vendor Where VID = Deliveryplan.Agent) As Agent, [Deliver To], [Delivery Address], DeliveryRemarks.Remarks, Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name] 
                                from FocusData Join Deliveryplan on FocusData.Id = Deliveryplan.ProductionID LEFT Join DeliveryRemarks on FocusData.[Job Number] = DeliveryRemarks.JobID
                                Join (Select * from CertificateStatus Where CONCAT(ProductionID, '-', MidState) IN (Select CONCAT(ProductionID, '-', MIN(MidState)) from CertificateStatus GROUP by ProductionID)) as T on FocusData.Id=T.ProductionID 
                                Where FocusData.Id IN (Select ProductionID from Deliveryplan)) AS OVERALL Where OVERALL.[" & TxtOption.Text & "] Like '%" & TxtKeyword.Text & "%'").Tables(0)
            GridView1.DataBind()
            LblCount.Text = GridView1.Rows.Count & " Record(s) Found"
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
End Class