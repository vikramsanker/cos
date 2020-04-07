Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.Configuration
Public Class GetdataSet
    Private LocalVar As New GlobalVar
    Private sqlCon As SqlConnection
    Public Function GetDataset(ByVal Input As String) As DataSet
        sqlCon = New SqlConnection(LocalVar.ConString)
        Dim Sqladapter As New SqlDataAdapter(Input, sqlCon)
        Dim Sqldataset As New DataSet
        Sqladapter.Fill(Sqldataset)
        Return (Sqldataset)
    End Function

    Public Function RowCount(ByVal Input As String) As Integer
        sqlCon = New SqlConnection(LocalVar.ConString)
        Dim Sqladapter As New SqlDataAdapter(input, sqlCon)
        Dim Sqldataset As New DataSet
        Sqladapter.Fill(Sqldataset)
        Dim NoCount As Integer = Sqldataset.Tables(0).Rows(0).Item(0)
        Return (NoCount)
    End Function

    Public Function GetIPAddress() As String
        Dim context As System.Web.HttpContext = System.Web.HttpContext.Current
        Dim sIPAddress As String = context.Request.ServerVariables("HTTP_X_FORWARDED_FOR")
        If String.IsNullOrEmpty(sIPAddress) Then
            Return context.Request.ServerVariables("REMOTE_ADDR")
        Else
            Dim ipArray As String() = sIPAddress.Split(New [Char]() {","c})
            Return ipArray(0)
        End If
    End Function

End Class
