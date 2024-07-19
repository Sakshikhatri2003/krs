<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TypingStart.aspx.cs" Inherits="KRS_Academy.TypingStart" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Typing Tests | KRS Academy</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body class="hold-transition layout-top-nav" oncontextmenu="return false;">
    <form class="col-md-12" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="wrapper">
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
                            <span class="nav-label">Total words:</span> <span id="totalsWords">
                                <asp:Label ID="totalWords" runat="server"></asp:Label></span>
                        </li>
                        <li class="nav-item">
                            <span class="nav-label">Current Typing words:</span> <span id="currentsWords">
                                <asp:Label ID="currentWords" runat="server"></asp:Label></span>
                        </li>
                        <li class="nav-item">
                            <asp:Label ID="lblTimeResult" Style="color: green;" runat="server"></asp:Label>
                        </li>
                    </ul>
                </div>
            </nav>
            <div class="content-wrapper">
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
                                <asp:CheckBox ID="chk" Style="margin-top: 5px;" runat="server" AutoPostBack="true" OnClientClick="toggleBackspaceCount(this);" />
                                Count:
                                <asp:Label ID="backspace" runat="server"></asp:Label>
                            </label>
                        </div>
                        <br>
                        <div class="backspace-container">
                            <h5 style="margin-right: 10px;">Font Size:</h5>
                            <button class="btn btn-danger btn-sm mx-1" type="button" onclick="changeFontSize('increase')" id="inc">+</button>
                            <button class="btn btn-danger btn-sm mx-1" type="button" onclick="changeFontSize('decrease')" id="dec">-</button>
                        </div>
                        <br>
                        <asp:Button class="btn btn-success mx-2 btn-sm" runat="server" Text="Start Typing" ID="startTypingButton" OnClientClick="return enableReadOnly();" OnClick="startTypingButton_Click" />
                        <button class="btn btn-primary btn-sm" type="button" onclick="toggleFullScreen()">Exam Mode</button>
                    </div>
                </div>
                <div class="typing" id="typingDiv">
                    <div class="typing-area">
                        <div class="sentence-container">
                            <p id="sentence">
                                <asp:Label ID="input" CssClass="no-select" runat="server" Style="width: 100%;"></asp:Label>
                            </p>
                        </div>
                        <asp:TextBox ID="input_text" class="form-control mt-2 hindiFont" runat="server" TextMode="MultiLine" Rows="8" Style="font-family: 'Tiro Devanagari Hindi'; width: 100%;" OnTextChanged="input_text_TextChanged"></asp:TextBox>
                        <asp:Button ID="submit_button" Text="Submit" runat="server" class="btn btn-primary mt-2 mb-2" OnClick="submit_button_Click" Enabled="false" />
                        <asp:HiddenField ID="lblTyped" runat="server" />
                    </div>
                </div>
            </div>
            <aside class="control-sidebar control-sidebar-dark"></aside>
        </div>
        <script src="plugins/jquery/jquery.min.js"></script>
        <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="dist/js/adminlte.min.js"></script>
        <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
        <script src="plugins/toastr/toastr.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const inputTextElement = document.getElementById('<%= input_text.ClientID %>');
                const currentWordsElement = document.getElementById('<%= currentWords.ClientID %>');
                const backspaceCountDisplay = document.getElementById('<%= backspace.ClientID %>');
                const lblTimeResultElement = document.getElementById('<%= lblTimeResult.ClientID %>');

                inputTextElement.addEventListener('input', updateCurrentWordsCount);
                inputTextElement.addEventListener('keydown', countBackspaces);

                let backspaceCount = 0;
                let startTime;

                function updateCurrentWordsCount() {
                    const text = inputTextElement.value.trim();
                    const totalCharacters = text.length;
                    const totalWords = totalCharacters / 5;

                    currentWordsElement.textContent = totalWords.toFixed(0);
                }

                function countBackspaces(event) {
                    if (event.key === 'Backspace') {
                        backspaceCount++;
                        backspaceCountDisplay.textContent = backspaceCount;
                    }
                }

                function enableReadOnly() {
                    inputTextElement.readOnly = false;
                    inputTextElement.value = "";
                    inputTextElement.focus();
                    startTime = new Date();
                    return false;
                }

                function updateTypingSpeed() {
                    const endTime = new Date();
                    const durationInSeconds = (endTime - startTime) / 1000;
                    const text = inputTextElement.value.trim();
                    const wordCount = text.split(/\s+/).filter(word => word.length > 0).length;

                    if (durationInSeconds > 0) {
                        const wpm = (wordCount / durationInSeconds) * 60;
                        const speedText = 'Your typing speed is approximately <b>' + wpm.toFixed(2) + ' words per minute</b>.';

                        // Output the speed to lblTimeResult
                        lblTimeResultElement.innerHTML = speedText;

                        // Change font color based on typing speed
                        if (wpm < 50) {
                            lblTimeResultElement.style.color = 'red';
                        } else {
                            lblTimeResultElement.style.color = 'green';
                        }
                    }
                }

                inputTextElement.addEventListener('input', updateTypingSpeed);

                function updateTotalWordsCount() {
                    const sentenceElement = document.getElementById('<%= input_text.ClientID %>');
                    const totalWordsElement = document.getElementById('<%= totalWords.ClientID %>');

                    const text = sentenceElement.value.trim();
                    const totalCharacters = text.length;
                    const totalWords = totalCharacters / 5;

                    totalWordsElement.textContent = totalWords.toFixed(0);
                }

                document.addEventListener('DOMContentLoaded', updateTotalWordsCount);

                function changeFontSize(action) {
                    const inputText = document.getElementById('<%= input_text.ClientID %>');
                    const currentFontSize = window.getComputedStyle(inputText).fontSize;
                    const currentFontSizeValue = parseFloat(currentFontSize);

                    if (action === 'increase') {
                        inputText.style.fontSize = (currentFontSizeValue + 1) + 'px';
                    } else if (action === 'decrease') {
                        inputText.style.fontSize = (currentFontSizeValue - 1) + 'px';
                    }
                }

                function toggleFullScreen() {
                    const elem = document.documentElement;

                    if (!document.fullscreenElement) {
                        if (elem.requestFullscreen) {
                            elem.requestFullscreen();
                        } else if (elem.mozRequestFullScreen) {
                            elem.mozRequestFullScreen();
                        } else if (elem.webkitRequestFullscreen) {
                            elem.webkitRequestFullscreen();
                        } else if (elem.msRequestFullscreen) {
                            elem.msRequestFullscreen();
                        }
                    } else {
                        if (document.exitFullscreen) {
                            document.exitFullscreen();
                        } else if (document.mozCancelFullScreen) {
                            document.mozCancelFullScreen();
                        } else if (document.webkitExitFullscreen) {
                            document.webkitExitFullscreen();
                        } else if (document.msExitFullscreen) {
                            document.msExitFullscreen();
                        }
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
    </form>
</body>
</html>
