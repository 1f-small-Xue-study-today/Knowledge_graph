@echo off
setlocal

set "PROJECT_ROOT=%~dp0"
set "PDFLATEX=%LOCALAPPDATA%\Programs\MiKTeX\miktex\bin\x64\pdflatex.exe"
set "XELATEX=%LOCALAPPDATA%\Programs\MiKTeX\miktex\bin\x64\xelatex.exe"

if "%~1"=="" (
  call :build_resume All_in_one || exit /b 1
  call :build_resume apple || exit /b 1
  echo.
  echo Default build finished: All_in_one and apple.
  exit /b 0
)

call :build_resume "%~1"
exit /b %ERRORLEVEL%

:build_resume
set "RESUME_NAME=%~1"
set "RESUME_DIR=%PROJECT_ROOT%resume\%RESUME_NAME%"

if /I "%RESUME_NAME%"=="apple" (
  call :build_tex "%RESUME_NAME%" main.tex "%PDFLATEX%" || exit /b 1
  call :build_tex "%RESUME_NAME%" main_CN.tex "%XELATEX%" || exit /b 1
  exit /b 0
)

call :build_tex "%RESUME_NAME%" main.tex "%PDFLATEX%"
exit /b %ERRORLEVEL%

:build_tex
set "RESUME_NAME=%~1"
set "TEX_FILE=%~2"
set "TEX_ENGINE=%~3"
set "RESUME_DIR=%PROJECT_ROOT%resume\%RESUME_NAME%"

if not exist "%RESUME_DIR%\%TEX_FILE%" (
  echo Resume source not found:
  echo %RESUME_DIR%\%TEX_FILE%
  echo.
  echo Usage:
  echo   build_resume_pdf.bat
  echo   build_resume_pdf.bat All_in_one
  echo   build_resume_pdf.bat apple
  echo   build_resume_pdf.bat academic
  exit /b 1
)

if not exist "%TEX_ENGINE%" (
  echo LaTeX engine not found:
  echo %TEX_ENGINE%
  echo.
  echo Check your MiKTeX installation or update this script.
  exit /b 1
)

echo.
echo Building %RESUME_NAME%\%TEX_FILE% with %TEX_ENGINE%
pushd "%RESUME_DIR%" || exit /b 1
"%TEX_ENGINE%" -interaction=nonstopmode -halt-on-error "%TEX_FILE%"
set "EXIT_CODE=%ERRORLEVEL%"
popd

if not "%EXIT_CODE%"=="0" (
  echo.
  echo Resume PDF build failed: %RESUME_NAME%\%TEX_FILE%
  exit /b %EXIT_CODE%
)

echo.
echo Resume PDF generated:
echo %RESUME_DIR%\%TEX_FILE:.tex=.pdf%
exit /b 0
