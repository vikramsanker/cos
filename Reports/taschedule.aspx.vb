Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Imports iTextSharp.text
Imports iTextSharp.text.pdf
Imports iTextSharp.tool.xml
Public Class taschedule
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
                    lbl.Text = "AGENT SCHEDULE"
                    Dim GetData As New GetdataSet()
                    TxtAgent.DataSource = GetData.GetDataset("select Vendor from Vendor").Tables(0)
                    TxtAgent.DataTextField = "Vendor"
                    TxtAgent.DataBind()
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
            Dim Filename As String = TxtAgent.Text & "_" & TxtDDate.Text & "_"
            ExporttoExcel.Export_Now(e, e, GridView1, Filename)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub usermsg(msg As String, BColor As Color, FColor As Color, Optional NCount As String = "0 Record(s) Found")
        Dim lbl As Label = Me.Master.FindControl("MessageFooter")
        lbl.Text = msg
        LblCount.Text = NCount
        lbl.BackColor = BColor
        lbl.ForeColor = FColor
    End Sub
    Protected Sub Refresh_Click(sender As Object, e As EventArgs) Handles Refresh.Click
        Response.Redirect("taschedule.aspx", False)
    End Sub
    Protected Sub Search_Click(sender As Object, e As EventArgs) Handles Search.Click
        Try
            Dim GetData As New GetdataSet()
            GridView1.DataSource = GetData.GetDataset("(Select [Job Number] as RefID, 'Delivery' as Type, [Deliver To] as Client, [Delivery Address] As Address, Attention, Telephone, Salesperson, CAST(SUM(CAST(Quantity AS int)) As varchar) as [Count], Remarks from FocusData LEFT JOIN DeliveryRemarks on FocusData.[Job Number]=DeliveryRemarks.JobID 
                                Where ID in (Select ProductionID from Deliveryplan Where DDate = '" + TxtDDate.Text + "' And Agent = (Select Vid from Vendor Where Vendor = '" + TxtAgent.Text + "')) GROUP By [Job Number], [Deliver To], [Delivery Address], Attention, Telephone, Salesperson, Remarks) 
                                UNION
                                (Select Cast(CollectionId As VARCHAR) As RefID, 'Collection' as Type, Client, CONCAT([Address Line 1], ', ', [Address Line 2], ', ', [Address Line 3], ', ', (Select Country from Countries Where CountryId = Collection.Country), ' ', PostalCode) As Address, CONCAT(Salutation, ' ', Contact) as Attention, 
                                            CONCAT(Telephone, '/', Handphone) as Telephone, (select CONCAT(FName, ' ', LName) from Employee Where Eid = Collection.[Caltek Sales]) as Salesperson, '-' as [Count], Note as Remarks from Collection Where DOC = '" + TxtDDate.Text + "')
                                ORDER BY Client, Type").Tables(0)
            GridView1.DataBind()
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub ToPDF_Click(sender As Object, e As EventArgs) Handles ToPDF.Click
        Try
            Using sw As New StringWriter()
                Using hw As New HtmlTextWriter(sw)
                    Dim TDate As String = Date.ParseExact(TxtDDate.Text, ("yyyy-MM-dd"), System.Globalization.CultureInfo.InvariantCulture).ToString("dd MMM yyyy")
                    GridView1.Caption = TxtAgent.Text & "_" & TDate
                    'Dim Signcolumn As New BoundField
                    'GridView1.Columns.Add(Signcolumn)
                    'GridView1.DataBind()
                    GridView1.RenderControl(hw)
                    Dim SR As New StringReader(sw.ToString())
                    Dim pdfDoc As New Document(PageSize.A4.Rotate, 10.0F, 10.0F, 10.0F, 0.0F)
                    Dim writer As PdfWriter = PdfWriter.GetInstance(pdfDoc, Response.OutputStream)
                    pdfDoc.Open()
                    XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, SR)
                    pdfDoc.Close()
                    Response.ContentType = "application/pdf"
                    Response.AddHeader("content-disposition", "attachment;filename=" & TxtAgent.Text & "_" & TDate & ".pdf")
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