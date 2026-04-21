# ========================================
# Script Pós-Clonagem
# Autor: Ernesto Nurnberg
# Objetivo: Configuracão automática do sistema 
# Versão: 2.2
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
        throw
    }
}

Log "===== INICIO POST-CLONE ====="

# ========================================
# GERAR NOME DO EQUIPO
# ========================================
Run-Step "Obter identificador" {

    $serial = (Get-CimInstance Win32_BIOS).SerialNumber

    if ($serial -and 
        $serial.Trim() -ne "" -and
        $serial -notmatch "To be filled" -and 
        $serial -notmatch "System Serial Number") {

        $id = $serial.Substring([Math]::Max(0, $serial.Length - 5))
        Log "Serial detectado: $serial"
    }
    else {
        Log "Serial inválido, usando MAC como fallback"

        $mac = (Get-CimInstance Win32_NetworkAdapterConfiguration |
            Where-Object {$_.MACAddress -ne $null})[0].MACAddress

        if (-not $mac) {
            throw "No se pudo obtener MAC"
        }

        $macClean = $mac -replace ":", ""
        $id = $macClean.Substring([Math]::Max(0, $macClean.Length - 6))

        Log "MAC detectada: $mac"
    }

    if (-not $id -or $id.Trim() -eq "") {
        throw "No se pudo generar ID válido"
    }

    $script:newName = "PC-$id"

    if ($script:newName -match "-$") {
        throw "Nombre generado inválido: $script:newName"
    }

    Log "Nome gerado: $script:newName"
}

# ========================================
# RENOMEAR COMPUTADOR
# ========================================
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