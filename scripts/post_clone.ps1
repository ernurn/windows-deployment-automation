# ========================================
# Script Pós-Clonagem
# Autor: Ernesto Nurnberg
# Objetivo: Configuracão automática do sistema 
# Versão: 2.1
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

# ========================================
# GERAR NOME DO EQUIPO
# ========================================
Run-Step "Obter identificador" {

    $id = $null

    # -------- SERIAL --------
    $serial = (Get-CimInstance Win32_BIOS -ErrorAction SilentlyContinue).SerialNumber

    if ($serial -and 
        $serial -notmatch "To be filled" -and 
        $serial -notmatch "System Serial Number") {

        Log "Serial detectado: $serial"

        if ($serial.Length -ge 5) {
            $id = $serial.Substring($serial.Length - 5)
        } else {
            $id = $serial
        }
    }

    # -------- MAC FALLBACK --------
    if (-not $id) {

        $adapter = Get-CimInstance Win32_NetworkAdapterConfiguration -ErrorAction SilentlyContinue |
            Where-Object { $_.MACAddress } |
            Select-Object -First 1

        if ($adapter -and $adapter.MACAddress) {

            $macClean = $adapter.MACAddress -replace ":", ""

            if ($macClean.Length -ge 6) {
                $id = $macClean.Substring($macClean.Length - 6)
                Log "Fallback MAC: $($adapter.MACAddress)"
            }
            else {
                $id = Get-Random -Minimum 10000 -Maximum 99999
                Log "MAC inválida, usando ID aleatório"
            }
        }
        else {
            $id = Get-Random -Minimum 10000 -Maximum 99999
            Log "Sem MAC disponível, usando ID aleatório"
        }
    }

    $script:newName = "PC-$id"
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