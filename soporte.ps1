# ====================================================================
# SOPTEC - Core Administrativo
# Arquitectura: Menús Anidados y Consultas CIM/WMI
# Autor: Manuel Rodriguez | GOLSYSTEMS
# ====================================================================

# --------------------------------------------------------------------
# CONFIGURACIÓN GLOBAL
# --------------------------------------------------------------------
$WorkDirectory = "C:\Golsystems"

# --------------------------------------------------------------------
# COMPONENTES DE SEGURIDAD Y ENTORNO
# --------------------------------------------------------------------



function Test-IsAdmin {
    $identidad = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal]::new($identidad)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Initialize-Workspace {
    if (-not (Test-Path -Path $WorkDirectory)) {
        Write-Host "[i] Inicializando entorno: Creando directorio $WorkDirectory..." -ForegroundColor DarkGray
        New-Item -ItemType Directory -Path $WorkDirectory -Force | Out-Null
    }
}

# --------------------------------------------------------------------
# COMPONENTES DE UI (DRY Principle)
# --------------------------------------------------------------------
function Show-Banner {
    Clear-Host
    # ¡ADVERTENCIA! No pongas espacios antes del @' ni del '@ final
    $bannerASCII = @'
========================================================================================================================
   █████████     ███████    ████   █████████  █████ █████  █████████  ███████████ ██████████ ██████   ██████  █████████ 
  ███░░░░░███  ███░░░░░███ ░░███  ███░░░░░███░░███ ░░███  ███░░░░░███░█░░░███░░░█░░███░░░░░█░░██████ ██████  ███░░░░░███
 ███     ░░░  ███     ░░███ ░███ ░███    ░░░  ░░███ ███  ░███    ░░░ ░   ░███  ░  ░███  █ ░  ░███░█████░███ ░███    ░░░ 
░███         ░███      ░███ ░███ ░░█████████   ░░█████   ░░█████████     ░███     ░██████    ░███░░███ ░███ ░░█████████ 
░███    █████░███      ░███ ░███  ░░░░░░░░███   ░░███     ░░░░░░░░███    ░███     ░███░░█    ░███ ░░░  ░███  ░░░░░░░░███
░░███  ░░███ ░░███     ███  ░███  ███    ░███    ░███     ███    ░███    ░███     ░███ ░   █ ░███      ░███  ███    ░███
 ░░█████████  ░░░███████░   █████░░█████████     █████   ░░█████████     █████    ██████████ █████     █████░░█████████ 
  ░░░░░░░░░     ░░░░░░░    ░░░░░  ░░░░░░░░░     ░░░░░     ░░░░░░░░░     ░░░░░    ░░░░░░░░░░ ░░░░░     ░░░░░  ░░░░░░░░░ 
========================================================================================================================
'@
    Write-Host $bannerASCII -ForegroundColor Cyan
    Write-Host " SISTEMAS   -   GOLSYSTEMS " -BackgroundColor Cyan -ForegroundColor Black
    Write-Host ""
}

function Show-MenuPrincipal {
    Show-Banner
    Write-Host "[" -NoNewline; Write-Host "Blanco: Seguro/Info" -ForegroundColor White -NoNewline
    Write-Host "] | [" -NoNewline; Write-Host "Amarillo: Avanzado" -ForegroundColor Yellow -NoNewline
    Write-Host "] | [" -NoNewline; Write-Host "Rojo: Borrado/Reset" -ForegroundColor Red -NoNewline; Write-Host "]"
    
    Write-Host "`nMENU PRINCIPAL" -ForegroundColor White
    Write-Host "------------------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "  1. Diagnostico e Info de Sistema" -ForegroundColor White
    Write-Host "  2. Reparacion y Solucion de Errores" -ForegroundColor White
    Write-Host "  3. Redes y Conectividad" -ForegroundColor White
    Write-Host "  4. Limpieza y Mantenimiento" -ForegroundColor White
    Write-Host "  5. Gestor de Software y Arranque" -ForegroundColor White
    Write-Host "  6. Optimizaciones y Atajos Clasicos" -ForegroundColor White
    Write-Host "------------------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "  A. MODO AUTOMATICO " -ForegroundColor Yellow -NoNewline
    Write-Host "(limpieza + reparacion completa)" -ForegroundColor DarkGray
    Write-Host "`n  S. Salir del Sistema" -ForegroundColor Red
    Write-Host "------------------------------------------------------------------------" -ForegroundColor DarkGray
}

