<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StuMainMaster.Master" AutoEventWireup="true" CodeBehind="Typing.aspx.cs" Inherits="KRS_Academy.Student.Typing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="TypingForm" runat="server">

        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                </div>
            </div>
            <!-- /.container-fluid -->
        </section>
        <div class="container" style="border-radius: 10px;">
            <nav class="navbar bg-body-tertiary">
                <div class="card-header" style="text-align:left;">
                    <h5 class="card-title">Typing Tests</h5>
                </div>
            </nav>
            <asp:HiddenField ID="hfTypingId" runat="server" />
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
                            <asp:LinkButton ID="start" runat="server" CommandName="Start" CommandArgument='<%# Eval("TypingId") %>' Text="Start" class="btn btn-info"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</asp:Content>
