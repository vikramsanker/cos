Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Imports iTextSharp.text
Imports iTextSharp.text.pdf
Imports iTextSharp.tool.xml
Imports Microsoft.Office.Interop
Public Class sitejobstatus
    Inherits System.Web.UI.Page
    Private LocalCall As New GlobalVar
    Private sqlCon As SqlConnection

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Session("Username") Is Nothing Then
                Response.Redirect("LoginWindow.aspx")
            Else
                If Not Me.IsPostBack Then
                    Dim lbl As Label = Me.Master.FindControl("LblHeader")
                    lbl.Text = "MY SITE WORK"
                    Dim Strquery As String = "Select EId, concat (EId, '-', FName, ' ', LName) as Name from Employee; 
                        Select Id, Client, [Requested Date], PPE, Salesperson, Status, Employee from 
                        (Select Id, (Select Client from Client Where CId = JobRequest.CId) as Client, Concat(DAY([DOR]),'-',CONVERT(VARCHAR(3),Datename(month, [DOR])),'-',YEAR([DOR])) As [Requested Date], JobNo, PPE, [Risk Assessment], (Select concat (FName, ' ', LName) from Employee Where Eid = JobRequest.Salesperson) as Salesperson, Remarks, Status from JobRequest Where Status <> 'Cancelled') 
                        As Job
                        LEFT JOIN
                        (Select [Job ID], STUFF((SELECT ', ' + (Select concat (FName, ' ', LName) from Employee Where Eid = EmpID) FROM Sitejobassmtteam WHERE ([Job ID] = Results.[Job ID]) 
                        FOR XML PATH(''),TYPE).value('(./text())[1]','VARCHAR(MAX)'),1,2,'') AS Employee FROM Sitejobassmtteam Results GROUP BY [Job ID]) 
                        As Team 
                        on Team.[Job ID] = Job.Id"
                    Dim Getdata As New GetdataSet()
                    Dim Sqldataset As DataSet = Getdata.GetDataset(Strquery)
                    TxtTeam.DataSource = Sqldataset.Tables(0)
                    TxtTeam.DataTextField = ("Name")
                    TxtTeam.DataValueField = ("EId")
                    TxtTeam.DataBind()
                    GridView1.DataSource = Sqldataset.Tables(1)
                    GridView1.DataBind()
                    For Each Item As Control In Me.Controls
                        If TypeOf Item Is Label Then
                            TryCast(Item, Label).Attributes("Font-Size") = "0.7vw"
                        ElseIf TypeOf Item Is TextBox Then
                            TryCast(Item, TextBox).Attributes("Font-Size") = "0.7vw"
                            TryCast(Item, TextBox).Style("Font-Size") = "0.7vw"
                        ElseIf TypeOf Item Is GridView Then
                            TryCast(Item, GridView).Attributes("Font-Size") = "0.7vw"
                        ElseIf TypeOf Item Is CheckBoxList Then
                            TryCast(Item, CheckBoxList).Attributes("Font-Size") = "0.7vw"
                        ElseIf TypeOf Item Is Button Then
                            TryCast(Item, Button).Attributes("Font-Size") = "0.7vw"
                        End If
                    Next
                    Call usermsg("Message from COS: Site job assignment interface loaded successfully", LocalCall.Success_Back, LocalCall.Success_Front)
                End If
            End If
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Export_Click(sender As Object, e As EventArgs) Handles Export.Click
        Try
            Dim ExporttoExcel As New Export
            Dim Filename As String = Session("Username") & "Production Assigned_"
            ExporttoExcel.Export_Now(e, e, GridView1, Filename)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub usermsg(msg As String, BColor As Color, FColor As Color, Optional NCount As String = "0 Record(s) Found")
        Dim lbl As Label = Me.Master.FindControl("MessageFooter")
        lbl.Text = msg
        lbl.BackColor = BColor
        lbl.ForeColor = FColor
    End Sub

    Public Sub Loadgrid()
        Dim GetData As New GetdataSet()
        GridView1.DataSource = GetData.GetDataset("Select Id as ID, TAT, [Delivery Type], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], Certification from FocusData 
                                            Where Id IN (Select ProductionID from ProductionAssigned Where Employee = (select EmpID from Usertable Where Username = '" & Session("Username") & "')) and ID NOT IN (select ProductionID from Productionstatus where Status = 'Certificate') ORDER by [TAT], [Date Received] ASC").Tables(0)
        GridView1.DataBind()
    End Sub
    Protected Sub TxtClient_SelectedIndexChanged(sender As Object, e As EventArgs)
        Try
            Dim strQuery As String
            strQuery = "select CId, [Address Line 1], [Address Line 2], [Address Line 3], (select Country from Countries where CountryID = Client.Country) as Country, PostalCode, Salutation, Contact, Telephone, Handphone, (select concat(FName, ' ', LName) from Employee where Eid = Client.[Caltek Sales]) as Salesperson, Remarks from Client Where Client = '" & TxtClient.Text & "'"
            Dim GetData As New GetdataSet()
            Dim SQLDataset As DataSet = GetData.GetDataset(strQuery)
            TxtAdd1.Text = SQLDataset.Tables(0).Rows(0).Item("Address Line 1").ToString()
            TxtAdd2.Text = SQLDataset.Tables(0).Rows(0).Item("Address Line 2").ToString()
            TxtAdd3.Text = SQLDataset.Tables(0).Rows(0).Item("Address Line 3").ToString()
            TxtCountry.Text = SQLDataset.Tables(0).Rows(0).Item("Country").ToString()
            Txtpostalcode.Text = SQLDataset.Tables(0).Rows(0).Item("PostalCode").ToString()
            TxtSal.Text = SQLDataset.Tables(0).Rows(0).Item("Salutation").ToString()
            TxtName.Text = SQLDataset.Tables(0).Rows(0).Item("Contact").ToString()
            TxtTel.Text = SQLDataset.Tables(0).Rows(0).Item("Telephone").ToString()
            TxtHP.Text = SQLDataset.Tables(0).Rows(0).Item("Handphone").ToString()
            TxtSalesperson.Text = SQLDataset.Tables(0).Rows(0).Item("Salesperson").ToString()
            TxtNote.Text = SQLDataset.Tables(0).Rows(0).Item("Remarks").ToString()
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Private Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView1.RowCommand
        Try
            TxtDOR.Attributes("min") = (Today()).ToString("yyyy-MM-dd")
            Dim ID As Object = GridView1.Rows(Convert.ToInt32(e.CommandArgument)).Cells(1).Text
            Dim strQuery As String
            strQuery = "Select Id, (Select Client from Client Where CId = JobRequest.CId) as Client, DOR, JobNo, PPE, [Risk Assessment], (Select concat (FName, ' ', LName) from Employee Where Eid = JobRequest.Salesperson) as Salesperson, Remarks, Status from JobRequest Where ID = '" & ID & "';
                        Select Instrument, Range, Make, Model, Quantity, [Cert. Type], [Pre. Cert.], [Cal. Points] from JobRequestInstruments Where JRID = '" & ID & "';
                        Select EmpID from Sitejobassmtteam Where [Job ID] = '" & ID & "'"
            Dim GetData As New GetdataSet()
            Dim SQLDataset As DataSet = GetData.GetDataset(strQuery)
            If SQLDataset.Tables(0).Rows(0).Item("Status").ToString() <> "Cancelled" Then
                If SQLDataset.Tables(0).Rows(0).Item("DOR").ToString() > Today() Then
                    TxtClient.Text = SQLDataset.Tables(0).Rows(0).Item("Client").ToString()
                    TxtDOR.Text = SQLDataset.Tables(0).Rows(0).Item("DOR").ToString()
                    TxtNote.Text = SQLDataset.Tables(0).Rows(0).Item("Remarks").ToString()
                    TxtRisk.Text = SQLDataset.Tables(0).Rows(0).Item("Risk Assessment").ToString()
                    TxtJobNo.Text = SQLDataset.Tables(0).Rows(0).Item("JobNo").ToString()
                    ListPPE.Text = SQLDataset.Tables(0).Rows(0).Item("PPE").ToString()
                    TxtClient_SelectedIndexChanged(e, e)
                    COSkey.Text = ID.ToString()
                    GridView2.DataSource = SQLDataset.Tables(1)
                    GridView2.DataBind()
                    Call usermsg("Message from COS: Site job arrangement loaded successfully!!", LocalCall.Success_Back, LocalCall.Success_Front)
                Else
                    Call usermsg("Message from COS: The site job arrangement is too late to modify now!!", LocalCall.Failure_Back, LocalCall.Failure_Front)
                End If
            Else
                Call usermsg("Message from COS: The site job arrangement that you are trying to edit has already been cancelled!! Hence it cannot be edited!!", LocalCall.Failure_Back, LocalCall.Failure_Front)
            End If
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Refresh_Click(sender As Object, e As EventArgs) Handles Refresh.Click
        Response.Redirect("sitejobstatus.aspx", False)
    End Sub
    Protected Sub Print_Click(sender As Object, e As EventArgs) Handles Print.Click
        Try
            Using sw As New StringWriter()
                Using hw As New HtmlTextWriter(sw)
                    For Each Item As Control In Me.Panel3.Controls
                        If TypeOf Item Is Label Then
                            DirectCast(Item, Label).Attributes("Font-Size") = "Smaller"
                        ElseIf TypeOf Item Is TextBox Then
                            DirectCast(Item, TextBox).Attributes("Font-Size") = "Smaller"
                        ElseIf TypeOf Item Is GridView Then
                            DirectCast(Item, GridView).Attributes("Font-Size") = "Smaller"
                        ElseIf TypeOf Item Is CheckBoxList Then
                            DirectCast(Item, CheckBoxList).Attributes("Font-Size") = "Smaller"
                        ElseIf TypeOf Item Is Button Then
                            DirectCast(Item, Button).Attributes("Font-Size") = "Smaller"
                        End If
                    Next
                    Panel3.RenderControl(hw)
                    Dim sr As New StringReader(sw.ToString())
                    Dim pdfDoc As New iTextSharp.text.Document(PageSize.A4.Rotate, 10.0F, 10.0F, 10.0F, 10.0F)
                    Dim writer As PdfWriter = PdfWriter.GetInstance(pdfDoc, Response.OutputStream)
                    pdfDoc.Open()
                    XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr)
                    pdfDoc.Close()
                    Response.ContentType = "application/pdf"
                    Response.AddHeader("content-disposition", "attachment;filename=Site Job_" & ".pdf")
                    Response.Cache.SetCacheability(HttpCacheability.NoCache)
                    Response.Write(pdfDoc)
                    Response.End()
                End Using
            End Using
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub Search_Click(sender As Object, e As EventArgs) Handles Search.Click
        Try
            Dim strQuery As String
            strQuery = "Select Id, Client, [Requested Date], PPE, Salesperson, Status, Employee from 
                        (Select Id, (Select Client from Client Where CId = JobRequest.CId) as Client, Concat(DAY([DOR]),'-',CONVERT(VARCHAR(3),Datename(month, [DOR])),'-',YEAR([DOR])) As [Requested Date], JobNo, PPE, [Risk Assessment], (Select concat (FName, ' ', LName) from Employee Where Eid = JobRequest.Salesperson) as Salesperson, Remarks, Status from JobRequest Where Status <> 'Cancelled') 
                        As Job
                        LEFT JOIN
                        (Select [Job ID], STUFF((SELECT ', ' + (Select concat (FName, ' ', LName) from Employee Where Eid = EmpID) FROM Sitejobassmtteam WHERE ([Job ID] = Results.[Job ID]) 
                        FOR XML PATH(''),TYPE).value('(./text())[1]','VARCHAR(MAX)'),1,2,'') AS Employee FROM Sitejobassmtteam Results GROUP BY [Job ID]) 
                        As Team 
                        on Team.[Job ID] = Job.Id
                        Where [" + TxtSearch.Text + "] Like '%" & TxtKeyword.Text & "%'"
            Dim Getdata As New GetdataSet()
            Dim Sqldataset As DataSet = Getdata.GetDataset(strQuery)
            GridView1.DataSource = Sqldataset.Tables(0)
            GridView1.DataBind()
            Call usermsg(LocalCall.Search_Message, LocalCall.Success_Back, LocalCall.Success_Front)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        ' Verifies that the control is rendered
    End Sub

    Protected Sub Update_Click(sender As Object, e As EventArgs) Handles Update.Click
        Try
            Dim oMissing As Object = System.Reflection.Missing.Value
            Dim oWord As New Word.Application
            Dim oDoc As New Word.Document
            Dim objDocTemplate As Object = Server.MapPath("~\Templates\SiteTemplate4.dotx")
            oDoc = oWord.Documents.Add(objDocTemplate, oMissing, oMissing, oMissing)
            oDoc.ActiveWindow.ActivePane.View.Zoom.Percentage = 100
            oDoc.ShowSpellingErrors = False
            oDoc.Bookmarks("Address").Range.Text = TxtAdd1.Text & ", " & TxtAdd2.Text & ", " & TxtAdd3.Text & ", " & TxtCountry.Text & ", " & Txtpostalcode.Text
            oDoc.Bookmarks("Client").Range.Text = TxtClient.Text
            oDoc.Bookmarks("Contact").Range.Text = TxtSal.Text & " " & TxtName.Text
            oDoc.Bookmarks("Date").Range.Text = Now()
            oDoc.Bookmarks("DateRequested").Range.Text = TxtDOR.Text
            oDoc.Bookmarks("Handphone").Range.Text = TxtHP.Text
            oDoc.Bookmarks("JobNo").Range.Text = TxtJobNo.Text
            oDoc.Bookmarks("ManagerNote").Range.Text = TxtMgrNote.Text
            oDoc.Bookmarks("PPERequest").Range.Text = ListPPE.Text
            oDoc.Bookmarks("RA").Range.Text = TxtRisk.Text
            oDoc.Bookmarks("ReferenceID").Range.Text = COSkey.Text
            oDoc.Bookmarks("Sales").Range.Text = TxtSalesperson.Text
            oDoc.Bookmarks("Salesnote").Range.Text = TxtJobNo.Text
            oDoc.Bookmarks("Status").Range.Text = "New"
            Dim Team As String = ""
            For Each Item In TxtTeam.Items
                If Item.Selected = True Then
                    Team += Item.text
                End If
            Next
            oDoc.Bookmarks("Team").Range.Text = Team
            oDoc.Bookmarks("Telephone").Range.Text = TxtTel.Text
            Dim GetData As New GetdataSet()
            Dim SQLDataset As DataSet = GetData.GetDataset("Select Instrument, Range, Make, Model, Quantity, [Cert. Type], [Pre. Cert.], [Cal. Points] from JobRequestInstruments Where JRID = '" & COSkey.Text & "'")
            Dim Sno As Integer = 0
            Dim sText As String = "S.No" + vbTab + "Instrument" + vbTab + "Range" + vbTab + "Make" + vbTab + "Model" + vbTab + "Quantity" + vbTab + "Cert. Type" + vbTab + "Pre. Cert." + vbTab + "Cal. Points"
            For Each oRow As DataRow In SQLDataset.Tables(0).Rows
                sText += Environment.NewLine
                Sno += 1
                sText += (Sno.ToString) + vbTab
                For idx = 0 To SQLDataset.Tables(0).Columns.Count - 1
                    sText += oRow.Item(idx).ToString
                    If idx < (SQLDataset.Tables(0).Columns.Count - 1) Then sText += vbTab
                Next
            Next
            Dim oRange As Word.Range = oDoc.Bookmarks("InsList").Range
            oRange.Text = sText
            oRange.ConvertToTable(Separator:=vbTab, oMissing, oMissing, oMissing, Word.WdTableFormat.wdTableFormatGrid1, True, oMissing, oMissing, oMissing, True, oMissing, oMissing, oMissing, oMissing, oMissing, oMissing)
            Dim Filename As String = "Site_Ref#" & COSkey.Text & "_" & DateTime.Now.ToString("ddmmyyyyHHmmss") & ".pdf"
            Dim path As String = Server.MapPath("~/Outputs/") & Filename
            oWord.ActiveDocument.SaveAs2(path, Word.WdSaveFormat.wdFormatPDF)
            Dim SaveChanges As Object = False
            oDoc.Close(SaveChanges, oMissing, oMissing)
            oDoc = Nothing
            oWord.Quit(SaveChanges, oMissing, oMissing)
            Response.ContentType = "Application/pdf"
            Response.AppendHeader("Content-Disposition", "attachment; filename=" & Filename)
            Response.TransmitFile(Server.MapPath("~/Outputs/") & Filename)
            Response.End()
            Call usermsg("Schedule downloaded!", LocalCall.Success_Back, LocalCall.Success_Front)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
End Class