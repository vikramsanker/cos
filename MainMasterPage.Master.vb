Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Public Class MasterPage
    Inherits System.Web.UI.MasterPage
    Private LocalCall As New GlobalVar
    Private sqlCon As SqlConnection

    Public Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Attributes.Add("onkeydown", "return (event.keyCode!=13);")
        DateTimelbl.Text = DateTime.Now.ToString("h:mm:ss tt, dd MMMM yyyy")
        UserID.Text = "Welcome, " & Session("Username")
        Dim strQuery As String
        strQuery = "Select ParentName, Rights from ScreenList Where ScreenID NOT IN (select ScreenID from AccessRights Where RoleID IN (Select Role from Usertable Where Username = '" & Session("Username") & "'))"
        Dim Getdata As New GetdataSet()
        Dim Sqldataset As DataSet = Getdata.GetDataset(strQuery)
        On Error Resume Next
        'Dim Parent As MenuItem = Menu1.FindItem("Collection")
        'Dim SubM As MenuItem = Menu1.FindItem("Collection/View")
        'Parent.ChildItems.Remove(SubM)
        'Dim Parent As MenuItem = Menu1.FindItem("Collection")
        'Menu1.Items.Remove(Menu1.FindItem("Delivery"))
        'Menu1.FindItem("Collection").ChildItems.Remove(Menu1.FindItem("Collection/View/Test"))
        'Menu1.FindItem("Collection/View").ChildItems.Remove(Menu1.FindItem("Collection/View/Test"))
        For i As Integer = 0 To Sqldataset.Tables(0).Rows().Count - 1
            Menu1.FindItem(Sqldataset.Tables(0).Rows(i).Item("ParentName").ToString()).ChildItems.Remove(Menu1.FindItem(Sqldataset.Tables(0).Rows(i).Item("Rights").ToString()))
        Next
        Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1))
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.Cache.SetNoStore()
        form1.Attributes.Add("Style", "font-size:0.7vw;")
    End Sub

    Public Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Try
            Dim getdata As New GetdataSet()
            Dim lout As New Logout()
            lout.Logout()
            Response.Redirect("~/LoginWindow.aspx")
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub usermsg(msg As String, BColor As Color, FColor As Color)
        MessageFooter.Text = msg
        MessageFooter.BackColor = BColor
        MessageFooter.ForeColor = FColor
    End Sub
    Public Property MessageFootertext() As String
        Get
            Return MessageFooter.Text
        End Get
        Set(ByVal Value As String)
            MessageFooter.Text = Value
        End Set
    End Property

    Public Property HeaderText() As String
        Get
            Return LblHeader.Text
        End Get
        Set(ByVal Value As String)
            LblHeader.Text = Value
        End Set
    End Property
    Private Sub Menu1_MenuItemDataBound(sender As Object, e As MenuEventArgs) Handles Menu1.MenuItemDataBound
        Dim Menu As System.Web.UI.WebControls.Menu = DirectCast(sender, System.Web.UI.WebControls.Menu)
        Dim mapNode As SiteMapNode = DirectCast(e.Item.DataItem, SiteMapNode)
        Dim itemToRemove As System.Web.UI.WebControls.MenuItem = Menu.FindItem(mapNode.Title)
        If mapNode.Title = "Node" Then
            Dim parent As System.Web.UI.WebControls.MenuItem = e.Item.Parent
            If parent IsNot Nothing Then
                parent.ChildItems.Remove(e.Item)
            End If
        End If
    End Sub
End Class