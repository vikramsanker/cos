Imports System.Web.SessionState
Imports System.Data.SqlClient 'Import SQL Capabilities
Imports System.IO
Imports System.Drawing
Imports System.Data
Public Class AccessControl
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
                    lbl.Text = "ACCESS RIGHTS MANAGEMENT"
                    Dim StrQuery As String = "Select role from role;
                                            select Role.RID as [Role ID], Role.Role, ScreenList.ScreenName as Screen, ScreenList.ParentName as [Parent URL], ScreenList.Rights as [Child URL] from Role, ScreenList, AccessRights where Role.rid = AccessRights.RoleID and ScreenList.ScreenID = AccessRights.ScreenId"
                    Dim Getdata As New GetdataSet()
                    Dim Sqldataset As DataSet = Getdata.GetDataset(StrQuery)
                    TxtRole.DataSource = Sqldataset.Tables(0)
                    TxtRole.DataTextField = ("Role")
                    TxtRole.DataBind()
                    GridView1.DataSource = Sqldataset.Tables(1)
                    GridView1.DataBind()
                    Session("ScreenList") = Nothing
                    Session("Added") = Nothing
                    'Dim SendCount As String = Getdata.RowCount("select count(*) as Count from AccessRights") & " Record(s) Found"
                    Dim SendCount As String = GridView1.Rows.Count & " Record(s) Found"
                    Call usermsg(LocalCall.Load_Message, LocalCall.Success_Back, LocalCall.Success_Front, SendCount)
                End If
            End If
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub OneAdd_Click(sender As Object, e As EventArgs) Handles OneAdd.Click
        Try
            AddRemove(ScreenList, Added, Session("ScreenList"), Session("Added"), "DONOTSWAP")
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub OneRemove_Click(sender As Object, e As EventArgs) Handles OneRemove.Click
        Try
            AddRemove(Added, ScreenList, Session("Added"), Session("ScreenList"), "SWAP")
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub AllAdd_Click(sender As Object, e As EventArgs) Handles AllAdd.Click
        Try
            AddRemove(ScreenList, Added, Session("ScreenList"), Session("Added"), "DONOTSWAP", "Yes")
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub AllRemove_Click(sender As Object, e As EventArgs) Handles AllRemove.Click
        Try
            AddRemove(Added, ScreenList, Session("Added"), Session("ScreenList"), "SWAP", "Yes")
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Public Sub AddRemove(FromDg As GridView, ToDG As GridView, Fromdt As DataTable, Todt As DataTable, Status As String, Optional All As String = "No")
        For i As Integer = FromDg.Rows.Count - 1 To 0 Step -1
            If FromDg.Rows(i).RowType = DataControlRowType.DataRow Then
                Dim chkRow As CheckBox = TryCast(FromDg.Rows(i).Cells(0).FindControl("cbselect"), CheckBox)
                If All = "Yes" Then
                    chkRow.Checked = True
                End If
                If chkRow.Checked Then
                    Dim ScreenID As String = FromDg.Rows(i).Cells(1).Text
                    Dim ScreenName As String = FromDg.Rows(i).Cells(2).Text
                    Todt.Rows.Add(ScreenID, ScreenName)
                    Fromdt.Rows.RemoveAt(FromDg.Rows(i).RowIndex)
                End If
            End If
        Next
        ToDG.DataSource = Todt
        ToDG.DataBind()
        FromDg.DataSource = Fromdt
        FromDg.DataBind()
        If Status = "DONOTSWAP" Then
            Session("Added") = Todt
            Session("ScreenList") = Fromdt
        ElseIf Status = "SWAP" Then
            Session("ScreenList") = Todt
            Session("Added") = Fromdt
        End If
    End Sub
    Private Sub TxtRole_SelectedIndexChanged(sender As Object, e As EventArgs) Handles TxtRole.SelectedIndexChanged
        Try
            Dim StrQuery As String = "Select ScreenID, ScreenName from ScreenList Where ScreenID NOT in (Select ScreenID from AccessRights Where roleid = (select rid from role where Role='" + TxtRole.Text + "'));
                                    Select ScreenID, ScreenName from ScreenList Where ScreenID in (Select ScreenID from AccessRights Where roleid = (select rid from role where Role='" + TxtRole.Text + "'));"
            Dim Getdata As New GetdataSet()
            Dim Sqldataset As DataSet = Getdata.GetDataset(StrQuery)
            ScreenList.DataSource = Sqldataset.Tables(0)
            ScreenList.DataBind()
            Session("ScreenList") = ScreenList.DataSource
            Added.DataSource = Sqldataset.Tables(1)
            Added.DataBind()
            Session("Added") = Added.DataSource
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Save_Click(sender As Object, e As EventArgs) Handles Save.Click
        Try

            Dim StrQuery As String = "Select Rid from Role Where Role = '" + TxtRole.Text + "'"
            Dim Getdata As New GetdataSet()
            Dim Sqldataset As DataSet = Getdata.GetDataset(StrQuery)
            Dim RoleID As Object = Sqldataset.Tables(0).Rows(0).Item(0).ToString
            Dim Dtable As DataTable = Session("Added")
            Dim ToSend As New DataTable()
            ToSend.Columns.Add("Role", GetType(String))
            ToSend.Columns.Add("ScreenID", GetType(Integer))
            For i As Integer = 0 To Dtable.Rows.Count - 1
                ToSend.Rows.Add(RoleID, Dtable.Rows(i).ItemArray(0).ToString)
            Next
            sqlCon = New SqlConnection(LocalCall.ConString)
            Using (sqlCon)
                Dim sqlComm As New SqlCommand()
                sqlComm.Connection = sqlCon
                sqlComm.CommandText = "AccessRights_Insert"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.AddWithValue("Role", RoleID)
                sqlComm.Parameters.AddWithValue("Dtable", ToSend)
                sqlCon.Open()
                sqlComm.ExecuteNonQuery()
                sqlCon.Close()
            End Using
            Response.Redirect("AccessControl.aspx", False)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub

    Protected Sub Clear_Click(sender As Object, e As EventArgs) Handles Clear.Click
        Response.Redirect("AccessControl.aspx", False)
    End Sub
    Protected Sub SearchButton_Click(sender As Object, e As EventArgs) Handles SearchButton.Click
        Try
            Dim strQuery As String
            strQuery = "select Role.RID as [Role ID], Role.Role, ScreenList.ScreenName as Screen, ScreenList.ParentName as [Parent URL], ScreenList.Rights as [Child URL] from Role, ScreenList, AccessRights where Role.rid = AccessRights.RoleID and ScreenList.ScreenID = AccessRights.ScreenId
                        and concat (Role.RID, Role.Role, ScreenList.ScreenName, ScreenList.ParentName, ScreenList.Rights) Like '%" & Searchbox.Text & "%'"
            Dim Getdata As New GetdataSet()
            Dim Sqldataset As DataSet = Getdata.GetDataset(strQuery)
            GridView1.DataSource = Sqldataset.Tables(0)
            GridView1.DataBind()
            'Dim SendCount As String = Getdata.RowCount("select count(*)as Count from Role, ScreenList, AccessRights where Role.rid = AccessRights.RoleID and ScreenList.ScreenID = AccessRights.ScreenId and 
            'concat (Role.RID, Role.Role, ScreenList.ScreenName, ScreenList.ParentName, ScreenList.Rights) Like '%" & Searchbox.Text & "%'") & " Record(s) Found"
            Dim SendCount As String = GridView1.Rows.Count & " Record(s) Found"
            Call usermsg(LocalCall.Search_Message, LocalCall.Success_Back, LocalCall.Success_Front, SendCount)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Protected Sub Export_Click(sender As Object, e As EventArgs) Handles Export.Click
        Try
            Dim ExporttoExcel As New Export
            Dim Filename As String = "Access Control List_"
            ExporttoExcel.Export_Now(e, e, GridView1, Filename)
        Catch ex As Exception
            Call usermsg("Fatal Error: " & ex.Message, LocalCall.Failure_Back, LocalCall.Failure_Front)
        End Try
    End Sub
    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        ' Verifies that the control is rendered 
    End Sub

    Protected Sub usermsg(msg As String, BColor As Color, FColor As Color, Optional NCount As String = "0 Record(s) Found")
        Dim lbl As Label = Me.Master.FindControl("MessageFooter")
        lbl.Text = msg
        LblCount.Text = NCount
        lbl.BackColor = BColor
        lbl.ForeColor = FColor
    End Sub
End Class