function Show-SubMenuDiagnostico {
    Show-Banner
    Write-Host "MENU > 1. DIAGNOSTICO E INFO DE SISTEMA" -ForegroundColor Cyan
    Write-Host "------------------------------------------------------------------------" -ForegroundColor DarkGray
    
    Write-Host "  1. " -ForegroundColor Cyan -NoNewline; Write-Host "Resumen de Sistema " -ForegroundColor Yellow -NoNewline; Write-Host " (Hardware, Alerta Disco, Uptime)" -ForegroundColor DarkGray
    Write-Host "  2. " -ForegroundColor Cyan -NoNewline; Write-Host "Estado de Licencia Windows " -ForegroundColor Yellow -NoNewline; Write-Host " (Activacion real)" -ForegroundColor DarkGray
    Write-Host "  3. " -ForegroundColor Cyan -NoNewline; Write-Host "Ver Ultimos Pantallazos Azules " -ForegroundColor Yellow -NoNewline; Write-Host " (BSOD)" -ForegroundColor DarkGray
    Write-Host "  4. " -ForegroundColor Cyan -NoNewline; Write-Host "Ver Salud de Discos y Tipo " -ForegroundColor Yellow -NoNewline; Write-Host " (SSD/HDD)" -ForegroundColor DarkGray
    Write-Host "  5. " -ForegroundColor Cyan -NoNewline; Write-Host "Generar Reporte de Bateria " -ForegroundColor Yellow -NoNewline; Write-Host " (HTML)" -ForegroundColor DarkGray
    Write-Host "  6. " -ForegroundColor Cyan -NoNewline; Write-Host "Exportar Inventario de PC " -ForegroundColor Yellow -NoNewline; Write-Host " (TXT)" -ForegroundColor DarkGray
    Write-Host "  7. " -ForegroundColor Cyan -NoNewline; Write-Host "Ver Historial de Auditoria Local " -ForegroundColor Yellow -NoNewline; Write-Host " (Logs)" -ForegroundColor DarkGray
    
    Write-Host "------------------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "  B. Volver al Menu Principal" -ForegroundColor White
    Write-Host "------------------------------------------------------------------------" -ForegroundColor DarkGray
}

function Show-SubMenuReparacion {
    Show-Banner
    Write-Host "MENU > 2. REPARACION Y SOLUCION DE ERRORES" -ForegroundColor Cyan
    Write-Host "------------------------------------------------------------------------" -ForegroundColor DarkGray
    
    Write-Host "  1. " -ForegroundColor Cyan -NoNewline; Write-Host "Reparar archivos del sistema " -ForegroundColor White -NoNewline; Write-Host " (SFC /scannow)" -ForegroundColor DarkGray
    Write-Host "  2. " -ForegroundColor Cyan -NoNewline; Write-Host "Reparar imagen de Windows " -ForegroundColor White -NoNewline; Write-Host " (DISM /RestoreHealth)" -ForegroundColor DarkGray
    Write-Host "  3. " -ForegroundColor Cyan -NoNewline; Write-Host "Reparar Microsoft Store y apps " -ForegroundColor White
    Write-Host "  4. " -ForegroundColor Cyan -NoNewline; Write-Host "Resetear iconos del escritorio " -ForegroundColor White
    Write-Host "  5. " -ForegroundColor Cyan -NoNewline; Write-Host "Solucionar problemas de impresoras " -ForegroundColor Yellow
    
    Write-Host "------------------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "  0. Volver" -ForegroundColor Red
    Write-Host "------------------------------------------------------------------------" -ForegroundColor DarkGray
}

