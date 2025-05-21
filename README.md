# Local Hoster

A simple Windows batch script that creates a quick HTTP server from any folder with system tray notifications.

## Features

- One-click HTTP server setup
- System tray notifications for server status
- Automatic local IP detection
- Browser auto-launch
- Easy server shutdown with a keypress
- Clean process management
- Optional context menu integration

## Requirements

- Windows 10 or later
- Python 3.x installed and in PATH
- PowerShell 5.0 or later (comes with Windows 10)

## Installation

1. Clone this repository or download the files
2. Make sure Python is installed and added to your PATH
3. No additional installation needed!

### Optional: Add to Windows Context Menu

1. Open `add_context_menu.reg` in a text editor
2. Replace `[PATH_TO_BAT_FILE]` with the full path to where you saved the batch file
   - Example: `C:\\Users\\YourUser\\Scripts\\LocalHoster`
   - Make sure to use double backslashes!
3. Save and double-click the registry file to add it to your context menu
4. You'll now have a "Host with Python Server" option when right-clicking folders

## Usage

### Method 1: Drag and Drop
1. Simply drag and drop any folder onto `host_with_notification.bat`
2. The server will start and open in your browser
3. Press any key in the console window to stop the server

### Method 2: Context Menu
1. Right-click on any folder
2. Select "Host with Python Server"
3. Press any key in the console window to stop the server

### Method 3: Command Line
```batch
host_with_notification.bat "path/to/your/folder"
```

## How it Works

1. The script starts a Python HTTP server in the specified folder
2. Automatically detects your local IP address
3. Opens your default browser with the server URL
4. Shows system tray notifications for server status
5. Manages server process for clean shutdown

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Acknowledgments

- Python's `http.server` module
- Windows PowerShell notification system 