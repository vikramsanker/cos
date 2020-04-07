Public Class Field_Validation
    Public Function ValidateFields(ByVal Input As GroupBox) As Integer
        Dim Count As Integer
        Count = 0
        For Each fld As Control In Input.Controls
            If TypeOf fld Is ComboBox Or TypeOf fld Is TextBox Or TypeOf fld Is RichTextBox Then
                If fld.Text = Nothing Then
                    fld.BackColor = Color.Yellow
                    Count = Count + 1
                End If
            End If
        Next
        Return (Count)
    End Function
End Class