function Show-SubMenuImpresoras {
    Show-Banner
    Write-Host "MENU > 2. REPARACION > 5. IMPRESORAS" -ForegroundColor Cyan
    Write-Host "------------------------------------------------------------------------" -ForegroundColor DarkGray
    
    Write-Host "  1. " -ForegroundColor Cyan -NoNewline; Write-Host "Reiniciar servicio de cola de impresion " -ForegroundColor White -NoNewline; Write-Host " (Spooler)" -ForegroundColor DarkGray
    Write-Host "  2. " -ForegroundColor Cyan -NoNewline; Write-Host "Limpiar trabajos de impresion pendientes " -ForegroundColor White
    Write-Host "  3. " -ForegroundColor Cyan -NoNewline; Write-Host "Listar impresoras instaladas " -ForegroundColor White
    
    Write-Host "------------------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "  0. Volver" -ForegroundColor Red
    Write-Host "------------------------------------------------------------------------" -ForegroundColor DarkGray
}

# --------------------------------------------------------------------
# LÓGICA DE NEGOCIO Y CONTROLADORES
# --------------------------------------------------------------------
function Wait-UserKeyPress {
    Write-Host "`n[ Presiona cualquier tecla para continuar... ]" -ForegroundColor DarkGray
    $null = [System.Console]::ReadKey($true)
}

function Invoke-SubModuloDiagnostico {
    $enSubMenu = $true
    while ($enSubMenu) {
        Show-SubMenuDiagnostico
        $tecla = [System.Console]::ReadKey($true).KeyChar.ToString().ToUpper()
        
        switch ($tecla) {
            '1' { 
                Clear-Host; Show-Banner
                Write-Host "--- RESUMEN DE SISTEMA ---" -ForegroundColor Cyan
                $os = Get-CimInstance Win32_OperatingSystem
                $cpu = Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name
                $uptime = (Get-Date) - $os.LastBootUpTime
                
                Write-Host "SO: " -NoNewline; Write-Host $os.Caption -ForegroundColor White
                Write-Host "CPU: " -NoNewline; Write-Host $cpu -ForegroundColor White
                Write-Host "RAM: " -NoNewline; Write-Host "$([math]::Round($os.TotalVisibleMemorySize / 1MB, 2)) GB" -ForegroundColor White
                Write-Host "Tiempo Encendido (Uptime): " -NoNewline; Write-Host "$($uptime.Days) dias, $($uptime.Hours) horas" -ForegroundColor Yellow
                Wait-UserKeyPress
            }
            '2' {
                Clear-Host; Show-Banner
                Write-Host "--- LICENCIA DE WINDOWS ---" -ForegroundColor Cyan
                Write-Host "Consultando servidor de licencias KMS/Retail..." -ForegroundColor DarkGray
                cscript /nologo c:\windows\system32\slmgr.vbs /dli | Write-Host -ForegroundColor White
                Wait-UserKeyPress
            }
            '3' {
                Clear-Host; Show-Banner
                Write-Host "--- ÚLTIMOS PANTALLAZOS AZULES (BSOD) ---" -ForegroundColor Cyan
                $bsods = Get-EventLog -LogName System -Source "BugCheck" -Newest 5 -ErrorAction SilentlyContinue
                if ($bsods) {
                    $bsods | Format-Table TimeGenerated, Message -AutoSize | Out-String | Write-Host -ForegroundColor Red
                }
                else {
                    Write-Host "¡Excelente! No se encontraron pantallazos azules recientes en los registros." -ForegroundColor Green
                }
                Wait-UserKeyPress
            }
            '4' {
                Clear-Host; Show-Banner
                Write-Host "--- SALUD Y TIPO DE DISCOS ---" -ForegroundColor Cyan
                Get-PhysicalDisk | Select-Object DeviceId, MediaType, OperationalStatus, @{Name = "Tamaño(GB)"; Expression = { [math]::Round($_.Size / 1GB, 2) } } | Format-Table -AutoSize | Out-String | Write-Host -ForegroundColor White
                Wait-UserKeyPress
            }
            '5' {
                Clear-Host; Show-Banner
                Write-Host "--- REPORTE DE BATERÍA ---" -ForegroundColor Cyan
                $ruta = Join-Path -Path $WorkDirectory -ChildPath "BatteryReport_$(Get-Date -Format 'yyyyMMdd_HHmmss').html"
                Write-Host "Generando reporte en: $ruta" -ForegroundColor Yellow
                powercfg /batteryreport /output $ruta | Out-Null
                
                if (Test-Path -Path $ruta) {
                    Write-Host "Reporte generado. Abriendo en el navegador..." -ForegroundColor Green
                    Invoke-Item $ruta
                }
                else {
                    Write-Host "Error: No se pudo generar el reporte." -ForegroundColor Red
                }
                Wait-UserKeyPress
            }
            '6' {
                Clear-Host; Show-Banner
                Write-Host "--- INVENTARIO DE PC ---" -ForegroundColor Cyan
                $rutaTxt = Join-Path -Path $WorkDirectory -ChildPath "PCInventory_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
                Write-Host "Recopilando datos... Esto puede tardar unos segundos." -ForegroundColor Yellow
                Get-ComputerInfo | Out-File -FilePath $rutaTxt
                
                if (Test-Path -Path $rutaTxt) {
                    Write-Host "Inventario guardado en: $rutaTxt" -ForegroundColor Green
                }
                else {
                    Write-Host "Error al guardar el inventario." -ForegroundColor Red
                }
                Wait-UserKeyPress
            }
            '7' {
                Clear-Host; Show-Banner
                Write-Host "--- AUDITORÍA LOCAL (Últimos Inicios de Sesión) ---" -ForegroundColor Cyan
                Write-Host "Leyendo registros de seguridad (Requiere permisos de Administrador)..." -ForegroundColor DarkGray
                try {
                    Get-EventLog -LogName Security -InstanceId 4624 -Newest 5 -ErrorAction Stop | Select-Object TimeGenerated, Message | Format-Table -AutoSize | Out-String | Write-Host -ForegroundColor White
                }
                catch {
                    Write-Host "Acceso denegado. Necesitas ejecutar el programa como Administrador para ver auditorías." -ForegroundColor Red
                }
                Wait-UserKeyPress
            }
            'B' { 
                $enSubMenu = $false 
            }
        }
    }
}


