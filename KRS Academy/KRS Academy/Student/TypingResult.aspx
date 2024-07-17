<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StuMainMaster.Master" AutoEventWireup="true" CodeBehind="TypingResult.aspx.cs" Inherits="KRS_Academy.Student.TypingResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="TypingForm" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
            <Scripts>
                <asp:ScriptReference Path="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js" />
                <asp:ScriptReference Path="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js" />
                <asp:ScriptReference Path="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap4.min.js" />
                <asp:ScriptReference Path="https://cdn.datatables.net/buttons/2.1.0/js/dataTables.buttons.min.js" />
                <asp:ScriptReference Path="https://cdn.datatables.net/buttons/2.1.0/js/buttons.bootstrap4.min.js" />
                <asp:ScriptReference Path="https://cdn.datatables.net/buttons/2.1.0/js/buttons.html5.min.js" />
                <asp:ScriptReference Path="https://cdn.datatables.net/buttons/2.1.0/js/buttons.print.min.js" />
                <asp:ScriptReference Path="https://cdn.datatables.net/buttons/2.1.0/js/buttons.colVis.min.js" />
            </Scripts>
        </asp:ScriptManager>

        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
        <link href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap4.min.css" rel="stylesheet" />
        <link href="https://cdn.datatables.net/buttons/2.1.0/css/buttons.bootstrap4.min.css" rel="stylesheet" />

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
            <div class="scroll">
                <asp:GridView ID="example1" runat="server" class="table table-striped table-bordered table-hover my-2" Style="border-radius: 10px;" AutoGenerateColumns="false" OnRowCommand="example1_RowCommand" DataKeyNames="Test_id">
                    <Columns>
                        <asp:TemplateField HeaderText="S.No." HeaderStyle-CssClass="table-dark">
                            <ItemTemplate>
                                <%# Eval("Test_id") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date" HeaderStyle-CssClass="table-dark">
                            <ItemTemplate>
                                <%# Convert.ToDateTime(Eval("Date")).ToString("dd-MMM-yyyy") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Student Name" HeaderStyle-CssClass="table-dark">
                            <ItemTemplate>
                                <%# Eval("StudentName") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mobile No." HeaderStyle-CssClass="table-dark">
                            <ItemTemplate>
                                <%# Eval("MobileNo") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Test Name" HeaderStyle-CssClass="table-dark">
                            <ItemTemplate>
                                <%# Eval("TestName") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="table-dark">
                            <ItemTemplate>
                                <asp:LinkButton
                                    ID="view"
                                    runat="server"
                                    CommandName="View"
                                    CommandArgument='<%# Eval("Test_id") %>'
                                    Text="View"
                                    CssClass="btn btn-success">
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                var table = $('#<%= example1.ClientID %>').DataTable({
                    "responsive": true,
                    "lengthChange": false,
                    "autoWidth": false,
                    "scrollY": "400px",
                    "scrollCollapse": true,
                    "paging": true,
                    "pageLength": 10,
                    "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
                });

                table.buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
            });

            function filterTable() {
                var table = $('#<%= example1.ClientID %>').DataTable();
                table.search($('#txtSearch').val()).draw();
            }
        </script>
    </form>
</asp:Content>
