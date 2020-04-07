Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Public Class transportstatusupdate
    Inherits System.Web.UI.Page
    Private LocalCall As New GlobalVar
    Private sqlCon As SqlConnection

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Session("Username") Is Nothing Then
                Response.Redirect("LoginWindow.aspx")
            Else
                If Not Page.IsPostBack Then
                    'TxtDDate.Attributes("min") = (Today.AddDays(-1)).ToString("yyyy-MM-dd")
                    Dim lbl As Label = Me.Master.FindControl("LblHeader")
                    lbl.Text = "LIVE DELIVERY STATUS"
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
    Protected Sub usermsg(msg As String, BColor As Color, FColor As Color)
        Dim lbl As Label = Me.Master.FindControl("MessageFooter")
        lbl.Text = msg
        lbl.BackColor = BColor
        lbl.ForeColor = FColor
    End Sub
    Protected Sub Refresh_Click(sender As Object, e As EventArgs) Handles Refresh.Click
        Response.Redirect("transportstatusupdate.aspx", False)
    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        ' Verifies that the control is rendered 
    End Sub

    Private Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView1.RowCommand
        On Error Resume Next
        Dim ID As Object
        Dim ID2 As Object = GridView1.Rows(Convert.ToInt32(e.CommandArgument)).Cells(2).Text
        Dim ID3 As Object = GridView1.Rows(Convert.ToInt32(e.CommandArgument)).Cells(3).Text
        Dim strQuery As String
        strQuery = "Select Status, Remarks from Agentupdate Where ID = '" & ID2 & "' And Type = '" + ID3 + "'"
        Dim GetData As New GetdataSet()
        Dim SQLDataset As DataSet = GetData.GetDataset(strQuery)
        TxtRefID.Text = ID2
        TxtType.Text = ID3
        TxtStatus.Text = e.CommandName.ToString()
        If e.CommandName.ToString = "Cancelled" Then
            Panel2.BackColor = Color.Red
        End If
        TxtDetails.Text = GridView1.Rows(Convert.ToInt32(e.CommandArgument)).Cells(4).Text & ", " & GridView1.Rows(Convert.ToInt32(e.CommandArgument)).Cells(5).Text
    End Sub

    Protected Sub Search_Click(sender As Object, e As EventArgs) Handles Search.Click
        Try
            Dim GetData As New GetdataSet()
            GridView1.DataSource = GetData.GetDataset("(Select [Job Number] as RefID, 'Delivery' as Type, [Deliver To] as Client, [Delivery Address] As Address, Attention, Telephone, Salesperson, CAST(SUM(CAST(Quantity AS int)) As varchar) as [Count], Remarks from FocusData LEFT JOIN DeliveryRemarks on FocusData.[Job Number]=DeliveryRemarks.JobID 
                                Where FocusData.ID in (Select ProductionID from Deliveryplan Where DDate = '" + TxtDDate.Text + "' And Agent = (Select Vid from Vendor Where Vendor = '" + TxtAgent.Text + "') 
                                And [Job Number] NOT IN (Select Id from Agentupdate Where Type = 'Delivery'))    
                                GROUP By [Job Number], [Deliver To], [Delivery Address], Attention, Telephone, Salesperson, Remarks) 
                                UNION
                                (Select Cast(CollectionId As VARCHAR) As RefID, 'Collection' as Type, Client, CONCAT([Address Line 1], ', ', [Address Line 2], ', ', [Address Line 3], ', ', (Select Country from Countries Where CountryId = Collection.Country), ' ', PostalCode) As Address, CONCAT(Salutation, ' ', Contact) as Attention, 
                                CONCAT(Telephone, '/', Handphone) as Telephone, (select CONCAT(FName, ' ', LName) from Employee 
                                Where Eid = Collection.[Caltek Sales]) as Salesperson, '-' as [Count], Note as Remarks from Collection
                                Where DOC = '" + TxtDDate.Text + "' 
                                And Transporter = (Select Vid from Vendor Where Vendor = '" + TxtAgent.Text + "')
                                And CollectionId NOT IN (Select Id from Agentupdate Where Type = 'Collection'))
                                ORDER BY Client, Type").Tables(0)
            GridView1.DataBind()
            Dim ColID, JobNoID As String
            If TxtType.Text = "Delivery" Then
                JobNoID = TxtRefID.Text
                ColID = Nothing
            Else
                ColID = TxtRefID.Text
                JobNoID = Nothing
            End If
            GridView2.DataSource = GetData.GetDataset("Select [Job Number] as RefID, 'Delivery' as Type, [Deliver To] as Client, [Delivery Address] As Address, Attention, Telephone, Salesperson, CAST(SUM(CAST(Quantity AS int)) As varchar) as [Count], Status, Remarks As [Driver Remarks] from FocusData LEFT JOIN Agentupdate on FocusData.[Job Number]=Agentupdate.ID
                Where FocusData.ID in (Select ProductionID from Deliveryplan Where DDate = '" + TxtDDate.Text + "' And Agent = (Select Vid from Vendor Where Vendor = '" + TxtAgent.Text + "'))
                And [Job Number] IN (Select Id from Agentupdate Where Type = 'Delivery') GROUP By [Job Number], [Deliver To], [Delivery Address], Attention, Telephone, Salesperson, Status, Remarks
                UNION
                Select Cast(CollectionId As VARCHAR) As RefID, 'Collection' as Type, Client, CONCAT([Address Line 1], ', ', [Address Line 2], ', ', [Address Line 3], ', ', (Select Country from Countries Where CountryId = Collection.Country), ' ', PostalCode) As Address, CONCAT(Salutation, ' ', Contact) as Attention, 
                CONCAT(Telephone, ' / ', Handphone) as Telephone, (select CONCAT(FName, ' ', LName) from Employee Where Eid = Collection.[Caltek Sales]) as Salesperson, '-' as [Count], AgentUpdate.Status As Status, Remarks as [Driver Remarks] from Collection LEFT JOIN AgentUpdate on Cast(Collection.CollectionId As VARCHAR) = Agentupdate.ID
                Where DOC = '" + TxtDDate.Text + "' And Transporter = (Select Vid from Vendor Where Vendor = '" + TxtAgent.Text + "') 
                And CollectionId IN (Select Id from Agentupdate Where Type = 'Collection')").Tables(0)
            GridView2.DataBind()
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Submit_Click(sender As Object, e As EventArgs) Handles Submit.Click
        Try
            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "Agentupdates"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("@ID", TxtRefID.Text)
                sqlComm.Parameters.AddWithValue("@Type", TxtType.Text)
                sqlComm.Parameters.AddWithValue("@Status", TxtStatus.Text)
                sqlComm.Parameters.AddWithValue("@Remarks", TxtJobRemarks.Text)
                sqlComm.Parameters.AddWithValue("@Dateupdated", Now())
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("transportstatusupdate.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Private Sub GridView2_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView2.RowCommand
        Try
            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                Dim ID1 As Object = GridView2.Rows(Convert.ToInt32(e.CommandArgument)).Cells(1).Text
                Dim ID2 As Object = GridView2.Rows(Convert.ToInt32(e.CommandArgument)).Cells(2).Text
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "Delete Agentupdate Where ID = '" + ID1 + "' and Type = '" + ID2 + "'"
                sqlComm.CommandType = CommandType.Text
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("transportstatusupdate.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
End Class