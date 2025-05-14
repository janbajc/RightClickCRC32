@echo off
setlocal

REM Get the current directory (where this script and .ps1 file are)
set "currentPath=%~dp0"
set "ps1Path=%currentPath%calcCRC32.ps1"

REM Escape backslashes for REG file
set "ps1Path=%ps1Path:\=\\%"

REM Create temporary .reg file
set "regFile=%TEMP%\crc32_context.reg"
(
echo Windows Registry Editor Version 5.00
echo.
echo [HKEY_CLASSES_ROOT\*\shell\Add CRC32 to Filename]
echo @="Add CRC32 to Filename"
echo.
echo [HKEY_CLASSES_ROOT\*\shell\Add CRC32 to Filename\command]
echo @="powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File \"%ps1Path%\" \"%%1\""
) > "%regFile%"

REM Import the generated .reg file
regedit.exe /s "%regFile%"

echo Context menu entry installed using: %ps1Path%
pause
endlocal
