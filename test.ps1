# ====================================================================
# SOPTEC - Core Administrativo
# Arquitectura: Menús Anidados y Consultas CIM/WMI
# ====================================================================

# --------------------------------------------------------------------
# COMPONENTES DE UI (DRY Principle)
# --------------------------------------------------------------------

$WorkDirectory = "C:\Golsystems"

function Initialize-Workspace {
    # Test-Path verifica si la carpeta existe. Si no (-not), la crea.
    if (-not (Test-Path -Path $WorkDirectory)) {
        Write-Host "[i] Inicializando entorno: Creando directorio $WorkDirectory..." -ForegroundColor DarkGray
        New-Item -ItemType Directory -Path $WorkDirectory -Force | Out-Null
    }
}
function Show-Banner {
    Clear-Host
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
=========================================================================================================================
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
    
    # Recreando los colores de tu imagen
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

# --------------------------------------------------------------------
# LÓGICA DE NEGOCIO (Las Funcionalidades Reales)
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
                # Usamos slmgr por debajo para el estatus real
                cscript /nologo c:\windows\system32\slmgr.vbs /dli | Write-Host -ForegroundColor White
                Wait-UserKeyPress
            }
            '3' {
                Clear-Host; Show-Banner
                Write-Host "--- ÚLTIMOS PANTALLAZOS AZULES (BSOD) ---" -ForegroundColor Cyan
                # Event ID 1001 suele ser BugCheck (BSOD)
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
                # Requiere permisos de Admin para mostrar algunos datos, pero funciona a nivel básico sin ellos
                Get-PhysicalDisk | Select-Object DeviceId, MediaType, OperationalStatus, @{Name = "Tamaño(GB)"; Expression = { [math]::Round($_.Size / 1GB, 2) } } | Format-Table -AutoSize | Out-String | Write-Host -ForegroundColor White
                Wait-UserKeyPress
            }
            '5' {
                Clear-Host; Show-Banner
                Write-Host "--- REPORTE DE BATERÍA ---" -ForegroundColor Cyan
                $ruta = "$WorkDirectory\BatteryReport_$(Get-Date -Format 'yyyyMMdd_HHmmss').html"
                Write-Host "Generando reporte en: $ruta" -ForegroundColor Yellow
                powercfg /batteryreport /output $ruta | Out-Null
                Write-Host "Reporte generado. Abriendo en el navegador..." -ForegroundColor Green
                Invoke-Item $ruta
                Wait-UserKeyPress
            }
            '6' {
                Clear-Host; Show-Banner
                Write-Host "--- INVENTARIO DE PC ---" -ForegroundColor Cyan
                $rutaTxt = "$WorkDirectory\PCInventory_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
                Write-Host "Recopilando datos... Esto puede tardar unos segundos." -ForegroundColor Yellow
                Get-ComputerInfo | Out-File -FilePath $rutaTxt
                Write-Host "Inventario guardado en: $rutaTxt" -ForegroundColor Green
                Wait-UserKeyPress
            }
            '7' {
                Clear-Host; Show-Banner
                Write-Host "--- AUDITORÍA LOCAL (Últimos Inicios de Sesión) ---" -ForegroundColor Cyan
                # Evento 4624 es inicio de sesión exitoso
                Write-Host "Leyendo registros de seguridad (Requiere permisos de Administrador)..." -ForegroundColor DarkGray
                try {
                    Get-EventLog -LogName Security -InstanceId 4624 -Newest 5 -ErrorAction Stop | Select-Object TimeGenerated, Message | Format-Table -AutoSize | Out-String | Write-Host -ForegroundColor White
                }
                catch {
                    Write-Host "Acceso denegado. Necesitas ejecutar Soptec como Administrador para ver auditorías." -ForegroundColor Red
                }
                Wait-UserKeyPress
            }
            'B' { 
                $enSubMenu = $false # Rompe el bucle interno y regresa al principal
            }
        }
    }
}

# --------------------------------------------------------------------
# CONTROLADOR PRINCIPAL
# --------------------------------------------------------------------
$appCorriendo = $true
[System.Console]::CursorVisible = $false 

Initialize-Workspace

while ($appCorriendo) {
    Show-MenuPrincipal
    $tecla = [System.Console]::ReadKey($true).KeyChar.ToString().ToUpper()

    switch ($tecla) {
        '1' { Invoke-SubModuloDiagnostico } # Llama al submenú
        '2' { Clear-Host; Write-Host "En construccion..." -ForegroundColor Yellow; Start-Sleep -Seconds 1 }
        
        { $_ -in 'S', [char]27 } { 
            Clear-Host
            Write-Host "Cerrando SOPTEC. ¡Buen trabajo!" -ForegroundColor Green
            $appCorriendo = $false 
        }
    }
}

[System.Console]::CursorVisible = $true