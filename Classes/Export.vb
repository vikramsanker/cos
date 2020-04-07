Imports System.Web.SessionState
Imports System.IO
Imports System.Drawing
Public Class Export
    Inherits System.Web.UI.Page
    Public Sub Export_Now(sender As Object, e As EventArgs, GV As GridView, Filename As String)
        If GV.Rows.Count > 0 Then
            On Error Resume Next
            GV.Columns(0).Visible = False
            HttpContext.Current.Response.ClearContent()
            HttpContext.Current.Response.Buffer = True
            HttpContext.Current.Response.AddHeader("content-disposition", String.Format("attachment; filename={0}", Filename & DateTime.Now.ToString("ddmmyyyyHHmmss") & ".xls"))
            HttpContext.Current.Response.ContentEncoding = Encoding.UTF8
            HttpContext.Current.Response.ContentType = "application/ms-excel"
            Dim sw As New StringWriter()
            Dim htw As New HtmlTextWriter(sw)
            GV.RenderControl(htw)
            HttpContext.Current.Response.Write(sw.ToString())
            HttpContext.Current.Response.[End]()
        End If
    End Sub
End Class
