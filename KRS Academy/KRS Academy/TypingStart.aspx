<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TypingStart.aspx.cs" Inherits="KRS_Academy.TypingStart" %>

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
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
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

    .typing-area {
        padding: 10px;
        overflow-y: auto;
    }

        .typing-area textarea {
            height: 300px; /* Adjust the value as per your requirement */
        }

    #result {
        margin-top: 20px;
        font-weight: bold;
    }

    .first {
        border-radius: 10px;
        margin: 20px;
    }

    .typing {
        border-radius: 10px;
        border: 5px solid rgb(131, 168, 196);
        margin: 20px;
        padding: 10px;
    }


    .d-grid {
        display: grid;
        gap: 2rem;
    }

    .sentence-container {
        height: 200px; /* Set the desired height for the container */
        overflow-y: auto; /* Enable vertical scrollbar when content overflows */
        padding: 10px; /* Add padding for a better visual appearance */
        border: 1px solid #ccc; /* Add a border for the container */
        background-color: rgb(255, 255, 255);
        border-radius: 10px;
        font-size: 25px;
        font-weight: 300;
        width: 100%;
    }

    .card-title {
        font-family: Arial, sans-serif;
        font-size: 1.5rem;
        font-weight: bold;
        text-align: center;
        color: #333;
        margin: 0;
        padding: 1rem;
        background-color: #f7f7f7;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    #submit-button {
        display: block;
        margin: 0 auto;
        width: 200px; /* Adjust the width as desired */
    }

    .hindiFont {
        font-size: 2rem;
        font-family: 'Mukta', sans-serif;
        src: url('https://fonts.googleapis.com/css2?family=Lexend+Deca:wght@200&family=PT+Sans&family=Roboto:wght@900&family=Tiro+Devanagari+Hindi:ital@0;1&display=swap');
    }

    .backspace-container {
        font-size: 18px;
        background-color: #e6e6ff;
        color: #4c4c99;
        padding: 10px;
        border-radius: 8px;
        margin-right: 20px;
    }

    .fa-solid.fa-stopwatch {
        margin-right: 10px;
        color: #4c4c99;
    }

    .timer {
        background-color: #f2f2f2;
        color: #4c4c99;
        padding: 10px 15px;
        border-radius: 5px;
    }


    .switch {
        position: relative;
        display: inline-block;
        width: 60px;
        height: 34px;
    }

        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

    .slider {
        position: absolute;
        cursor: pointer;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: #ccc;
        -webkit-transition: .4s;
        transition: .4s;
    }

        .slider:before {
            position: absolute;
            content: "";
            height: 26px;
            width: 26px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            -webkit-transition: .4s;
            transition: .4s;
        }

    input:checked + .slider {
        background-color: #2196F3;
    }

    input:focus + .slider {
        box-shadow: 0 0 1px #2196F3;
    }

    input:checked + .slider:before {
        -webkit-transform: translateX(26px);
        -ms-transform: translateX(26px);
        transform: translateX(26px);
    }

    /* Rounded sliders */
    .slider.round {
        border-radius: 34px;
    }

        .slider.round:before {
            border-radius: 50%;
        }

    .no-select {
        user-select: none; /* Supported by most modern browsers */
        -webkit-user-select: none; /* Safari */
        -moz-user-select: none; /* Firefox */
        -ms-user-select: none; /* Internet Explorer/Edge */
    }
