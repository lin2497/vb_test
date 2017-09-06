<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="Comment.aspx.vb" Inherits="vb_test.Comment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="callout callout-success">
                <h4>VB.NET Demo</h4>
                <p>This website is built by VB.NET for Chia-Hua Lin to apply .NET developer position in WWF.</p>
                <p>Source code:<a href="https://github.com/lin2497/vb_test">https://github.com/lin2497/vb_test</a></p>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="box box-solid box-primary">
                <div class="box-header">
                    <h3 class="box-title">Leave a comment</h3>
                    <div class="box-tools pull-right">
                        <button class="btn btn-primary btn-sm" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <form role="form" runat="server">
                        <!-- text input -->
                        <div class="alert alert-danger alert-dismissable" id="pan_error" runat="server" visible="false">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                            <h4><i class="icon fa fa-ban"></i>Alert!</h4>
                            <asp:Label ID="lbl_error" runat="server" Text="Some Error has occurred. Please make sure you have entered the right code."></asp:Label>
                        </div>
                        <div class="form-group">
                            <label>Nickname</label>
                            <input type="text" class="form-control" runat="server" id="txt_nick_name" placeholder="Enter ..." />
                        </div>
                        <div class="form-group">
                            <label>Title*</label>
                            <input type="text" class="form-control" runat="server" id="txt_title" placeholder="Enter ..." />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator_txt_title" runat="server"
                                ControlToValidate="txt_title"
                                ErrorMessage="Please enter a title"
                                ForeColor="Red">
                            </asp:RequiredFieldValidator>
                        </div>
                        <!-- textarea -->
                        <div class="form-group">
                            <label>Comment*</label>
                            <textarea class="form-control" rows="3" placeholder="Enter ..." runat="server" id="txt_comment"></textarea>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator_txt_comment" runat="server"
                                ControlToValidate="txt_comment"
                                ErrorMessage="Please write some comment before posting"
                                ForeColor="Red">
                            </asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <BotDetect:WebFormsCaptcha ID="ExampleCaptcha" runat="server" />
                        </div>
                        <div class="form-group">
                            <label>Please prove that you are not a bot.</label>
                            <asp:TextBox ID="CaptchaCodeTextBox" class="form-control" runat="server" />
                        </div>
                        <div class="form-group">
                            <asp:Button ID="Button1" class="btn btn-block btn-primary" runat="server" Text="Publish" />
                        </div>
                    </form>
                </div>
                <!-- /.box-body -->
            </div>
        </div>
        <div class="col-md-6">
            <!-- /.box-body -->
            <%
                For index = 0 To listComment.Count - 1
            %>
            <div class="row">
                <div class="col-md-12">
                    <!-- Info box -->
                    <div class="box box-primary">
                        <div class="box-header">
                            <h3 class="box-title"><%=listComment(index).title %></h3>
                            <div class="box-tools pull-right">
                                <%=listComment(index).dateTime %>
                            </div>
                        </div>
                        <div class="box-body">
                            <p>
                                <%=listComment(index).comment %>
                            </p>
                        </div>
                        <!-- /.box-body -->
                        <div class="box-footer">
                            BY <%=listComment(index).nickName %>
                        </div>
                        <!-- /.box-footer-->
                    </div>
                    <!-- /.box -->
                </div>
            </div>
            <%
                Next
            %>
        </div>
    </div>
</asp:Content>
