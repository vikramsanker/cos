﻿Imports System.Web.SessionState
Imports System.Security.Cryptography


Public Class Global_asax
    Inherits System.Web.HttpApplication

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the application is started
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        If Session("Username") Is Nothing Then
            Response.Redirect("LoginWindow.aspx")
        Else
        End If
    End Sub

    Sub Application_EndRequest(ByVal sender As Object, ByVal e As EventArgs)

    End Sub
    Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)

    End Sub
    Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires upon attempting to authenticate the use
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when an error occurs
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)

    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
    End Sub

End Class