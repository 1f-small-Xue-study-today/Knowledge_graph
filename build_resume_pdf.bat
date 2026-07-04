@echo off
setlocal

set "PROJECT_ROOT=%~dp0"
set "RESUME_NAME=%~1"
if "%RESUME_NAME%"=="" set "RESUME_NAME=All_in_one"
set "RESUME_DIR=%PROJECT_ROOT%resume\%RESUME_NAME%"
set "PDFLATEX=%LOCALAPPDATA%\Programs\MiKTeX\miktex\bin\x64\pdflatex.exe"

if not exist "%RESUME_DIR%\main.tex" (
  echo Resume source not found:
  echo %RESUME_DIR%\main.tex
  echo.
  echo Usage:
  echo   build_resume_pdf.bat All_in_one
  echo   build_resume_pdf.bat apple
  echo   build_resume_pdf.bat academic
  exit /b 1
)

if not exist "%PDFLATEX%" (
  echo MiKTeX pdflatex.exe not found at:
  echo %PDFLATEX%
  echo.
  echo Add MiKTeX to PATH or update PDFLATEX in this script.
  exit /b 1
)

pushd "%RESUME_DIR%" || exit /b 1
"%PDFLATEX%" -interaction=nonstopmode -halt-on-error main.tex
set "EXIT_CODE=%ERRORLEVEL%"
popd

if not "%EXIT_CODE%"=="0" (
  echo.
  echo Resume PDF build failed.
  exit /b %EXIT_CODE%
)

echo.
echo Resume PDF generated:
echo %RESUME_DIR%\main.pdf
exit /b 0
