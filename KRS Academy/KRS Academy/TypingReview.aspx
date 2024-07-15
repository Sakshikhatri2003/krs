<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TypingReview.aspx.cs" Inherits="KRS_Academy.TypingReview" %>


<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Typing Tests | KRS Academy</title>

    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
</head>

<style>
    body {
        background: #e9e9e9;
        background-size: cover;
        background-repeat: no-repeat;
    }

    .nav-link .icon {
        filter: invert(500%); /* Set the desired filter */
    }



    /* Reduce width of card */
    .card {
        margin: 0 auto;
        background: rgb(240, 240, 240);
        height: 100%;
        margin: 20px;
    }



    /* Customize card header */
    .card-header {
        background-color: #ffffff;
        border-bottom: 1px solid #ced4da;
        display: flex;
        align-items: center;
    }

        .card-header a {
            color: #6c757d;
            font-size: 1.5rem;
            margin-right: 10px;
        }

        .card-header h4 {
            margin-bottom: 0;
        }

    .btn-light {
        background-color: rgb(255, 255, 255);
        border: 1px solid rgb(223, 223, 223);
    }

    .container-2 {
        background-color: #fff;
        padding: 15px;
        border-radius: 10px;
        border: 1px solid rgb(220, 220, 220);
    }



    .inner-card {
        background-color: #f2f2f2;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        padding: 5px;
        margin: 5px;
    }

    .card-body {
        margin-bottom: 5px;
    }

    .row {
        display: flex;
        align-items: center;
        margin-bottom: 5px;
    }

    .col {
        flex: 1;
        display: flex;
        align-items: center;
    }

    .option {
        display: flex;
        align-items: center;
    }

    img {
        margin-right: 10px;
    }

    h5 {
        margin-bottom: 10px;
    }

    h6 {
        margin: 0;
    }

    /* Additional styles to make it look modern */
    .inner-card {
        background-color: #ffffff;
        color: #333333;
    }



    h5 {
        font-size: 16px;
        font-weight: bold;
        margin-bottom: 5px;
    }

    h6 {
        font-size: 14px;
    }

    img {
        vertical-align: middle;
    }
</style>
<body class="hold-transition layout-top-nav">
    <div class="wrapper">

        <!-- Navbar -->
        <nav class="main-header navbar navbar-expand-md navbar-light navbar-white">
            <div class="container">



                <div class="collapse navbar-collapse order-3" id="navbarCollapse">
                    <!-- Left navbar links -->
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a href="Student/Dashboard.aspx" class="nav-link">Home</a>
                        </li>

                    </ul>

                    <!-- SEARCH FORM -->
                    <form class="form-inline ml-0 ml-md-3">
                        <div class="input-group input-group-sm">
                            <input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search">
                            <div class="input-group-append">
                                <button class="btn btn-navbar" type="submit">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- Right navbar links -->
                <ul class="order-1 order-md-3 navbar-nav navbar-no-expand ml-auto">
                    <!-- Messages Dropdown Menu -->

                </ul>
            </div>
        </nav>
        <form id="form1" runat="server">
            <div class="content-wrapper">
                <div class="card bg-info">
                    <div class="card-body">
                        <div style="display: flex; align-items: center;">
                            <img src="images/trophy.png" alt="Trophy" width="50" height="50" style="margin-right: 200px;">
                            <div>
                                <h2 class="text-center" style="font-weight: 500;">Congratulations <asp:Label ID="stuName" runat="server"></asp:Label> You have completed the exam successfully.</h2>
                                <h4 class="text-center" style="font-weight: 500;">Let's see how you performed</h4>
                            </div>
                        </div>

                        <hr>
                        <div class="inner-card mb-2">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col option">
                                        <img src="images/check.png" alt="Correct" width="20" height="20">Skipped Words:  
                      <h6>&nbsp; <asp:Label ID="SkippedWord" runat="server"></asp:Label></h6>
                                    </div>
                                    <div class="col option">
                                        <img src="images/check.png" alt="Incorrect" width="20" height="20">Total Backspace Pressed:
                      <h6>&nbsp; <asp:Label ID="Backspace" runat="server"></asp:Label> Times</h6>
                                    </div>
                                    <div class="col option">
                                        <img src="images/check.png" alt="Attempted" width="20" height="20">Total Time Allotted:
                      &nbsp;<asp:Label ID="TimeAllocate" runat="server"></asp:Label> Mins
                                    </div>
                                    <div class="col option">
                                        <img src="images/check.png" alt="Unattempted" width="20" height="20">
                                        Time Taken:
                      <h6>&nbsp;<asp:Label ID="TimeTaken" runat="server"></asp:Label></h6>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col option">
                                        <img src="images/check.png" alt="Correct" width="20" height="20">Total Words:  
                      &nbsp; <asp:Label ID="TotalWords" runat="server"></asp:Label>
                                    </div>
                                    <div class="col option">
                                        <img src="images/check.png" alt="Correct" width="20" height="20">Gross Speed:  
                      &nbsp; <asp:Label ID="GrossSpeed" runat="server"></asp:Label> WPM
                                    </div>
                                    <div class="col option">
                                        <img src="images/check.png" alt="Incorrect" width="20" height="20">Correct Characters:
                      &nbsp<asp:Label ID="CorrectWords" runat="server"></asp:Label> (0 Words)
                                    </div>
                                    <div class="col option">
                                        <img src="images/check.png" alt="Attempted" width="20" height="20">
                                        Wrong Characters:
                      &nbsp;<asp:Label ID="WrongWords" runat="server"></asp:Label> (0 Words)
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col option">
                                        <img src="images/check.png" alt="Unattempted" width="20" height="20">
                                        Accuracy:
                      &nbsp;<asp:Label ID="Accuracy" runat="server"></asp:Label>
                                    </div>
                                    <div class="col option">
                                        <img src="images/check.png" alt="Correct" width="20" height="20">Marks Out of 50 : 
                      &nbsp;0.00
                                    </div>
                                    <div class="col option"></div>
                                    <div class="col option"></div>
                                </div>
                            </div>
                    </div>
                </div>
                <div class="inner-card">
                    <div class="card-body">
                        <p id="LblResult" runat="server" class="card-text">
                            <asp:Label ID="LblResult1" runat="server" />
                        </p>
                    </div>
                </div>
            </div>
    </div>
    </form>
        <!-- /.content-wrapper -->

    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
        <!-- Control sidebar content goes here -->
    </aside>
    <!-- /.control-sidebar -->
    <footer class="main-footer" style="text-align: center;">
        <!-- To the right -->
        <!-- Default to the left -->
        <strong>Copyright &copy; 2014-2021 <a href="https://adminlte.io">KRS Academy</a>.</strong> All rights reserved.
    </footer>
    <!-- Main Footer -->

    </div>
    <!-- ./wrapper -->

    <!-- REQUIRED SCRIPTS -->

    <!-- jQuery -->
    <script src="plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.min.js"></script>
    <script src="plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.min.js"></script>
</body>
</html>



