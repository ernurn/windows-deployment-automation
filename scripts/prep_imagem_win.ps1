# ========================================
# Preparação de Imagem Windows
# Autor: Ernesto Nurnberg
# Objetivo: Limpeza completa e otimização para clonagem
# Versão: 4.0
# ========================================

$logPath = "C:\prep_imagem_log.txt"

function Log {
    param($msg)
    $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$time - $msg" | Tee-Object -FilePath $logPath -Append
}

function Run-Step {
    param($name, $scriptBlock)

    Log "INICIO: $name"
    try {
        & $scriptBlock
        Log "OK: $name"
    } catch {
        Log "ERRO: $name -> $_"
    }
}

Log "===== INICIO DO PROCESSO ====="

# ========================================
# LIMPEZA INICIAL
# ========================================
Run-Step "Limpeza de temporarios" {
    Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue
}

# ========================================
# LIMPEZA WINDOWS UPDATE CACHE
# ========================================
Run-Step "Limpeza Windows Update cache" {
    Stop-Service wuauserv -Force -ErrorAction SilentlyContinue
    Remove-Item "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
    Start-Service wuauserv -ErrorAction SilentlyContinue
}

# ========================================
# REMOÇÃO DE APPS PROBLEMÁTICOS
# ========================================
Run-Step "Remocao de Apps" {
    $apps = @("*OneDrive*", "*Xbox*", "*Zune*", "*Bing*","*Cortana*","*Copilot*")

    foreach ($app in $apps) {

        Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue

        Get-AppxProvisionedPackage -Online | Where-Object {
            ($_.DisplayName -like $app) -and
            ($_.DisplayName -notlike "*WindowsNotepad*")
        } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
    }
}

# ========================================
# DISM
# ========================================
Run-Step "DISM Cleanup" {
    Start-Process dism.exe -ArgumentList "/online /cleanup-image /startcomponentcleanup" -Wait
}

# ========================================
# CONFIGURAR CLEANMGR AUTOMÁTICO
# ========================================
Run-Step "Configuracao CleanMgr automático" {
    $base = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches"

    Get-ChildItem $base | ForEach-Object {
        try {
            Set-ItemProperty -Path $_.PSPath -Name StateFlags0001 -Value 2 -ErrorAction SilentlyContinue
        } catch {}
    }
}

# ========================================
# EXECUTAR CLEANMGR
# ========================================
Run-Step "Execucao CleanMgr" {
    Start-Process cleanmgr.exe -ArgumentList "/sagerun:1" -Wait
}

# ========================================
# DESABILITAR FAST STARTUP
# ========================================
Run-Step "Desabilitar Inicializacao Rapida" {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" `
        -Name HiberbootEnabled -Value 0 -Force
}

# ========================================
# DESABILITAR HIBERNAÇÃO
# ========================================
Run-Step "Desabilitar Hibernacao" {
    powercfg -h off
}

# ========================================
# COMPACTAÇÃO
# ========================================
Run-Step "CompactOS" {
    Start-Process compact.exe -ArgumentList "/CompactOS:always" -Wait
}

# ========================================
# LIMPEZA DE LOGS
# ========================================
Run-Step "Limpeza de logs do sistema" {
    wevtutil el | ForEach-Object { wevtutil cl "$_" }
}

Log "===== FINALIZADO ====="
Write-Host "`nProcesso concluido com sucesso!" -ForegroundColor Green
Write-Host "Log disponivel em: $logPath"