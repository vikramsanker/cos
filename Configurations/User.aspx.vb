Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Public Class User
    Inherits System.Web.UI.Page
    Private LocalCall As New GlobalVar
    Private sqlCon As SqlConnection

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Session("Username") Is Nothing Then
                Response.Redirect("LoginWindow.aspx")
            Else
                If Not IsPostBack Then
                    Dim lbl As Label = Me.Master.FindControl("LblHeader")
                    lbl.Text = "USER MANAGEMENT"
                    Searchbox.Attributes.Add("onkeydown", "return (event.keyCode!=13);")
                    Panel5.DefaultButton = "SearchButton"
                    Dim strQuery As String
                    strQuery = "select UId, EmpID, (select concat (FName, ' ', LName) from Employee where EID = EmpID) as Employee, Username, (select role from role where rid = Usertable.Role) as Role from Usertable; select concat(Eid,'-',FName,' ',LName) as Name from Employee; select role from role"
                    Dim Getdata As New GetdataSet()
                    Dim Sqldataset As DataSet = Getdata.GetDataset(strQuery)
                    GridView1.DataSource = Sqldataset.Tables(0)
                    GridView1.DataBind()
                    TxtEmployee.DataSource = Sqldataset.Tables(1)
                    TxtEmployee.DataTextField = "Name"
                    TxtEmployee.DataBind()
                    TxtRole.DataSource = Sqldataset.Tables(2)
                    TxtRole.DataTextField = "Role"
                    TxtRole.DataBind()
                    'Dim SendCount As String = Getdata.RowCount("select count(*) as Count from Usertable") & " Record(s) Found"
                    Dim SendCount As String = GridView1.Rows.Count & " Record(s) Found"
                    Save.Enabled = True
                    Update.Enabled = False
                    Delete.Enabled = False
                    Call usermsg(LocalCall.Load_Message, LocalCall.Success_Back, LocalCall.Success_Front, SendCount)
                End If
            End If
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Private Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView1.RowCommand
        Try
            Dim wrapper As New Simple3Des(LocalCall.Key)
            Dim ID As Object = GridView1.Rows(Convert.ToInt32(e.CommandArgument)).Cells(1).Text
            Dim strQuery As String
            strQuery = "select (select concat(Eid,'-',FName,' ',LName) from Employee where Eid = Usertable.EmpID) as Employee, Username, (select role from Role where rid=Usertable.Role) as Role, Password from Usertable Where UID = '" & ID & "'"
            Dim GetData As New GetdataSet()
            Dim SQLDataset As DataSet = GetData.GetDataset(strQuery)
            COSkey.Text = ID.ToString()
            TxtEmployee.Text = SQLDataset.Tables(0).Rows(0).Item("Employee").ToString()
            UnameText.Text = SQLDataset.Tables(0).Rows(0).Item("Username").ToString()
            PwdText.Text = wrapper.DecryptData(SQLDataset.Tables(0).Rows(0).Item("Password").ToString())
            RPwdText.Text = wrapper.DecryptData(SQLDataset.Tables(0).Rows(0).Item("Password").ToString())
            TxtRole.Text = SQLDataset.Tables(0).Rows(0).Item("Role").ToString()
            Save.Enabled = False
            Update.Enabled = True
            Delete.Enabled = True
            TxtEmployee.Enabled = False
            'Dim SendCount As String = GetData.RowCount("select count(*) as Count from Usertable") & " Record(s) Found"
            Dim SendCount As String = GridView1.Rows.Count & " Record(s) Found"
            Call usermsg(LocalCall.Edit_Message, LocalCall.Progress_Back, LocalCall.Progress_Front, SendCount)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Save_Click(sender As Object, e As EventArgs) Handles Save.Click
        Try
            If PwdText.Text = RPwdText.Text Then
                Dim wrapper As New Simple3Des(LocalCall.Key)
                sqlCon = New SqlConnection(LocalCall.ConString)
                Using (sqlCon)
                    Dim sqlComm As New SqlCommand()
                    sqlComm.Connection = sqlCon
                    sqlComm.CommandText = "Usertable_Insert"
                    sqlComm.CommandType = CommandType.StoredProcedure
                    sqlComm.Parameters.AddWithValue("Employeename", TxtEmployee.Text)
                    sqlComm.Parameters.AddWithValue("Rolename", TxtRole.Text)
                    sqlComm.Parameters.AddWithValue("Password", wrapper.EncryptData(PwdText.Text))
                    sqlComm.Parameters.AddWithValue("Username", UnameText.Text)
                    sqlCon.Open()
                    sqlComm.ExecuteNonQuery()
                    sqlCon.Close()
                    Response.Redirect("User.aspx", False)
                End Using
            Else
                Call usermsg("Fatal Error: Passwords do not match", LocalCall.Failure_Back, LocalCall.Failure_Front)
            End If
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Update_Click(sender As Object, e As EventArgs) Handles Update.Click
        Try
            If PwdText.Text = RPwdText.Text Then
                Dim wrapper As New Simple3Des(LocalCall.Key)
                sqlCon = New SqlConnection(LocalCall.ConString)
                Using (sqlCon)
                    Dim sqlComm As New SqlCommand()
                    sqlComm.Connection = sqlCon
                    sqlComm.CommandText = "Usertable_Update"
                    sqlComm.CommandType = CommandType.StoredProcedure
                    sqlComm.Parameters.AddWithValue("Uid", COSkey.Text)
                    sqlComm.Parameters.AddWithValue("Username", UnameText.Text)
                    sqlComm.Parameters.AddWithValue("Password", wrapper.EncryptData(PwdText.Text))
                    sqlComm.Parameters.AddWithValue("Role", TxtRole.SelectedValue)
                    sqlCon.Open()
                    sqlComm.ExecuteNonQuery()
                    sqlCon.Close()
                    Response.Redirect("User.aspx", False)
                End Using
            Else
                Call usermsg("Fatal Error: Passwords do not match", LocalCall.Failure_Back, LocalCall.Failure_Front)
            End If
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Clear_Click(sender As Object, e As EventArgs) Handles Clear.Click
        Response.Redirect("User.aspx", False)
    End Sub

    Protected Sub SearchButton_Click(sender As Object, e As EventArgs) Handles SearchButton.Click
        Try
            Dim strQuery As String
            strQuery = "select UId, EmpID, (select concat (FName, ' ', LName) from Employee where EID = EmpID) as Employee, Username, (select role from role where rid = Usertable.Role) as Role 
                        from Usertable
                        Where 
                        concat (UId, EmpID,
                        (select concat (FName, ' ', LName) from Employee where EID = EmpID), 
                        Username, 
                        (select role from role where rid = Usertable.Role)) Like '%" & Searchbox.Text & "%'"
            Dim Getdata As New GetdataSet()
            Dim Sqldataset As DataSet = Getdata.GetDataset(strQuery)
            GridView1.DataSource = Sqldataset.Tables(0)
            GridView1.DataBind()
            'Dim SendCount As String = Getdata.RowCount("select count(*) as Count from Usertable Where 
            '                                            concat (UId, EmpID, (select concat (FName, ' ', LName) from Employee where EID = EmpID), Username, (select role from role where rid = Usertable.Role)) Like '%" & Searchbox.Text & "%'") & " Record(s) Found"
            Dim SendCount As String = GridView1.Rows.Count & " Record(s) Found"
            Call usermsg(LocalCall.Edit_Message, LocalCall.Progress_Back, LocalCall.Progress_Front, SendCount)
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
                sqlComm.CommandText = "Usertable_Delete"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("Uid", COSkey.Text)
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("User.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Export_Click(sender As Object, e As EventArgs) Handles Export.Click
        Try
            Dim ExporttoExcel As New Export
            Dim Filename As String = "Users_"
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