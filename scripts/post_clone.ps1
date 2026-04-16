# ========================================
# Script Pós-Clonagem
# Autor: Ernesto Nurnberg
# Objetivo: Configuracão automática do sistema 
# Versão: 1
# ========================================

# Obter número de série
$serial = (Get-CimInstance Win32_BIOS).SerialNumber

if ($serial -and 
    $serial -notmatch "To be filled" -and 
    $serial -notmatch "System Serial Number") {

    $id = $serial.Substring($serial.Length - 5)
}
else {
    $mac = (Get-CimInstance Win32_NetworkAdapterConfiguration |
        Where-Object {$_.MACAddress -ne $null -and $_.IPEnabled})[0].MACAddress

    $macClean = $mac -replace ":", ""
    $id = $macClean.Substring($macClean.Length - 6)
}

$newName = "PC-$id"

Write-Host "Novo nome: $newName" -ForegroundColor Green
Pause
Rename-Computer -NewName $newName -Force -Restart