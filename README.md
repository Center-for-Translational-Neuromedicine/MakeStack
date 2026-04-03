# MakeStack
Converting mp4 videos to tiff files


Video to TIFF Stack Conversion
Protocol & Setup Guide — MakeStack.bat
Using FFmpeg on Windows
1. Overview
This protocol describes how to convert video files (e.g. .avi, .mp4, .tif video) into a stack of individual grayscale TIFF frames using the MakeStack.bat drag-and-drop tool and FFmpeg. This workflow is designed for microscopy and image analysis applications.

2. Required Folder & File Setup
All components must be arranged as described below before use.

2.1  FFmpeg Folder Structure
Your FFmpeg installation should look exactly like this:

ffmpeg-8.0.1-full_build\
  bin\
    ffmpeg.exe         <-- FFmpeg converter
    ffplay.exe         <-- (included, not required)
    ffprobe.exe        <-- (included, not required)
    MakeStack.bat      <-- Place your batch script HERE

IMPORTANT:  MakeStack.bat must be placed inside the bin\ folder — the same folder as ffmpeg.exe.
The script calls .\ffmpeg.exe using a relative path, so both files must be co-located.

2.2  Example Full Path
A typical installation path might be:

C:\Tools\ffmpeg-8.0.1-full_build\bin\MakeStack.bat

You can place the ffmpeg-8.0.1-full_build folder anywhere on your computer (Desktop, C:\Tools, etc.). What matters is that the internal structure is preserved.

3. The MakeStack.bat Script
Below is the complete, corrected content of the MakeStack.bat file. Copy this exactly:

@echo off
setlocal
:: Move the working directory to where this script is located
cd /d "%~dp0"
echo Dragged file: "%~1"
:: Create output folder next to the original video
mkdir "%~dp1%~n1_stack" 2>nul
:: Run ffmpeg using local path
".\ ffmpeg.exe" -i "%~1" -pix_fmt gray8 "%~dp1%~n1_stack\frame_%%04d.tif"
if %errorlevel% neq 0 (
    echo.
    echo ERROR DETECTED! Ensure ffmpeg.exe is in: %~dp0
    pause
) else (
    echo SUCCESS! Stack created in: %~dp1%~n1_stack
    pause
)

3.1  What the Script Does — Line by Line

Command	Purpose
cd /d "%~dp0"	Sets the working directory to the bin\ folder, so ffmpeg.exe can be found via relative path
mkdir "%~dp1%~n1_stack"	Creates an output folder next to the input video, named videoname_stack
-pix_fmt gray8	Converts frames to 8-bit grayscale TIFF
frame_%%04d.tif	Names output files frame_0001.tif, frame_0002.tif, etc.
if %errorlevel% neq 0	Detects failure and shows a helpful error message with pause

4. How to Use — Step by Step

1.	Confirm that MakeStack.bat is inside the bin\ folder alongside ffmpeg.exe (see Section 2).
2.	Open File Explorer and navigate to the location of your video file.
3.	Open a second File Explorer window and navigate to the bin\ folder.
4.	Click on your video file and drag it onto MakeStack.bat.
5.	A black Command Prompt window will appear and FFmpeg will begin processing.
6.	When finished, you will see SUCCESS! or an error message. Press any key to close the window.
7.	Find your TIFF stack in a new folder created next to the original video file, named:

<videoname>_stack\    (e.g. experiment01_stack\

TIP:  You can also create a shortcut to MakeStack.bat on your Desktop.
Drag video files onto the shortcut for quick access without navigating to the bin\ folder.

5. Output Files
For each video frame, one TIFF file is created in the output folder:

<original_video_location>\
  myvideo.avi             <-- Original video (untouched)
  myvideo_stack\
    frame_0001.tif
    frame_0002.tif
    frame_0003.tif
    ...                   <-- One file per frame

Property	Value
Format	TIFF (.tif)
Bit depth	8-bit grayscale
Naming	frame_0001.tif, frame_0002.tif, ...
Location	Folder next to the source video file
Folder name	<videoname>_stack

6. Troubleshooting

Problem	Solution
"ffmpeg.exe is not recognized"	MakeStack.bat is not in the bin\ folder. Move it there.
Window flashes and closes	The drag-and-drop did not pass the file path. Try dragging again, directly onto the .bat file.
Output folder is empty	FFmpeg ran but produced no frames — check the input file format is supported.
Frames are white/black/wrong	Input video may be 16-bit or already grayscale — remove -pix_fmt gray8 to preserve original depth.
Long file paths fail	Windows has a 260-character path limit. Move the video to a shorter path (e.g., C:\Data\).
ERROR DETECTED shown	Read the text above it in the command window. It usually names the specific FFmpeg error.

7. Supported Input Formats
FFmpeg supports a wide range of video formats. Common formats that work with this script include:

•	.avi  — Audio Video Interleave (common in microscopy systems)
•	.mp4  — MPEG-4 (widely used general video)
•	.mov  — Apple QuickTime
•	.mkv  — Matroska Video
•	.tif / .tiff  — Multi-page TIFF video stacks
•	.czi, .nd2  — Note: these require Bio-Formats, not FFmpeg

8. Quick-Reference Checklist
Use this checklist each time before running a conversion:

•	MakeStack.bat is in the bin\ folder alongside ffmpeg.exe
•	The video file exists and is accessible (not on a locked/network drive)
•	There is sufficient disk space (TIFF stacks can be large: ~1 MB per frame)
•	The output location path is not too long (keep under 200 characters)
•	Drag the video file directly onto MakeStack.bat (or a shortcut to it)

— End of Protocol —
