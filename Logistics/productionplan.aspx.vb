Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Imports System.Data
Imports System.Data.OleDb
Imports System.Configuration
Public Class productionplan
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
                    lbl.Text = "PRODUCTION PLAN"
                    Dim GetData As New GetdataSet()
                    TxtCO.DataSource = GetData.GetDataset("select concat(Eid,'-',FName,' ',LName) as Name from Employee Where Department IN (Select DId from Department where Division = 'Technical')").Tables(0)
                    TxtCO.DataTextField = "Name"
                    TxtCO.DataBind()
                    Loadgrid()
                    'Dim SendCount As String = GetData.RowCount("select count(*) as Count from FocusData Where ID in (Select ProductionID from ProductionPlan) And Id NOT IN (Select ProductionID from ProductionAssigned)") & " Record(s) Found"
                    Dim SendCount As String = GridView1.Rows.Count & " Records(s) found"
                    Call usermsg(LocalCall.Load_Message, LocalCall.Success_Back, LocalCall.Success_Front, SendCount)
                End If
            End If
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Assign_Click(sender As Object, e As EventArgs) Handles Assign.Click
        Try
            Dim dt As New DataTable
            dt.Columns.Add("ProductionID", GetType(String))
            For i As Integer = GridView1.Rows.Count - 1 To 0 Step -1
                If GridView1.Rows(i).RowType = DataControlRowType.DataRow Then
                    Dim chkRow As CheckBox = TryCast(GridView1.Rows(i).Cells(0).FindControl("cbselect"), CheckBox)
                    If chkRow.Checked Then
                        Dim ProductionID As String = GridView1.Rows(i).Cells(2).Text
                        dt.Rows.Add(ProductionID)
                    End If
                End If
            Next
            Dim ToSend As New DataTable()
            ToSend.Columns.Add("ProductionID", GetType(Integer))
            ToSend.Columns.Add("Date", GetType(String))
            ToSend.Columns.Add("Employee", GetType(String))
            For i As Integer = 0 To dt.Rows.Count - 1
                ToSend.Rows.Add(dt.Rows(i).ItemArray(0).ToString(), Now(), TxtCO.Text)
            Next
            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "ProdAssigned_Insert"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("@Dt", ToSend)
                sqlComm.Parameters.AddWithValue("@Employee", TxtCO.Text)
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Loadgrid()
            Dim Getdata As New GetdataSet()
            Dim SendCount As String = GridView1.Rows.Count & " Records(s) found"
            'Dim SendCount As String = Getdata.RowCount("select count(*) as Count from FocusData Where ID in (Select ProductionID from ProductionPlan) And Id NOT IN (Select ProductionID from ProductionAssigned)") & " Record(s) Found"
            Call usermsg(LocalCall.Load_Message, LocalCall.Success_Back, LocalCall.Success_Front, SendCount)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub Export_Click(sender As Object, e As EventArgs) Handles Export.Click
        Try
            Dim ExporttoExcel As New Export
            Dim Filename As String = "Production Plan_"
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
        GridView1.DataSource = GetData.GetDataset("Select Id as ID, TAT, [Delivery Type], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], Certification from FocusData 
                                            Where Id IN (Select ProductionID from ProductionPlan) And Id NOT IN (Select ProductionID from ProductionAssigned) ORDER by [TAT], [Date Received] ASC ").Tables(0)
        GridView1.DataBind()
    End Sub

    Protected Sub Refresh_Click(sender As Object, e As EventArgs) Handles Refresh.Click
        Response.Redirect("productionplan.aspx", False)
    End Sub

    Protected Sub Search_Click(sender As Object, e As EventArgs) Handles Search.Click
        Try
            If TxtOption.Text <> Nothing Then
                Dim GetData As New GetdataSet()
                GridView1.DataSource = GetData.GetDataset("Select Id as ID, TAT, [Delivery Type], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], Certification from FocusData 
                                            Where Id IN (Select ProductionID from ProductionPlan) And Id NOT IN (Select ProductionID from ProductionAssigned) AND [" & TxtOption.Text & "] Like '%" & TxtKeyword.Text & "%' ORDER by [TAT], [Date Received] ASC").Tables(0)
                GridView1.DataBind()
                'Dim SendCount As String = GetData.RowCount("select count(*) as Count from FocusData Where Id IN (Select ProductionID from ProductionPlan) And Id NOT IN (Select ProductionID from ProductionAssigned) AND [" & TxtOption.Text & "] Like '%" & TxtKeyword.Text & "%'") & " Record(s) Found"
                Dim SendCount As String = GridView1.Rows.Count & " Records(s) found"
                Call usermsg("Search Successfull", LocalCall.Success_Back, LocalCall.Success_Front, SendCount)
            Else
                Call usermsg("Input Error: Select parameter from dropdown!!", LocalCall.Failure_Back, LocalCall.Failure_Front)
            End If
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
                sqlComm.CommandText = "Delete Productionplan Where ProductionID = '" + ID.ToString + "'"
                sqlComm.CommandType = CommandType.Text
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("productionplan.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
End Class