Imports System.IO
Imports System.Configuration.ConfigurationManager
Imports System.Data.SqlClient

Public Class Comment
    Inherits System.Web.UI.Page
    Public listComment As New List(Of CComment)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        UnobtrusiveValidationMode = UnobtrusiveValidationMode.None
        Dim connectionString As String = CType(AppSettings("connectionString"), String)
        Using conn As New SqlClient.SqlConnection(connectionString)
            Using cmdObj As New SqlClient.SqlCommand("select * from VBComment order by date desc", conn)
                conn.Open()
                Using readerObj As SqlClient.SqlDataReader = cmdObj.ExecuteReader
                    'This will loop through all returned records 
                    While readerObj.Read
                        Dim comment As New CComment
                        comment.id = readerObj("id")
                        comment.title = readerObj("title").ToString
                        comment.comment = readerObj("comment").ToString
                        comment.nickName = readerObj("nickName").ToString
                        comment.dateTime = readerObj("date").ToString()
                        listComment.Add(comment)
                    End While
                End Using
                conn.Close()
            End Using
        End Using
    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        If IsPostBack Then
            Dim isHuman As Boolean = ExampleCaptcha.Validate(CaptchaCodeTextBox.Text)
            CaptchaCodeTextBox.Text = Nothing
            If Not isHuman Then
                lbl_error.Text = "Please make sure you entered the right code before posting."
                pan_error.Visible = True
            Else
                Dim posterName As String
                If String.IsNullOrEmpty(txt_nick_name.Value) Then
                    posterName = "Anonymous"
                Else
                    posterName = txt_nick_name.Value
                End If
                addComment(txt_title.Value, txt_comment.Value, posterName)
            End If
        End If
    End Sub
    Public Sub addComment(title As String, comment As String, nickName As String)
        Dim connectionString As String = CType(AppSettings("connectionString"), String)
        Dim query As String = "insert into VBComment(title,comment,nickName,date) "
        query &= "values(@data_title,@data_comment,@data_nick_name,@data_date)"
        Using conn As New SqlConnection(connectionString)
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@data_title", title)
                    .Parameters.AddWithValue("@data_comment", comment)
                    .Parameters.AddWithValue("@data_nick_name", nickName)
                    .Parameters.AddWithValue("@data_date", DateTime.Now())
                End With
                Try
                    conn.Open()
                    comm.ExecuteNonQuery()
                    Response.Redirect(HttpContext.Current.Request.Url.ToString(), True)
                Catch ex As Exception
                    lbl_error.Text = "Some Error has occurred." '''ex.ToString()
                    pan_error.Visible = True
                End Try
            End Using
        End Using

    End Sub
End Class