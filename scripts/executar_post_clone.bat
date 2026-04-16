@echo off
powershell -ExecutionPolicy Bypass -File "%~dp0post_clone.ps1"
echo.
echo Processo finalizado.
pause