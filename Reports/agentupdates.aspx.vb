Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Public Class agentupdates
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
                    lbl.Text = "UPDATE DELIVERY STATUS"
                    Dim SendCount As String = GridView1.Rows.Count & " Records(s) found"
                    Call usermsg(LocalCall.Load_Message, LocalCall.Success_Back, LocalCall.Success_Front)
                End If
            End If
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
        Response.Redirect("agentupdates.aspx", False)
    End Sub
    Protected Sub Search_Click(sender As Object, e As EventArgs) Handles Search.Click
        Try
            Dim ColID, JobNoID As String
            If TxtSearch.Text = "Job Number" Then
                JobNoID = TxtKeyword.Text
                ColID = Nothing
            Else
                ColID = TxtKeyword.Text
                JobNoID = Nothing
            End If
            Dim GetData As New GetdataSet()
            GridView1.DataSource = GetData.GetDataset("(Select [Job Number] as RefID, 'Delivery' as Type, [Deliver To] as Client, [Delivery Address] As Address, Attention, Telephone, Salesperson, CAST(SUM(CAST(Quantity AS int)) As varchar) as [Count], Status, Remarks As [Driver Remarks] from FocusData LEFT JOIN Agentupdate on FocusData.[Job Number]=Agentupdate.ID
                        Where FocusData.ID in (Select ProductionID from Deliveryplan) And RIGHT([Job Number],4) = '" + JobNoID + "' GROUP By [Job Number], [Deliver To], [Delivery Address], Attention, Telephone, Salesperson, Status, Remarks) 
                        UNION
                        Select Cast(CollectionId As VARCHAR) As RefID, 'Collection' as Type, Client, CONCAT([Address Line 1], ', ', [Address Line 2], ', ', [Address Line 3], ', ', (Select Country from Countries Where CountryId = Collection.Country), ' ', PostalCode) As Address, CONCAT(Salutation, ' ', Contact) as Attention, 
                        CONCAT(Telephone, ' / ', Handphone) as Telephone, (select CONCAT(FName, ' ', LName) from Employee Where Eid = Collection.[Caltek Sales]) as Salesperson, '-' as [Count], AgentUpdate.Status As Status, Remarks as [Driver Remarks] from Collection LEFT JOIN AgentUpdate on Cast(Collection.CollectionId As VARCHAR) = Agentupdate.ID Where CollectionId = '" + ColID + "'").Tables(0)
            GridView1.DataBind()
            LblCount.Text = GridView1.Rows.Count & " Records(s) found"
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        ' Verifies that the control is rendered 
    End Sub

    Private Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView1.RowCommand
        On Error Resume Next
        Dim ID As Object = GridView1.Rows(Convert.ToInt32(e.CommandArgument)).Cells(1).Text
        Dim ID2 As Object = GridView1.Rows(Convert.ToInt32(e.CommandArgument)).Cells(2).Text
        Dim strQuery As String
        strQuery = "Select Status, Remarks from Agentupdate Where ID = '" & ID & "' And Type = '" + ID2 + "'"
        Dim GetData As New GetdataSet()
        Dim SQLDataset As DataSet = GetData.GetDataset(strQuery)
        TxtRefID.Text = ID
        TxtType.Text = ID2
        TxtStatus.Text = SQLDataset.Tables(0).Rows(0).Item("Status").ToString()
        TxtDeliveryRemarks.Text = SQLDataset.Tables(0).Rows(0).Item("Remarks").ToString()
        'Catch ex As Exception
        '    Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        'End Try
    End Sub

    Protected Sub Add_Click(sender As Object, e As EventArgs) Handles Add.Click
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
                sqlComm.Parameters.AddWithValue("@Remarks", TxtDeliveryRemarks.Text)
                sqlComm.Parameters.AddWithValue("@Dateupdated", Now())
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
                Session("ID") = Nothing
                Session("Type") = Nothing
            End Using
            Response.Redirect("agentupdates.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
End Class