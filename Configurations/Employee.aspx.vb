Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Public Class Employee
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
                    lbl.Text = "EMPLOYEE MANAGEMENT"
                    Dim strQuery As String
                    strQuery = "select Eid, Fname, MName, LName, EmailID, (select Department from Department where DId = Employee.Department) as Department, 
                                Gender, (select role from role where rid = Employee.Role) as Role, Status, Concat(DAY([DOB]),'-',CONVERT(VARCHAR(3),Datename(month, [DOB])),'-',YEAR([DOB])) As [DOB] from Employee; select DId, Department from Department; select rid, role from role"
                    Dim Getdata As New GetdataSet()
                    Dim Sqldataset As DataSet = Getdata.GetDataset(strQuery)
                    GridView1.DataSource = Sqldataset.Tables(0)
                    GridView1.DataBind()
                    Department.DataSource = Sqldataset.Tables(1)
                    Department.DataTextField = "Department"
                    Department.DataBind()
                    Role.DataSource = Sqldataset.Tables(2)
                    Role.DataTextField = "Role"
                    Role.DataBind()
                    Save.Enabled = True
                    Update.Enabled = False
                    Delete.Enabled = False
                    'Dim SendCount As String = Getdata.RowCount("select count(*) as Count from Employee") & " Record(s) Found"
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
            strQuery = "select Eid, Fname, MName, LName, EmailID, (select Department from Department where DId = Employee.Department) as Department, 
            Gender, (select role from role where rid = Employee.Role) as Role, Status, DOB from Employee
                                    Where EID = '" & ID & "'"
            Dim GetData As New GetdataSet()
            Dim SQLDataset As DataSet = GetData.GetDataset(strQuery)
            EID.Text = SQLDataset.Tables(0).Rows(0).Item("Eid").ToString()
            FName.Text = SQLDataset.Tables(0).Rows(0).Item("FName").ToString()
            MName.Text = SQLDataset.Tables(0).Rows(0).Item("MName").ToString()
            LName.Text = SQLDataset.Tables(0).Rows(0).Item("LName").ToString()
            EmailID.Text = SQLDataset.Tables(0).Rows(0).Item("EmailID").ToString()
            Department.SelectedValue = SQLDataset.Tables(0).Rows(0).Item("Department").ToString()
            Gender.Text = SQLDataset.Tables(0).Rows(0).Item("Gender").ToString()
            Role.Text = SQLDataset.Tables(0).Rows(0).Item("Role").ToString()
            Status.Text = SQLDataset.Tables(0).Rows(0).Item("Status").ToString()
            DOB.Text = SQLDataset.Tables(0).Rows(0).Item("DOB").ToString()
            Save.Enabled = False
            Update.Enabled = True
            Delete.Enabled = True
            EID.Enabled = False
            'Dim SendCount As String = GetData.RowCount("select count(*) as Count from Employee") & " Record(s) Found"
            Dim SendCount As String = GridView1.Rows.Count & " Record(s) Found"
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
                sqlComm.CommandText = "Insertintoemployee"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("Eid", EID.Text)
                sqlComm.Parameters.AddWithValue("FName", FName.Text)
                sqlComm.Parameters.AddWithValue("LName", LName.Text)
                sqlComm.Parameters.AddWithValue("MName", MName.Text)
                sqlComm.Parameters.AddWithValue("EmailID", EmailID.Text)
                sqlComm.Parameters.AddWithValue("Gender", Gender.Text)
                sqlComm.Parameters.AddWithValue("Department", Department.Text)
                sqlComm.Parameters.AddWithValue("Role", Role.Text)
                sqlComm.Parameters.AddWithValue("Status", Status.Text)
                sqlComm.Parameters.AddWithValue("DOB", DOB.Text)
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("Employee.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub Clear_Click(sender As Object, e As EventArgs) Handles Clear.Click
        Response.Redirect("Employee.aspx", False)
    End Sub
    Protected Sub Update_Click(sender As Object, e As EventArgs) Handles Update.Click
        Try
            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "UpdateEmployee"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("Eid", EID.Text)
                sqlComm.Parameters.AddWithValue("FName", FName.Text)
                sqlComm.Parameters.AddWithValue("LName", LName.Text)
                sqlComm.Parameters.AddWithValue("MName", MName.Text)
                sqlComm.Parameters.AddWithValue("EmailID", EmailID.Text)
                sqlComm.Parameters.AddWithValue("Gender", Gender.Text)
                sqlComm.Parameters.AddWithValue("Department", Department.Text)
                sqlComm.Parameters.AddWithValue("Role", Role.Text)
                sqlComm.Parameters.AddWithValue("Status", Status.Text)
                sqlComm.Parameters.AddWithValue("DOB", DOB.Text)
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("Employee.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub SearchButton_Click(sender As Object, e As EventArgs) Handles SearchButton.Click
        Try
            Dim strQuery As String
            strQuery = "select Eid, Fname, MName, LName, EmailID, (select Department from Department where DId = Employee.Department) as Department, 
            Gender, (select role from role where rid = Employee.Role) as Role, Status, Concat(DAY([DOB]),'-',CONVERT(VARCHAR(3),Datename(month, [DOB])),'-',YEAR([DOB])) As [DOB] from Employee
                                    Where 
                                    concat (EId,
                                    FName, MName, LName, EmailID, 
                    (select Department from Department where DId = Employee.Department), Gender, 
                    (select role from role where rid = Employee.Role), Status) Like '%" & Searchbox.Text & "%'"
            Dim Getdata As New GetdataSet()
            Dim Sqldataset As DataSet = Getdata.GetDataset(strQuery)
            GridView1.DataSource = Sqldataset.Tables(0)
            GridView1.DataBind()
            'Dim SendCount As String = Getdata.RowCount("select count(*) as Count from Employee Where 
            '                                            concat (Eid, Fname, MName, LName, EmailID, (select Department from Department where DId = Employee.Department), 
            'Gender, (select role from role where rid = Employee.Role), Status) Like '%" & Searchbox.Text & "%'") & " Record(s) Found"
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
                sqlComm.CommandText = "DeleteEmployee"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("Eid", EID.Text)
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("Employee.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub Export_Click(sender As Object, e As EventArgs) Handles Export.Click
        Try
            Dim ExporttoExcel As New Export
            Dim Filename As String = "Employee_"
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