function Invoke-SubModuloImpresoras {
    $enMenuImpresoras = $true
    while ($enMenuImpresoras) {
        Show-SubMenuImpresoras
        $tecla = [System.Console]::ReadKey($true).KeyChar.ToString().ToUpper()
        
        switch ($tecla) {
            '1' {
                Clear-Host; Show-Banner
                Write-Host "--- REINICIANDO COLA DE IMPRESION ---" -ForegroundColor Cyan
                if (-not (Test-IsAdmin)) { Write-Host "[ERROR] Se requieren privilegios de Administrador." -ForegroundColor Red; Wait-UserKeyPress; continue }
                
                Write-Host "Deteniendo servicio Spooler..." -ForegroundColor Yellow
                Stop-Service -Name Spooler -Force
                Start-Sleep -Seconds 1
                Write-Host "Iniciando servicio Spooler..." -ForegroundColor Yellow
                Start-Service -Name Spooler
                Write-Host "Servicio reiniciado con exito." -ForegroundColor Green
                Wait-UserKeyPress
            }
            '2' {
                Clear-Host; Show-Banner
                Write-Host "--- LIMPIANDO TRABAJOS ATASCADOS ---" -ForegroundColor Cyan
                if (-not (Test-IsAdmin)) { Write-Host "[ERROR] Se requieren privilegios de Administrador." -ForegroundColor Red; Wait-UserKeyPress; continue }
                
                Write-Host "Deteniendo Spooler para liberar archivos..." -ForegroundColor Yellow
                Stop-Service -Name Spooler -Force
                $rutaSpool = "$env:windir\System32\spool\PRINTERS\*.*"
                Write-Host "Borrando archivos temporales en $rutaSpool..." -ForegroundColor DarkGray
                Remove-Item -Path $rutaSpool -Force -Recurse -ErrorAction SilentlyContinue
                Write-Host "Iniciando Spooler nuevamente..." -ForegroundColor Yellow
                Start-Service -Name Spooler
                Write-Host "Cola de impresion limpia." -ForegroundColor Green
                Wait-UserKeyPress
            }
            '3' {
                Clear-Host; Show-Banner
                Write-Host "--- IMPRESORAS INSTALADAS ---" -ForegroundColor Cyan
                Get-Printer | Select-Object Name, PrinterStatus, DriverName | Format-Table -AutoSize | Out-String | Write-Host -ForegroundColor White
                Wait-UserKeyPress
            }
            '0' { $enMenuImpresoras = $false }
        }
    }
}

