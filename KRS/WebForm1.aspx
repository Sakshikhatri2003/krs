<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="KRS.WebForm1" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Paragraph Comparison</title>
    <style>
        .highlight { background-color: yellow; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Paragraph Comparison</h2>
            <label for="txtParagraph1">Paragraph 1:</label><br />
            <textarea id="txtParagraph1" runat="server" rows="10" cols="50"></textarea><br />
            <label for="txtParagraph2">Paragraph 2:</label><br />
            <textarea id="txtParagraph2" runat="server" rows="10" cols="50"></textarea><br />
            <asp:Button ID="btnCompare" runat="server" Text="Compare" OnClick="btnCompare_Click" /><br />
            <asp:Literal ID="ltlResult" runat="server"></asp:Literal>
        </div>
    </form>
</body>
</html>