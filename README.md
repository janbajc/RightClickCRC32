CRC32 Calculator for Windows Right-Click

This script calculates the CRC32 checksum of a file and copies the result to the clipboard, providing an easy way to check the integrity of files via the Windows right-click context menu.
Features:

    Calculate CRC32 checksum of any file.

    Automatically copy the CRC32 value to the clipboard.

    Display the checksum in a message box.

Installation:
Step 1: Download the Script

    Download calcCRC32.ps1 from this repository or copy the script provided.

    Save the file to your desired location, e.g., C:\Scripts\calcCRC32.ps1.

    [HKEY_CLASSES_ROOT\*\shell\Copy CRC32]
    @="Copy CRC32"

    [HKEY_CLASSES_ROOT\*\shell\Copy CRC32\command]
    @="powershell.exe -NoProfile -ExecutionPolicy Bypass -File \"C:\\Path\\To\\calcCRC32.ps1\" \"%1\""

    Replace C:\\Path\\To\\calcCRC32.ps1 with the actual path to the calcCRC32.ps1 script.

Step 3: Running the Script

    Right-click any file in Windows Explorer.

    Select "Copy CRC32" from the context menu.

    The CRC32 value will be calculated and copied to your clipboard.
