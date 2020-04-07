Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Imports iTextSharp.text
Imports iTextSharp.text.pdf
Imports iTextSharp.tool.xml
Public Class packinglist
    Inherits System.Web.UI.Page
    Private LocalCall As New GlobalVar
    Private sqlCon As SqlConnection

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Session("Username") Is Nothing Then
                Response.Redirect("LoginWindow.aspx")
            Else
                If Not Page.IsPostBack Then
                    Dim lbl As Label = Me.Master.FindControl("LblHeader")
                    lbl.Text = "PACKING LIST"
                    Dim GetData As New GetdataSet()
                    Call usermsg(LocalCall.Load_Message, LocalCall.Success_Back, LocalCall.Success_Front)
                End If
            End If
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub Export_Click(sender As Object, e As EventArgs) Handles Export.Click
        Try
            Dim ExporttoExcel As New Export
            Dim Filename As String = "Packing List_" & TxtDDate.Text
            ExporttoExcel.Export_Now(e, e, GridView1, Filename)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub usermsg(msg As String, BColor As Color, FColor As Color, Optional NCount As String = "0 Job(s) Found")
        Dim lbl As Label = Me.Master.FindControl("MessageFooter")
        lbl.Text = msg
        LblCount.Text = NCount
        lbl.BackColor = BColor
        lbl.ForeColor = FColor
    End Sub
    Protected Sub Refresh_Click(sender As Object, e As EventArgs) Handles Refresh.Click
        Response.Redirect("packinglist.aspx", False)
    End Sub

    Protected Sub Search_Click(sender As Object, e As EventArgs) Handles Search.Click
        Try
            Dim GetData As New GetdataSet()
            GridView1.DataSource = GetData.GetDataset("Select (Select Vendor from vendor Where VID = Deliveryplan.Agent) As Agent, [Job Number], [Client Name], Department, SUM(CAST(Quantity AS int)) as [Instruments] from FocusData Join Deliveryplan on FocusData.Id=Deliveryplan.ProductionID Where [Job Number] IN (Select [Job Number] from FocusData 
                                Where ID in (Select ProductionID from Deliveryplan Where DDate = '" + TxtDDate.Text + "')) GROUP By [Job Number], [Client Name], Department, Agent").Tables(0)
            GridView1.DataBind()
            Dim SendCount As String = GetData.RowCount("Select COUNT(DISTINCT [Job Number]) from FocusData Where [Job Number] IN (Select [Job Number] from FocusData 
                                Where ID in (Select ProductionID from Deliveryplan Where DDate = '" + TxtDDate.Text + "'))") & " Job(s) Found"
            Call usermsg(LocalCall.Load_Message, LocalCall.Success_Back, LocalCall.Success_Front, SendCount)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub ExportPDF_Click(sender As Object, e As EventArgs) Handles ExportPDF.Click
        Try
            Using sw As New StringWriter()
                Using hw As New HtmlTextWriter(sw)
                    Dim TDate As String = Date.ParseExact(TxtDDate.Text, ("yyyy-MM-dd"), System.Globalization.CultureInfo.InvariantCulture).ToString("dd MMM yyyy")
                    GridView1.Caption = "Packing List_" & TDate
                    GridView1.RenderControl(hw)
                    Dim sr As New StringReader(sw.ToString())
                    Dim pdfDoc As New Document(PageSize.A4.Rotate, 10.0F, 10.0F, 10.0F, 0.0F)
                    Dim writer As PdfWriter = PdfWriter.GetInstance(pdfDoc, Response.OutputStream)
                    pdfDoc.Open()
                    XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr)
                    pdfDoc.Close()
                    Response.ContentType = "application/pdf"
                    Response.AddHeader("content-disposition", "attachment;filename=Packing List_" & TDate & ".pdf")
                    Response.Cache.SetCacheability(HttpCacheability.NoCache)
                    Response.Write(pdfDoc)
                    Response.End()
                End Using
            End Using
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        ' Verifies that the control is rendered 
    End Sub
End Class