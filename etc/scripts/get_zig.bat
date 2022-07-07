@echo off

:: Shamelessly stolen from coilhq

for /f "tokens=2" %%a in ('curl --silent https://ziglang.org/download/index.json ^| findstr zig-windows-x86_64 ^| findstr builds' ) do (
  set URL=%%a
)

for /f %%b in ("%URL:,=%") do (
    set URL=%%~b
)

for /f %%i in ("%URL%") do (
    set DIRECTORY=%%~ni
)

echo Downloading latest’s build zip...

set TARGET=%UserProfile%\Downloads\zig.zip

if exist  %TARGET% (
  del /q %TARGET%
  if exist %TARGET% (
    echo Failed to delete %TARGET%.
    exit 1
  )
)

curl --progress-bar %URL% --output  %TARGET%
if not exist  %TARGET% (
  echo Failed to download Zig zip file.
  exit 1
)

echo Removing previous zig installation
if exist %UserProfile%\zig\ (
  rd /s /q %UserProfile%\zig\
  :: Ensure the directory has been deleted.
  if exist zig\ (
    echo The ‘zig’ directory could not be deleted.
    exit 1
  )
)

echo Extracting Zig’s zip file...
powershell -Command "Expand-Archive %UserProfile%\Downloads\zig.zip -DestinationPath %UserProfile%"
ren "%UserProfile%\%DIRECTORY%" zig
if exist %DIRECTORY% (
  echo Failed to rename %DIRECTORY% to zig.
  exit 1
)
