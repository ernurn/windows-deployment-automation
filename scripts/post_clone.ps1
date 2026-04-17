# ========================================
# Script Pós-Clonagem
# Autor: Ernesto Nurnberg
# Objetivo: Configuracão automática do sistema 
# Versão: 2
# ========================================

# ========================================
# CONFIGURAÇÃO DE LOGS
# ========================================
$logDir = "C:\Logs"
if (-not (Test-Path $logDir)) {
    New-Item -Path $logDir -ItemType Directory | Out-Null
}

$logPath = "$logDir\$(Get-Date -Format 'yyyyMMdd_HHmmss')_post.log"

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

Log "===== INICIO POST-CLONE ====="

Run-Step "Obter identificador" {

    $serial = (Get-CimInstance Win32_BIOS).SerialNumber

    if ($serial -and 
        $serial -notmatch "To be filled" -and 
        $serial -notmatch "System Serial Number") {

        $id = $serial.Substring($serial.Length - 5)
        Log "Serial detectado: $serial"
    }
    else {
        $mac = (Get-CimInstance Win32_NetworkAdapterConfiguration |
            Where-Object {$_.MACAddress -ne $null -and $_.IPEnabled})[0].MACAddress

        $macClean = $mac -replace ":", ""
        $id = $macClean.Substring($macClean.Length - 6)

        Log "Fallback MAC: $mac"
    }

    $script:newName = "PC-$id"
    Log "Nome gerado: $script:newName"
}

Run-Step "Renomear computador" {

    $currentName = $env:COMPUTERNAME

    if ($currentName -ne $script:newName) {
        Rename-Computer -NewName $script:newName -Force
        Log "Alterado de $currentName para $script:newName"
    } else {
        Log "Nome ja correto: $currentName"
    }
}

Log "===== FINALIZADO ====="

Write-Host "Pos-clonagem concluida! Log em: $logPath" -ForegroundColor Green

Start-Sleep -Seconds 5
Restart-Computer -Force