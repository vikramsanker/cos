Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Public Class Changepassword
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
                    lbl.Text = "CHANGE PASSWORD"
                    Call usermsg(LocalCall.Load_Message, LocalCall.Success_Back, LocalCall.Success_Front)
                    Help.Text = "Conditions to setup the password: " & "<br>" & "<br>" &
                                "1. Passwords must have at least 8 characters and not more than 15 characters" & "<br>" & "<br>" &
                                "2. You must know your old password to change your password" & "<br>" & "<br>" &
                                "3. Passwords are encrypted and stored" & "<br>" & "<br>" &
                                "4. Passwords are irreversible hence it cannot be recovered" & "<br>" & "<br>" &
                                "5. Passwords are case sensitive" & "<br>" & "<br>" &
                                "6. Passwords must not be shared" & "<br>" & "<br>" &
                                "7. Passwords MUST be a combination of atleast one UPPER CASE letter, one LOWER CASE letter and a special character (e.g. @, #, $, %)" & "<br>" & "<br>" &
                                "8. The session will be logged out once the password is changed successfully. You will have to login again with your new password"

                End If
            End If
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub Clear_Click(sender As Object, e As EventArgs) Handles Clear.Click
        Response.Redirect("Changepassword.aspx", False)
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

    Protected Sub Update_Click(sender As Object, e As EventArgs) Handles Update.Click
        Try
            Dim strQuery As String
            Dim wrapper As New Simple3Des(LocalCall.Key)
            strQuery = "select Password from Usertable Where username = '" & Session("Username") & "'"
            Dim GetData As New GetdataSet()
            Dim SQLDataset As DataSet = GetData.GetDataset(strQuery)
            If TxtOldPwd.Text = wrapper.DecryptData(SQLDataset.Tables(0).Rows(0).Item("Password").ToString()) Then
                If Txtpwd.Text = TxtRepwd.Text Then
                    sqlCon = New SqlConnection(LocalCall.ConString)
                    Using (sqlCon)
                        Dim sqlComm As New SqlCommand()
                        sqlComm.Connection = sqlCon
                        sqlComm.CommandText = "Password_Update"
                        sqlComm.CommandType = CommandType.StoredProcedure
                        sqlComm.Parameters.AddWithValue("Username", Session("Username"))
                        sqlComm.Parameters.AddWithValue("Password", wrapper.EncryptData(Txtpwd.Text))
                        sqlCon.Open()
                        sqlComm.ExecuteNonQuery()
                        sqlCon.Close()
                        Call usermsg("Message from COS: Password changed successfully!!", LocalCall.Success_Back, LocalCall.Success_Front)
                        Dim lout As New Logout()
                        lout.Logout()
                        Response.Redirect("~/LoginWindow.aspx")
                    End Using
                Else
                    Call usermsg("Message from COS: Passwords do not match!!", LocalCall.Failure_Back, LocalCall.Failure_Front)
                End If
            Else
                Call usermsg("Message from COS: Incorrect Old Password!!", LocalCall.Failure_Back, LocalCall.Failure_Front)
            End If
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
End Class