function Invoke-SubModuloReparacion {
    $enMenuReparacion = $true
    while ($enMenuReparacion) {
        Show-SubMenuReparacion
        $tecla = [System.Console]::ReadKey($true).KeyChar.ToString().ToUpper()
        
        switch ($tecla) {
            '1' {
                Clear-Host; Show-Banner
                Write-Host "--- REPARACION DE SISTEMA (SFC) ---" -ForegroundColor Cyan
                if (-not (Test-IsAdmin)) { Write-Host "[ERROR] Debes abrir Soptec como Administrador para esto." -ForegroundColor Red; Wait-UserKeyPress; continue }
                Write-Host "Iniciando escaneo (Esto tomara varios minutos)..." -ForegroundColor Yellow
                sfc /scannow
                Wait-UserKeyPress
            }
            '2' {
                Clear-Host; Show-Banner
                Write-Host "--- REPARACION DE IMAGEN (DISM) ---" -ForegroundColor Cyan
                if (-not (Test-IsAdmin)) { Write-Host "[ERROR] Debes abrir Soptec como Administrador para esto." -ForegroundColor Red; Wait-UserKeyPress; continue }
                Write-Host "Iniciando restauracion de imagen en linea..." -ForegroundColor Yellow
                DISM /Online /Cleanup-Image /RestoreHealth
                Wait-UserKeyPress
            }
            '3' {
                Clear-Host; Show-Banner
                Write-Host "--- REPARAR MICROSOFT STORE ---" -ForegroundColor Cyan
                Write-Host "Ejecutando WSReset. La tienda se abrira automaticamente al terminar." -ForegroundColor Yellow
                wsreset.exe
                Wait-UserKeyPress
            }
            '4' {
                Clear-Host; Show-Banner
                Write-Host "--- RESETEAR ICONOS DEL ESCRITORIO ---" -ForegroundColor Cyan
                Write-Host "El explorador de Windows se reiniciara. La pantalla puede parpadear." -ForegroundColor Yellow
                Start-Sleep -Seconds 2
                Stop-Process -Name explorer -Force
                Remove-Item "$env:localappdata\IconCache.db" -Force -ErrorAction SilentlyContinue
                Start-Process explorer
                Write-Host "Cache de iconos borrada." -ForegroundColor Green
                Wait-UserKeyPress
            }
            '5' { 
                Invoke-SubModuloImpresoras 
            }
            '0' { $enMenuReparacion = $false }
        }
    }
}



# --------------------------------------------------------------------
# CONTROLADOR PRINCIPAL Y PUNTO DE ENTRADA (Main Entry Point)
# --------------------------------------------------------------------
$appCorriendo = $true
[System.Console]::CursorVisible = $false 

Initialize-Workspace

while ($appCorriendo) {
    Show-MenuPrincipal
    $tecla = [System.Console]::ReadKey($true).KeyChar.ToString().ToUpper()

    switch ($tecla) {
        '1' { Invoke-SubModuloDiagnostico } 
        '2' { Invoke-SubModuloReparacion } 
        '3' { 
            Clear-Host; Show-Banner
            Write-Host "Funcionalidad de Redes y Conectividad en construcción..." -ForegroundColor Yellow
            Wait-UserKeyPress 
        }
        
        { $_ -in 'S', [char]27 } { 
            Clear-Host
            Write-Host "Cerrando sistema GOLSYSTEMS. Hasta pronto!" -ForegroundColor Green
            $appCorriendo = $false 
        }
    }
}

# Restaurar el entorno al usuario
[System.Console]::CursorVisible = $true