<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MainMaster.Master" AutoEventWireup="true" CodeBehind="TypingMaster.aspx.cs" Inherits="KRS_Academy.Admin.TypingMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="styles.css">
    <form id="TypingForm" runat="server">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 mx-auto">
                    <div class="card card-notice">
                        <div class="card-header">
                            <h5 class="card-title">Add Typing Content</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="noticeDate">Date</label>
                                        <asp:TextBox type="date" runat="server" class="form-control" ID="Date"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="noticeType">Language</label>
                                        <asp:DropDownList class="form-control" runat="server" ID="languageDrp" AutoPostBack="true" OnSelectedIndexChanged="languageDrp_SelectedIndexChanged">
                                            <asp:ListItem Value="">Select Type</asp:ListItem>
                                            <asp:ListItem Value="1">Hindi</asp:ListItem>
                                            <asp:ListItem Value="0">English</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="noticeTitle">Test Name</label>
                                        <asp:TextBox runat="server" class="form-control" ID="testName" placeholder="Enter Test Name"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div style="margin-bottom: 10px;">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label for="noticeContent">Input Text</label>
                                            <asp:TextBox class="form-control" runat="server" ID="Content" AutoPostBack="true" TextMode="MultiLine" OnTextChanged="Content_TextChanged" placeholder="Enter content" Visible="true"></asp:TextBox>
                                            <asp:TextBox class="form-control hindi-font" runat="server" ID="HindiContent1" AutoPostBack="true" TextMode="MultiLine" OnTextChanged="HindiContent1_TextChanged" placeholder="Enter content" Visible="false"></asp:TextBox>

                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <p id="totalWords">
                                            Total Words: <u>
                                                <asp:Label ID="WordsNo" runat="server" Style="color: red;"></asp:Label></u>
                                        </p>
                                    </div>
                                    <div class="col-md-6 d-flex justify-content-center">
                                        <asp:Button type="submit" runat="server" ID="submit" OnClick="submit_Click" Text="Submit" class="btn btn-primary mb-2" />
                                        <asp:Button type="button" runat="server" ID="update" OnClick="update_Click" Text="Update" class="btn btn-secondary mb-2" Visible="false" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container mt-3" style="border-radius: 10px;">
            <asp:HiddenField ID="hfTypingId" runat="server" />
            <asp:GridView ID="TypingTable" runat="server" class="table table-striped table-bordered table-hover my-2" AutoGenerateColumns="false" DataKeyNames="TypingId" OnRowCommand="TypingTable_RowCommand" OnRowDeleting="TypingTable_RowDeleting">
                <Columns>
                    <asp:TemplateField HeaderText="S.No." HeaderStyle-CssClass="table-dark">
                        <ItemTemplate>
                            <%# Container.DataItemIndex + 1 %>
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
                            <asp:LinkButton ID="Edit" runat="server" CommandName="EditRow" CommandArgument='<%# Eval("TypingId") %>' Text="Edit" class="btn btn-primary mr-2"><i class="fas fa-edit"></i></asp:LinkButton>
                            <asp:LinkButton ID="Delete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("TypingId") %>' Text="Delete" class="btn btn-danger"><i class="fas fa-trash"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <link rel="stylesheet" href="dist/css/adminlte.min.css">
        <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
        <script src="plugins/jquery/jquery.min.js"></script>
        <script src="plugins/toastr/toastr.min.js"></script>
        <script type="text/javascript">
            function pageLoad(sender, args) {
                $('.toastrDefaultSuccess').click(function () {
                    toastr.success('Update successful');
                });

                $('.toastrDefaultError').click(function () {
                    toastr.error('Update failed');
                });
            }
        </script>
    </form>
</asp:Content>

