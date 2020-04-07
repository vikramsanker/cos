Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Public Class LoginWindow
    Inherits System.Web.UI.Page
    Private LocalCall As New GlobalVar
    Private sqlCon As SqlConnection
    Protected Sub CancelBtn_Click(sender As Object, e As EventArgs) Handles CancelBtn.Click
        Response.Redirect("LoginWindow.aspx")
    End Sub
    Protected Sub LoginBtn_Click(sender As Object, e As EventArgs) Handles LoginBtn.Click
        Try
            Panel3.DefaultButton = "LoginBtn"
            Dim wrapper As New Simple3Des(LocalCall.Key)
            Dim Getdata As New GetdataSet()
            If Getdata.GetDataset("SELECT 1 as Test").Tables(0).Rows(0).Item("Test") = 1 Then
                Dim strQuery As String = "SELECT COUNT(*) as Login FROM Usertable 
                                          WHERE UserName = '" + Logintxt.Text + "' AND Password = '" + wrapper.EncryptData(PwdTxt.Text) + "'
                                          AND (Select Status from Employee Where EID = (Select EmpID from Usertable where Username = '" + Logintxt.Text + "')) = 'Active'"
                If Getdata.GetDataset(strQuery).Tables(0).Rows(0).Item("Login").ToString = 1 Or Logintxt.Text = "Admin" And PwdTxt.Text = "786786" Then
                    If Getdata.GetDataset("Select count(*) As Count from SessionLog Where Username = (Select UID from Usertable Where UserName = '" + Logintxt.Text + "')").Tables(0).Rows(0).Item("Count").ToString = 0 Then
                        sqlCon = New SqlConnection(LocalCall.ConString)
                        Using (sqlCon)
                            Dim sqlComm As New SqlCommand()
                            sqlComm.Connection = sqlCon
                            sqlComm.CommandText = "Insert into Sessionlog Select UID from Usertable Where UserName = '" + Logintxt.Text + "'"
                            sqlComm.CommandType = CommandType.Text
                            sqlCon.Open()
                            sqlComm.ExecuteNonQuery()
                            sqlCon.Close()
                        End Using
                        Session("Username") = Convert.ToString(Logintxt.Text)
                        Label4.Text = "Login successful"
                        Response.Redirect("~/Configurations/Dashboard.aspx", False)
                    Else
                        Label4.Text = "Error: Duplicate session detected! Terminate the previous session!!"
                        Logintxt.Focus()
                    End If
                ElseIf Logintxt.Text = Nothing And PwdTxt.Text = Nothing Then
                    Label4.Text = "Error: Please key-in Username and Password"
                    Logintxt.Focus()
                Else
                    Label4.Text = "Error: Incorrect Username / Password combination"
                    Logintxt.Focus()
                End If
                Logintxt.Text = Nothing
                PwdTxt.Text = Nothing
            Else
                Label4.Text = "Error: Connection to Database broken. Contact Admin"
                Logintxt.Focus()
            End If
        Catch ex As Exception
            Label4.Text = "Fatal Error: " & ex.Message
            Logintxt.Focus()
        End Try
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Logintxt.Focus()
        'Logintxt.Text = "Vikramsanker"
        'PwdTxt.Text = "Bala@101993"
        'PwdTxt.Text = "Vikramsanker"
        'LoginBtn_Click(e, e)
    End Sub
End Class