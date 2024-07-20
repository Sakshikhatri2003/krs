<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HindiTypingStart.aspx.cs" Inherits="KRS_Academy.Student.HindiTypingStart" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Typing Tests | KRS Academy</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <!-- Custom styles -->
    <link rel="stylesheet" href="styles.css">
    <!-- Add Google Font for Hindi -->
   
   
    
</head>
<body class="hold-transition layout-top-nav" oncontextmenu="return false;">
    <form class="col-md-12" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="wrapper">
            <!-- Navbar -->
            <nav class="main-header navbar navbar-expand-md navbar-light navbar-white">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item d-none d-sm-inline-block">
                        <a href="Dashboard.aspx" class="nav-link">Home</a>
                    </li>
                </ul>
                <h6 style="margin-top: 10px;">
                    <asp:Label ID="TestName" runat="server"></asp:Label>
                </h6>
                <div class="container">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <span class="nav-label">Total words:</span> <span id="totalWords">0</span>
                        </li>
                        <li class="nav-item">
                            <span class="nav-label">Current Typing words:</span> <span id="currentWords">0</span>
                        </li>
                        <li class="nav-item">
                            <asp:Label ID="lblTimeResult" Style="color: green;" runat="server"></asp:Label>
                        </li>
                    </ul>
                </div>
            </nav>
            <!-- /.navbar -->

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <!-- Setting Box -->
                <div class="card first mt-3">
                    <div class="card-body">
                        <div class="backspace-container">
                            <label for="timeSelector">Select Time:</label>
                            <asp:DropDownList class="form-control" runat="server" ID="timeSelector" Style="width: 80px; margin-right: 0;">
                                <asp:ListItem Value="10">10 min</asp:ListItem>
                                <asp:ListItem Value="20">20 min</asp:ListItem>
                                <asp:ListItem Value="30">30 min</asp:ListItem>
                                <asp:ListItem Value="40">40 min</asp:ListItem>
                                <asp:ListItem Value="50">50 min</asp:ListItem>
                            </asp:DropDownList>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="timer" Style="color: black; font-size: large; width: 20px;" runat="server"></asp:Label>
                                    <asp:Timer ID="count" runat="server" Interval="1000" OnTick="count_Tick"></asp:Timer>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="count" EventName="Tick" />
                                    <asp:AsyncPostBackTrigger ControlID="startTypingButton" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                        <br>
                        <div class="backspace-container">
                            <label for="backspaceSwitch" style="margin-right: 10px;">Backspace:</label>
                            <label>
                                <asp:CheckBox ID="chk" Style="margin-top: 5px;" runat="server" AutoPostBack="true" />
                                Count:
                                <asp:Label ID="backspace" runat="server"></asp:Label>
                            </label>
                        </div>
                        <br>
                        <div class="backspace-container">
                            <h5 style="margin-right: 10px;">Font Size:</h5>
                            <button class="btn btn-danger btn-sm mx-1" onclick="changeFontSize('increase')" id="inc">+</button>
                            <button class="btn btn-danger btn-sm mx-1" onclick="changeFontSize('decrease')" id="dec">-</button>
                        </div>
                        <br>
                        <asp:Button class="btn btn-success mx-2 btn-sm" runat="server" Text="Start Typing" ID="startTypingButton" OnClick="startTypingButton_Click" />
                        <button class="btn btn-primary btn-sm" onclick="toggleFullScreen()">Exam Mode</button>
                    </div>
                </div>
                <!-- Setting Box End -->

                <!-- Typing Section -->
                <div class="typing" id="typingDiv">
                    <div class="typing-area">
                        <div class="sentence-container">
                            <p id="sentence" class="hindi-font" >
                                <asp:Label ID="input" CssClass="no-select" runat="server" Style="width: 100%;"></asp:Label>
                            </p>
                        </div>
                        <asp:TextBox ID="input_text" CssClass="form-control mt-2 hindi-font" runat="server" TextMode="MultiLine" Rows="8" Style="width: 100%;" OnTextChanged="input_text_TextChanged"></asp:TextBox>
                        <asp:Button ID="submit_button" Text="Submit" runat="server" class="btn btn-primary mt-2 mb-2" OnClick="submit_button_Click" />
                        <asp:HiddenField ID="lblTyped" runat="server" />
                    </div>

                </div>
                <!-- /.content-wrapper -->

                <!-- Control Sidebar -->
                <aside class="control-sidebar control-sidebar-dark">
                    <!-- Control sidebar content goes here -->
                </aside>
                <!-- /.control-sidebar -->
            </div>
        </div>
        <script src="plugins/jquery/jquery.min.js"></script>
        <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="dist/js/adminlte.min.js"></script>
        <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
        <script src="plugins/toastr/toastr.min.js"></script>
        <script>
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
                    }

                    $('#' + lblTimeResultId).text('Speed: ' + Math.round(typingSpeed) + ' WPM');
                }

                function sendStatsToServer(backspaceCount, wordCount, typingSpeed) {
                    $.ajax({
                        type: 'POST',
                        url: 'YourServerEndpoint.aspx',
                        data: {
                            backspaceCount: backspaceCount,
                            wordCount: wordCount,
                            typingSpeed: typingSpeed
                        },
                        success: function (response) {
                            console.log('Stats sent successfully');
                        },
                        error: function (error) {
                            console.error('Error sending stats:', error);
                        }
                    });
                }
            });

            function changeFontSize(action) {
                var textArea = document.getElementById('<%=input_text.ClientID%>');
                var currentFontSize = window.getComputedStyle(textArea, null).getPropertyValue('font-size');
                var newFontSize;

                if (action === 'increase') {
                    newFontSize = (parseFloat(currentFontSize) + 2) + 'px';
                } else if (action === 'decrease') {
                    newFontSize = (parseFloat(currentFontSize) - 2) + 'px';
                }

                textArea.style.fontSize = newFontSize;
            }

            function toggleFullScreen() {
                if (!document.fullscreenElement) {
                    document.documentElement.requestFullscreen();
                } else {
                    if (document.exitFullscreen) {
                        document.exitFullscreen();
                    }
                }
            }
        </script>
    </form>
</body>
</html>
