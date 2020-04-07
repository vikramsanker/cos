Public Class Timertest
    Inherits System.Web.UI.Page

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As System.EventArgs) Handles Timer1.Tick
        Label1.Text = DateTime.Now.ToString("h:mm:ss tt, dd MMMM yyyy")
    End Sub

End Class