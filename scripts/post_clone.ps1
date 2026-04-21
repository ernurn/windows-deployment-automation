# ========================================
# Script Pós-Clonagem
# Autor: Ernesto Nurnberg
# Objetivo: Configuracão automática do sistema 
# Versão: 2.3
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
Run-Step "Gerar nome aleatorio" {

    # Genera ID único tipo GUID corto (8 caracteres)
    $id = ([guid]::NewGuid().ToString().Substring(0,8)).ToUpper()

    if (-not $id -or $id.Trim() -eq "") {
        throw "No se pudo generar ID valido"
    }

    $script:newName = "PC-$id"

    if ($script:newName -match "-$") {
        throw "Nombre generado invalido: $script:newName"
    }

    Log "Nome gerado (aleatorio): $script:newName"
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