</style>
<body class="hold-transition layout-top-nav" oncontextmenu="return false;">
    <div class="wrapper">
        <nav class="main-header navbar navbar-expand-md navbar-light navbar-white">
            <div class="container">
                <div class="collapse navbar-collapse order-3" id="navbarCollapse">
                    <!-- Left navbar links -->
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a href="Student/Dashboard.aspx" class="nav-link">Home</a>
                        </li>
                    </ul>

                    <div class="form-inline ml-0 ml-md-3">
                        <div class="input-group input-group-sm">
                            <input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search">
                            <div class="input-group-append">
                                <button class="btn btn-navbar" type="submit">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </nav>
        <form class="col-md-12" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

            <div class="content-wrapper">
                <!-- Content Header (Page header) -->
                <div class="card first">
                    <div class="card-body" style="display: flex; justify-content: space-between; align-items: center;">
                        <div class="d-grid gap-2 d-md-block">
                            <h4 class="card-title">
                                <asp:Label ID="TestName" runat="server"></asp:Label></h4>
                        </div>
                        <div class="items gap-2 mx-auto" style="display: flex;">
                            <h4 for="timeSelector" style="margin-right: 5px;">Select Time:</h4>
                            <asp:DropDownList class="form-control" runat="server" ID="timeSelector" Style="width: 100px; margin-right: 0;">
                                <asp:ListItem Value="10">10 min</asp:ListItem>
                                <asp:ListItem Value="20">20 min</asp:ListItem>
                                <asp:ListItem Value="30">30 min</asp:ListItem>
                                <asp:ListItem Value="40">40 min</asp:ListItem>
                                <asp:ListItem Value="50">50 min</asp:ListItem>
                            </asp:DropDownList>
                            <asp:Button class="btn btn-success mx-2" runat="server" Text="Start Typing" ID="startTypingButton" OnClick="startTypingButton_Click" />
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="timer" Style="color: black; font-size: large;" runat="server"></asp:Label>
                                    <asp:Timer ID="count" runat="server" Interval="1000" OnTick="count_Tick"></asp:Timer>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="count" EventName="Tick" />
                                    <asp:AsyncPostBackTrigger ControlID="startTypingButton" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                        <div class="backspace-container" style="text-align: center; display: flex; align-items: center;">
                            <h4 style="margin-right: 10px;">Backspace:</h4>
                            <asp:CheckBox ID="chk" runat="server" AutoPostBack="true" />
                            <button id="spaceCountButton" style="padding: 10px; border-radius: 5px; background-color: rgb(255, 255, 255);" disabled>
                                Space Count:
                                <asp:Label ID="backspace" runat="server"></asp:Label></button>
                        </div>
                        <div class="d-md-flex justify-content-md-end">
                            <h3 style="font-weight: 400;">Font Size:</h3>
                            <button class="btn btn-danger mx-2" value="Increase" id="inc" type="button">+</button>
                            <button class="btn btn-danger mx-2" value="Decrease" id="dec" type="button">-</button>
                        </div>
                    </div>
                </div>

                <div class="typing">
                    <div class="typing-area">
                        <div class="sentence-container">
                            <p id="sentence">
                                <asp:Label ID="input" CssClass="no-select" runat="server" Style="width: 100%;"></asp:Label>
                            </p>
                        </div>
                        <asp:TextBox ID="input_text" class="form-control mt-2 hindiFont" runat="server" TextMode="MultiLine" Style="width: 100%;" OnTextChanged="input_text_TextChanged"></asp:TextBox>

                    </div>
                    <asp:Button ID="submit_button" Style="align-items: center;" Text="Submit" runat="server" class="btn btn-primary mt-2 mb-2" OnClick="submit_button_Click" />
                    <div style="justify-content: right;">
                        <label>Speed: </label>
                        <asp:Label ID="lblTimeResult" Style="color: green;" runat="server"></asp:Label>
                    </div>
                </div>
                <asp:HiddenField ID="lblTyped" runat="server" />

            </div>
        </form>
        <aside class="control-sidebar control-sidebar-dark">
            <!-- Control sidebar content goes here -->
        </aside>
        <footer class="main-footer" style="text-align: center;">
            <strong>Copyright &copy; 2014-2021 <a href="https://adminlte.io">KRS Academy</a>.</strong> All rights reserved.
        </footer>
    </div>
    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="dist/js/adminlte.min.js"></script>
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/toastr/toastr.min.js"></script>
    <script type="text/javascript">
        const incButton = document.getElementById('inc');
        const decButton = document.getElementById('dec');
        const sentence = document.getElementById('sentence');

        incButton.addEventListener('click', increaseFontSize);
        decButton.addEventListener('click', decreaseFontSize);

        function increaseFontSize() {
            const currentSize = parseInt(window.getComputedStyle(sentence).fontSize);
            sentence.style.fontSize = `${currentSize + 2}px`;
        }

        function decreaseFontSize() {
            const currentSize = parseInt(window.getComputedStyle(sentence).fontSize);
            sentence.style.fontSize = `${currentSize - 2}px`;
        }

        const startTypingButton = document.getElementById('startTypingButton');
        const inputText = document.getElementById('input-text');

        startTypingButton.addEventListener('click', enableTyping);

        function enableTyping() {
            inputText.disabled = false;
            inputText.focus();
        }

        document.addEventListener('DOMContentLoaded', function () {
            const textInput = document.getElementById('<%=input_text.ClientID%>');
            const backspaceCountDisplay = document.getElementById('<%=backspace.ClientID%>');
            let backspaceCount = 0;
            let typingSpeed = 0;
            var ch = Boolean(document.getElementById("chk").checked);

            textInput.addEventListener('keydown', function (event) {
                if (event.key === 'Backspace') {
                    if (ch) {
                        backspaceCount++;
                        backspaceCountDisplay.textContent = backspaceCount;
                    }
                }
            });

            var startTime;
            var wordCount = 0;

            $(document).ready(function () {
                var inputTextId = '<%= input_text.ClientID %>';
                var lblTimeResultId = '<%= lblTimeResult.ClientID %>';

                $('#' + inputTextId).on('input', function () {
                    if (!startTime) {
                        startTime = new Date();
                    }
                    updateTypingSpeed(inputTextId, lblTimeResultId);
                });

                $('#submit_button').on('click', function () {
                    sendStatsToServer(backspaceCount, wordCount, typingSpeed);
                });
            });

            function updateTypingSpeed(inputTextId, lblTimeResultId) {
                var endTime = new Date();
                var durationInSeconds = (endTime - startTime) / 1000;

                var text = $('#' + inputTextId).val().trim();
                wordCount = text.split(/\s+/).length;

                if (durationInSeconds > 0) {
                    typingSpeed = (wordCount / durationInSeconds) * 60;
                    $('#' + lblTimeResultId).text('Your typing speed is approximately ' + typingSpeed.toFixed(2) + ' words per minute.');
                }
            }

            function sendStatsToServer(backspaceCount, wordCount, typingSpeed) {
                $.ajax({
                    type: 'POST',
                    url: 'TypingStart.aspx/SaveStats',
                    data: JSON.stringify({ backspaceCount: backspaceCount, wordCount: wordCount, typingSpeed: typingSpeed.toFixed(2) }),
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function (response) {
                        console.log('Stats saved successfully.');
                    },
                    error: function (error) {
                        console.log('Error saving stats: ' + error);
                    }
                });
            }
        });
        function pageLoad(sender, args) {
            $('.toastrDefaultSuccess').click(function () {
                toastr.success('Insert successfully');
            });

            $('.toastrDefaultError').click(function () {
                toastr.error('Insert failed');
            });
        }
    </script>
</body>
</html>
