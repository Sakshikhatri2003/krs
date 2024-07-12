<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="KRS_Academy.Login" %>

<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>LOGIN | KRS Academy</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
</head>
<style>
    .center-container {
        position: absolute;
        top: 40%;
        left: 50%;
        transform: translate(-50%, -50%);
    }
    .form-control {
        border-radius: 5px;
        border-color: #ddd;
        font-size: 14px;
        transition: border-color 0.3s ease-in-out;
    }
</style>
<body>
    <div class="center-container">
        <div class="container text-center" style="height: 400px; width: 600px; background-color: #fcfcfc; padding: 20px; border: 1px solid rgb(208, 207, 207); margin-top: 150px; border-radius: 15px;">
            <div class="logo" style="margin: 0 auto; text-align: center;">
                <img src="images/logo1.png" alt="" class="card-image" style="height: 150px;" />
                <h3 class="mt-4">Welcome to KRS Academy</h3>
            </div>

            <form method="post" runat="server">
                <div class="input-group mb-3">
                    <asp:TextBox ID="textbox1" runat="server" class="form-control" placeholder="Username"></asp:TextBox>
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-user"></span>
                        </div>
                    </div>
                </div>
                <div class="input-group mb-3">
                    <asp:TextBox ID="textbox2" runat="server" class="form-control" TextMode="Password" placeholder="Password"></asp:TextBox>
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-lock"></span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 text-center">
                        <asp:Button ID="button" runat="server" Text="Login" class="btn btn-primary btn-block" OnClick="button_Click" />
                    </div>
                </div>
            </form>
        </div>
    </div>
    <script src="dist/js/adminlte.min.js"></script>
</body>
</html>
