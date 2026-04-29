# mi_herramienta.ps1
# ====================================================================
# SOPTEC - Interfaz de Usuario
# Guarda este archivo exactamente como: Soptec.ps1
# ====================================================================

function Show-PantallaSoptec {
    Clear-Host
    
    $bannerASCII = @'
========================================================================
  ____  ___  _     __   ______ _____ _____ __  __ ____  
 / ___|/ _ \| |    \ \ / / ___|_   _| ____|  \/  / ___| 
| |  _| | | | |     \ V /\___ \ | | |  _| | |\/| \___ \ 
| |_| | |_| | |___   | |  ___) || | | |___| |  | |___) |
 \____|\___/|_____|  |_| |____/ |_| |_____|_|  |_|____/ 

========================================================================
'@
    Write-Host $bannerASCII -ForegroundColor Cyan

    Write-Host " SOPTE TECNICO   -  GOLSYSTEMS " -BackgroundColor Cyan -ForegroundColor Black
    Write-Host ""

    Write-Host "[" -NoNewline
    Write-Host "Blanco: Seguro/Info" -ForegroundColor White -NoNewline
    Write-Host "] | [" -NoNewline
    Write-Host "Amarillo: Avanzado" -ForegroundColor Yellow -NoNewline
    Write-Host "] | [" -NoNewline
    Write-Host "Rojo: Borrado/Reset" -ForegroundColor Red -NoNewline
    Write-Host "]"
    
    Write-Host "`nMENU PRINCIPAL" -ForegroundColor White
    Write-Host "------------------------------------------------------" -ForegroundColor DarkGray

    Write-Host "  1. Diagnostico e Info de Sistema" -ForegroundColor White
    Write-Host "  2. Reparacion y Solucion de Errores" -ForegroundColor White
    Write-Host "  3. Redes y Conectividad" -ForegroundColor White
    Write-Host "  4. Limpieza y Mantenimiento" -ForegroundColor White
    Write-Host "  5. Gestor de Software y Arranque" -ForegroundColor White
    Write-Host "  6. Optimizaciones y Atajos Clasicos" -ForegroundColor White
    
    Write-Host "------------------------------------------------------" -ForegroundColor DarkGray

    Write-Host "  A. MODO AUTOMATICO " -ForegroundColor Yellow -NoNewline
    Write-Host "(limpieza + reparacion completa)" -ForegroundColor DarkGray

    Write-Host "`n  L. CAMBIAR IDIOMA ES/EN" -ForegroundColor Cyan
    Write-Host "  C. Creditos" -ForegroundColor Cyan
    Write-Host "  S. Salir del Sistema" -ForegroundColor Red
    
    Write-Host "------------------------------------------------------" -ForegroundColor DarkGray
}

# ====================================================================
# BUCLE PRINCIPAL (Game Loop)
# ====================================================================

$appCorriendo = $true
[System.Console]::CursorVisible = $false 

while ($appCorriendo) {
    Show-PantallaSoptec
    
    $teclaPulsada = [System.Console]::ReadKey($true)
    $seleccion = $teclaPulsada.KeyChar.ToString().ToUpper()

    Clear-Host
    
    switch ($seleccion) {
        '1' { Write-Host "[+] Ejecutando: Diagnóstico e Info de Sistema..." -ForegroundColor Cyan; Start-Sleep -Seconds 2 }
        '2' { Write-Host "[+] Ejecutando: Reparación y Solución de Errores..." -ForegroundColor Cyan; Start-Sleep -Seconds 2 }
        '3' { Write-Host "[+] Ejecutando: Redes y Conectividad..." -ForegroundColor Cyan; Start-Sleep -Seconds 2 }
        '4' { Write-Host "[+] Ejecutando: Limpieza y Mantenimiento..." -ForegroundColor Cyan; Start-Sleep -Seconds 2 }
        '5' { Write-Host "[+] Ejecutando: Gestor de Software y Arranque..." -ForegroundColor Cyan; Start-Sleep -Seconds 2 }
        '6' { Write-Host "[+] Ejecutando: Optimizaciones y Atajos Clásicos..." -ForegroundColor Cyan; Start-Sleep -Seconds 2 }
        
        'A' { Write-Host "[!] ADVERTENCIA: Iniciando Modo Automático..." -ForegroundColor Yellow; Start-Sleep -Seconds 2 }
        'L' { Write-Host "[i] Cambiando idioma..." -ForegroundColor Cyan; Start-Sleep -Seconds 2 }
        'C' { Write-Host "[i] Créditos: SOPTEC desarrollado por Manuel Rodriguez." -ForegroundColor Green; Start-Sleep -Seconds 2 }
        
        { $_ -in 'S', [char]27 } { 
            Write-Host "Saliendo del sistema..." -ForegroundColor Red
            $appCorriendo = $false 
        }
    }
}

[System.Console]::CursorVisible = $true