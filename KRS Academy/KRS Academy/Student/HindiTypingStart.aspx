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
                            <p id="sentence" class="hindi-font">
                                <asp:Label ID="input" CssClass="no-select" runat="server" Style="width: 100%;"></asp:Label>
                            </p>
                        </div>
                        <b>
                            <asp:Label CssClass="no-select" runat="server" Style="color: cornflowerblue;" Text="यहां से टाइप करना शुरू करें:"></asp:Label></b>
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
            var backspaceCount = 0;
            var totalWords = 0;
            var typingSpeed = 0;
            var startTime;

            document.addEventListener('DOMContentLoaded', function () {
                const textInput = document.getElementById('<%=input_text.ClientID%>');
                const backspaceCountDisplay = document.getElementById('<%=backspace.ClientID%>');

                textInput.addEventListener('keydown', function (event) {
                    if (event.key === 'Backspace') {
                        const ch = document.getElementById("chk").checked;
                        if (ch) {
                            backspaceCount++;
                            backspaceCountDisplay.textContent = backspaceCount;
                        }
                    }
                });
            });

            $(document).ready(function () {
                const textInput = document.getElementById('<%=input_text.ClientID%>');
                const submitButton = document.getElementById('<%=submit_button.ClientID%>');
                const startTypingButton = document.getElementById('<%=startTypingButton.ClientID%>');

                submitButton.style.display = 'none';
                textInput.readOnly = true;

                startTypingButton.addEventListener('click', function () {
                    submitButton.style.display = 'block';
                    textInput.readOnly = false;
                    startTime = new Date();
                });

                textInput.addEventListener('input', function () {
                    updateTypingSpeed();
                    updateCurrentWordsCount();
                });

                submitButton.addEventListener('click', function () {
                    updateTotalWordsCount();
                    sendStatsToServer(backspaceCount, totalWords, typingSpeed);
                });

                updateTotalWordsCount();
            });

            function updateTypingSpeed() {
                var endTime = new Date();
                var durationInSeconds = (endTime - startTime) / 1000;
                var text = $('#<%=input_text.ClientID%>').val().trim();
                var wordCount = countWordsInHindi(text);

                if (durationInSeconds > 0) {
                    typingSpeed = (wordCount / durationInSeconds) * 60;
                }

                $('#<%=lblTimeResult.ClientID%>').text('Speed: ' + Math.round(typingSpeed) + ' WPM');
            }

            function countWordsInHindi(text) {
                return text.split(/\s+/).filter(function (word) { return word.length > 0; }).length;
            }

            function updateCurrentWordsCount() {
                const text = document.getElementById('<%=input_text.ClientID%>').value.trim();
                const currentWords = countAllCharacters(text) / 5;
                document.getElementById('currentWords').textContent = currentWords.toFixed(0);
            }

            function updateTotalWordsCount() {
                var sentenceElement = document.getElementById('<%=input.ClientID%>');
                var totalWordsElement = document.getElementById('totalWords');
                var text = sentenceElement.textContent.trim();
                totalWords = countAllCharacters(text) / 5;
                totalWordsElement.textContent = totalWords.toFixed(0);
            }
            function countAllCharacters(text) {
                return text.length;
            }

            function sendStatsToServer(backspaceCount, totalWords, typingSpeed) {
                console.log('Sending stats:', {
                    backspaceCount: backspaceCount,
                    totalWords: parseInt(totalWords, 10),
                    typingSpeed: Math.round(typingSpeed)
                });

                $.ajax({
                    type: 'POST',
                    url: 'TypingStart.aspx/SaveStats',
                    data: JSON.stringify({
                        backspaceCount: backspaceCount,
                        totalWords: parseInt(totalWords, 10),
                        typingSpeed: Math.round(typingSpeed)
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        console.log('Stats sent successfully');
                    },
                    error: function (error) {
                        console.error('Error sending stats:', error);
                    }
                });
            }

            function changeFontSize(action) {
                var sentenceElement = document.getElementById('<%=input.ClientID%>');
                var inputTextElement = document.getElementById('<%=input_text.ClientID%>');

                var currentFontSize = parseFloat(window.getComputedStyle(sentenceElement, null).getPropertyValue('font-size'));
                var inputTextFontSize = parseFloat(window.getComputedStyle(inputTextElement, null).getPropertyValue('font-size'));

                if (action === 'increase') {
                    sentenceElement.style.fontSize = (currentFontSize + 1) + 'px';
                    inputTextElement.style.fontSize = (inputTextFontSize + 1) + 'px';
                } else if (action === 'decrease') {
                    sentenceElement.style.fontSize = (currentFontSize - 1) + 'px';
                    inputTextElement.style.fontSize = (inputTextFontSize - 1) + 'px';
                }
            }

            function toggleFullScreen() {
                if (document.fullscreenElement) {
                    document.exitFullscreen();
                } else {
                    document.documentElement.requestFullscreen();
                }
            }
        </script>
    </form>
</body>
</html>
