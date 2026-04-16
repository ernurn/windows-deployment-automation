@echo off
echo ========================================
echo PREPARACAO DE IMAGEM WINDOWS
echo ========================================

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0prep_imagem_win.ps1"

echo.
echo Processo finalizado.
pause