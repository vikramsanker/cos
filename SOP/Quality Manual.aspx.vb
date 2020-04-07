Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Imports System.Data
Public Class Quality_Manual
    Inherits System.Web.UI.Page
    Private LocalCall As New GlobalVar
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Session("Username") Is Nothing Then
                Response.Redirect("LoginWindow.aspx")
            Else
                If Not Page.IsPostBack Then
                    Dim lbl As Label = Me.Master.FindControl("LblHeader")
                    lbl.Text = "QUALITY MANAGEMENT SYSTEM"
                    Call usermsg(LocalCall.Load_Message, LocalCall.Success_Back, LocalCall.Success_Front)
                End If
            End If
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
    Protected Sub TreeView1_SelectedNodeChanged(sender As Object, e As EventArgs) Handles TreeView1.SelectedNodeChanged
        Displayframe.Attributes.Add("src", ("~/SOP/" & TreeView1.SelectedValue & ".pdf#toolbar=0&navpanes=0"))
        TreeView1.SelectedNodeStyle.BackColor = Color.Orange
        TreeView1.SelectedNodeStyle.ForeColor = Color.Black
        Call usermsg("Message from COS: " & TreeView1.SelectedNode.Text & " Loaded successfully", LocalCall.Success_Back, LocalCall.Success_Front)
    End Sub
End Class