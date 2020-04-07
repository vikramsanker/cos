Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Drawing
Public Class GlobalVar
    Dim wrapper As New Simple3Des("CalteK#123")
    'Public StrCon As String = "Data Source ='" & My.Settings.Server & "';Initial Catalog='" & My.Settings.DBName & "';User='" &
    'wrapper.DecryptData(My.Settings.Username.ToString) & "';Password='" & wrapper.DecryptData(My.Settings.Password.ToString) & "'"
    'Public StrCon As String = "Data Source=VIKRAM\SQLEXPRESS;Initial Catalog=IAMA;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=True;ApplicationIntent=ReadWrite;MultiSubnetFailover=False"
    'Public ConString As String = "Data Source=192.168.1.157;Initial Catalog=SJMS;Persist Security Info=True;User ID=sa;Password=Sap+0514"
    Public ConString As String = "Data Source = VA;Initial Catalog=COS;Persist Security Info=True;User ID=sa;Password=Bala@101993"
    Public Key As String = "Vikram#COS"
    'Public StrCon As String = "Data Source=118.201.50.12;Initial Catalog=IAMA;Persist Security Info=True;User ID=sa;Password=Sap+0514"
    Public Success_Back As Color = Color.Green
    Public Success_Front As Color = Color.White
    Public Failure_Back As Color = Color.Red
    Public Failure_Front As Color = Color.White
    Public Progress_Back As Color = Color.Orange
    Public Progress_Front As Color = Color.White
    Public Load_Message As String = "Message from COS: Page loaded successfully!"
    Public Edit_Message As String = "Message from COS: Editing in progress..."
    Public Save_Message As String = "Message from COS: Entry Saved!"
    Public Update_Message As String = "Message from COS: Update successful!"
    Public Search_Message As String = "Message from COS: Search was successful"
    Public Delete_Message As String = "Message from COS: Deleted successfully!"
    Public Export_Message As String = "Message from COS: Data exported successfully!!"
    Public Linkedserver As String = "ExcelServer" + DateTime.Now.ToString("yyyyMMdd") + "_" + DateTime.Now.ToString("HHmmss")
    Public Linkedserveruser As String = "VA\VA"
    Public LinkedserverPath2 As String = "D:\COS\"
    Public LinkedserverPath1 As String = "D:\COS\"
End Class