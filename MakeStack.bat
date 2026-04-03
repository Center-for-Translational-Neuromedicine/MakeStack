@echo off
setlocal
:: Move the "working directory" to where this script is located
cd /d "%~dp0"

echo Dragged file: "%~1"

:: Create the folder in the same place as the original video
mkdir "%~dp1%~n1_stack" 2>nul

:: Run ffmpeg using the local path
".\ffmpeg.exe" -i "%~1" -pix_fmt gray8 "%~dp1%~n1_stack\frame_%%04d.tif"

if %errorlevel% neq 0 (
    echo.
    echo ERROR DETECTED! Ensure ffmpeg.exe is in: %~dp0
    pause
) else (
    echo SUCCESS! Stack created in: %~dp1%~n1_stack
    pause
)