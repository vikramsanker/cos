Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing

Public Class Logout
    Inherits System.Web.UI.Page
    Private LocalCall As New GlobalVar
    Private sqlCon As SqlConnection
    Public Sub Logout()
        sqlCon = New SqlConnection(LocalCall.ConString)
        Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "Delete Sessionlog Where Username = (Select UID from Usertable Where Username='" + Session("Username") + "')"
                sqlComm.CommandType = CommandType.Text
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Session.Abandon()
            Session.Clear()
            Session.RemoveAll()
    End Sub
End Class
