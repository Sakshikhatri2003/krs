<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StuMainMaster.Master" AutoEventWireup="true" CodeBehind="HindiTyping.aspx.cs" Inherits="KRS_Academy.Student.HindiTyping" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="TypingForm" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
            <Scripts>
                <asp:ScriptReference Path="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js" />
            </Scripts>
        </asp:ScriptManager>

        <!-- jQuery and Bootstrap CSS and JavaScript -->
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2"></div>
            </div>
        </section>

        <div class="container" style="border-radius: 10px;">
            <nav class="navbar bg-body-tertiary">
                <div class="card-header" style="text-align: left;">
                    <h5 class="card-title">Typing Tests</h5>
                </div>
            </nav>

            <asp:HiddenField ID="hfTypingId" runat="server" />
            <asp:HiddenField ID="LanguageCode" runat="server" />

            <asp:GridView ID="TypingTable" runat="server" class="table table-striped table-bordered table-hover my-2" Style="border-radius: 10px;" AutoGenerateColumns="false" OnRowCommand="TypingTable_RowCommand" DataKeyNames="TypingId">
                <Columns>
                    <asp:TemplateField HeaderText="S.No." HeaderStyle-CssClass="table-dark">
                        <ItemTemplate>
                            <%# Eval("TypingId") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Date" HeaderStyle-CssClass="table-dark">
                        <ItemTemplate>
                            <%# Convert.ToDateTime(Eval("Date")).ToString("dd-MMM-yyyy") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Language" HeaderStyle-CssClass="table-dark">
                        <ItemTemplate>
                            <%# Eval("Language") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Test Name" HeaderStyle-CssClass="table-dark">
                        <ItemTemplate>
                            <%# Eval("TestName") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total Words" HeaderStyle-CssClass="table-dark">
                        <ItemTemplate>
                            <%# Eval("TotalWords") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="table-dark">
                        <ItemTemplate>
                            <asp:LinkButton
                                ID="start"
                                runat="server"
                                CommandName="Start"
                                CommandArgument='<%# Eval("TypingId") %>'
                                Text="Start"
                                CssClass="btn btn-info"
                                OnClientClick='<%# "showModal(" + Eval("TypingId") + "); return false;" %>'>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <div class="modal fade" id="startTypingModal" tabindex="-1" role="dialog" aria-labelledby="startTypingModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="startTypingModalLabel">Start Typing Test</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="studentName">Student Name</label>
                            <asp:TextBox type="text" class="form-control" runat="server" ID="studentName" placeholder="Enter student name"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="mobileNo">Mobile No.</label>
                            <asp:TextBox type="text" class="form-control" runat="server" ID="mobileNo" placeholder="Enter mobile number"></asp:TextBox>
                        </div>
                        <div class="alert alert-danger" id="validationMessage" style="display:none;"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <asp:Button runat="server" ID="start_typing" Text="Start Typing" class="btn btn-primary" OnClientClick="validateAndSubmit(); return false;" OnClick="start_typing_Click" />
                    </div>
                </div>
            </div>
        </div>

        <link rel="stylesheet" href="dist/css/adminlte.min.css">
        <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
        <script src="plugins/toastr/toastr.min.js"></script>
        <script type="text/javascript">
            function showModal(typingId) {
                $('#<%= hfTypingId.ClientID %>').val(typingId);
                $('#startTypingModal').modal('show');
            }

            function validateAndSubmit() {
                var isValid = true;
                var validationMessage = '';

                var studentName = $('#<%= studentName.ClientID %>').val().trim();
                var mobileNo = $('#<%= mobileNo.ClientID %>').val().trim();

                if (studentName === '') {
                    isValid = false;
                    validationMessage += 'Please enter your name.<br>';
                }
                if (mobileNo === '') {
                    isValid = false;
                    validationMessage += 'Please enter your mobile number.<br>';
                }

                if (isValid) {
                    $('#<%= start_typing.ClientID %>').click();
                } else {
                    $('#validationMessage').html(validationMessage).show();
                }
            }

            function pageLoad(sender, args) {
                $('.toastrDefaultSuccess').click(function () {
                    toastr.success('Insert successfully');
                });

                $('.toastrDefaultError').click(function () {
                    toastr.error('Insert failed');
                });
            }
        </script>
    </form>
</asp:Content>
