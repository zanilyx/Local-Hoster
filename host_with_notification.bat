@echo off
setlocal enabledelayedexpansion

REM Initialize folder path from command line argument
set "folder=%~1"

REM Get folder name for URL display
for %%A in ("%folder%") do set "folderName=%%~nxA"

REM Get local IPv4 address
for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr /i "IPv4"') do (
    set "ip=%%A"
)
set "ip=%ip:~1%"

REM Store server PID for clean shutdown
set "pidfile=%temp%\http_server_pid.txt"

REM Notify server startup
powershell -Command "[void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); $balloon = New-Object System.Windows.Forms.NotifyIcon; $balloon.Icon = [System.Drawing.SystemIcons]::Information; $balloon.Visible = $true; $balloon.ShowBalloonTip(3000, 'Starting Server', 'HTTP Server is starting...', [System.Windows.Forms.ToolTipIcon]::Info)"

REM Launch Python HTTP server
powershell -Command "Start-Process cmd -ArgumentList '/c cd \"%folder%\" && python -m http.server' -WindowStyle Hidden -PassThru | ForEach-Object { $_.Id } | Out-File '%pidfile%'"

REM Allow server startup
timeout /t 1 >nul

REM Display server URL notification
powershell -Command "[void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); $balloon = New-Object System.Windows.Forms.NotifyIcon; $balloon.Icon = [System.Drawing.SystemIcons]::Information; $balloon.Visible = $true; $balloon.ShowBalloonTip(5000, 'Server Started', 'Server running at http://%ip%:8000/%folderName%/', [System.Windows.Forms.ToolTipIcon]::Info)"

REM Open in default browser
start http://%ip%:8000/

echo Server is running. Press any key to stop the server...
pause >nul

REM Clean shutdown of server
for /f "tokens=*" %%a in ('type "%pidfile%"') do (
    taskkill /F /T /PID %%a >nul 2>&1
)

REM Remove PID file
del "%pidfile%" >nul 2>&1

REM Notify server shutdown
powershell -Command "[void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); $balloon = New-Object System.Windows.Forms.NotifyIcon; $balloon.Icon = [System.Drawing.SystemIcons]::Information; $balloon.Visible = $true; $balloon.ShowBalloonTip(3000, 'Server Stopped', 'HTTP Server has been stopped', [System.Windows.Forms.ToolTipIcon]::Info)"

echo Server has been stopped.
