Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Imports System.Data
Imports System.Data.OleDb
Imports System.Configuration
Public Class Importproduction
    Inherits System.Web.UI.Page
    Private LocalCall As New GlobalVar
    Private sqlCon As SqlConnection

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            If Session("Username") Is Nothing Then
                Response.Redirect("LoginWindow.aspx")
            Else
                If Not Page.IsPostBack Then
                    Dim lbl As Label = Me.Master.FindControl("LblHeader")
                    lbl.Text = "RAW PRODUCTION SCHEDULE"
                    Dim GetData As New GetdataSet()
                    Loadgrid()
                    'Dim SendCount As String = GetData.RowCount("select count(*) as Count from FocusData Where ID NOT in (Select ProductionID from ProductionPlan)") & " Records(s) found"
                    Dim SendCount As String = GridView1.Rows.Count & " Records(s) found"
                    Call usermsg(LocalCall.Load_Message, LocalCall.Success_Back, LocalCall.Success_Front, SendCount)
                End If
            End If
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub Process_Click(sender As Object, e As EventArgs) Handles Process.Click
        Try
            If FileUpload1.HasFile Then
                Dim excelpath As String = LocalCall.LinkedserverPath1 + Path.GetFileName(FileUpload1.PostedFile.FileName)
                Dim strquery As String = "INSERT INTO FocusData SELECT * FROM OPENQUERY(" + LocalCall.Linkedserver + ", 'SELECT * FROM [Sheet1$]')"
                FileUpload1.SaveAs(excelpath)
                Using con As SqlConnection = New SqlConnection(LocalCall.ConString)
                    Using cmd As SqlCommand = New SqlCommand("Linked_CreateServer", con)
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@FileLocation", LocalCall.LinkedserverPath2 + Path.GetFileName(FileUpload1.PostedFile.FileName))
                        cmd.Parameters.AddWithValue("@LinkedServer", LocalCall.Linkedserver)
                        cmd.Parameters.AddWithValue("@UserID", LocalCall.Linkedserveruser)
                        cmd.Connection = con
                        con.Open()
                        cmd.ExecuteNonQuery()
                        con.Close()
                    End Using
                    Using cmd1 As SqlCommand = New SqlCommand(strquery, con)
                        cmd1.Connection = con
                        con.Open()
                        cmd1.ExecuteNonQuery()
                        con.Close()
                    End Using
                    Dim GetData As New GetdataSet()
                    Loadgrid()
                    'Dim SendCount As String = GetData.RowCount("select count(*) as Count from FocusData Where ID NOT in (Select ProductionID from ProductionPlan)") & " Records(s) found"
                    Dim SendCount As String = GridView1.Rows.Count & " Records(s) found"
                    Call usermsg("Message from COS: Data processed successfully!!", LocalCall.Success_Back, LocalCall.Success_Front, SendCount)
                End Using
            End If
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Export_Click(sender As Object, e As EventArgs) Handles Export.Click
        Try
            Dim ExporttoExcel As New Export
            Dim Filename As String = "Production Schedule_"
            ExporttoExcel.Export_Now(e, e, GridView1, Filename)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        ' Verifies that the control is rendered 
    End Sub
    Protected Sub usermsg(msg As String, BColor As Color, FColor As Color, Optional NCount As String = "0 Records(s) found")
        Dim lbl As Label = Me.Master.FindControl("MessageFooter")
        lbl.Text = msg
        LblCount.Text = NCount
        lbl.BackColor = BColor
        lbl.ForeColor = FColor
    End Sub

    Protected Sub ProdPlan_Click(sender As Object, e As EventArgs) Handles ProdPlan.Click
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
            For i As Integer = 0 To dt.Rows.Count - 1
                ToSend.Rows.Add(dt.Rows(i).ItemArray(0).ToString, Now())
            Next
            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "ProdPlan_Insert"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("@Dt", ToSend)
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Dim GetData As New GetdataSet()
            Loadgrid()
            'Dim SendCount As String = GetData.RowCount("select count(*) as Count from FocusData Where ID NOT in (Select ProductionID from ProductionPlan)") & " Records(s) found"
            Dim SendCount As String = GridView1.Rows.Count & " Records(s) found"
            Call usermsg(LocalCall.Load_Message, LocalCall.Success_Back, LocalCall.Success_Front, SendCount)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Clear_Click(sender As Object, e As EventArgs) Handles Clear.Click
        Response.Redirect("Importproduction.aspx", False)
    End Sub

    Public Sub Loadgrid()
        Dim GetData As New GetdataSet()
        GridView1.DataSource = GetData.GetDataset("Select Id as ID, TAT, [Delivery Type], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], Certification from FocusData 
Where Id NOT IN (Select ProductionID from ProductionPlan) AND TAT = 'Express' UNION
Select Id as ID, TAT, [Delivery Type], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], Certification from FocusData 
Where Id NOT IN (Select ProductionID from ProductionPlan) AND TAT = 'Semi Express' UNION
Select Id as ID, TAT, [Delivery Type], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], Certification from FocusData 
Where Id NOT IN (Select ProductionID from ProductionPlan) AND TAT = 'Normal'").Tables(0)
        GridView1.DataBind()
    End Sub

    Protected Sub Search_Click(sender As Object, e As EventArgs) Handles Search.Click
        Try
            If TxtOption.Text <> Nothing Then
                Dim GetData As New GetdataSet()
                GridView1.DataSource = GetData.GetDataset("Select top 100 Id as ID, TAT, [Delivery Type], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], Certification from FocusData 
                                            Where Id NOT IN (Select ProductionID from ProductionPlan) AND [" & TxtOption.Text & "] Like '%" & TxtKeyword.Text & "%' ORDER by [TAT], [Date Received]").Tables(0)
                GridView1.DataBind()
                'Dim SendCount As String = GetData.RowCount("select count(*) as Count from FocusData Where ID NOT in (Select ProductionID from ProductionPlan) AND [" & TxtOption.Text & "] Like '%" & TxtKeyword.Text & "%'") & " Records(s) found"
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
                sqlComm.CommandText = "Delete FocusData Where Id = '" + ID.ToString + "'"
                sqlComm.CommandType = CommandType.Text
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("Importproduction.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Delete_Click(sender As Object, e As EventArgs) Handles Delete.Click
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
            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "FocusData_Delete"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("@Dt", dt)
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Loadgrid()
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
End Class