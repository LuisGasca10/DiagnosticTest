# ====================================================================
# SOPTEC - Core Administrativo (Version Esterilizada ASCII)
# Arquitectura: Menus Anidados y Consultas CIM/WMI
# Autor: Manuel Rodriguez | GOLSYSTEMS
# ====================================================================

# --------------------------------------------------------------------
# CONFIGURACION GLOBAL
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
    Write-Host "  8. " -ForegroundColor Cyan -NoNewline; Write-Host "Top 5 Procesos consumiendo CPU/RAM " -ForegroundColor White -NoNewline; Write-Host " (Dinamico)" -ForegroundColor DarkGray
    Write-Host "  9. " -ForegroundColor Cyan -NoNewline; Write-Host "Detector de Reinicios Pendientes " -ForegroundColor White -NoNewline; Write-Host " (Updates)" -ForegroundColor DarkGray
    Write-Host "  C. " -ForegroundColor Cyan -NoNewline; Write-Host "Auditoria de Errores Criticos " -ForegroundColor Yellow -NoNewline; Write-Host " (Ultimas 24H)" -ForegroundColor DarkGray
    
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
    Write-Host "  6. " -ForegroundColor Cyan -NoNewline; Write-Host "Reparar Menu Inicio y Barra de Tareas " -ForegroundColor White -NoNewline; Write-Host " (UWP)" -ForegroundColor DarkGray
    Write-Host "  7. " -ForegroundColor Cyan -NoNewline; Write-Host "Reseteo Profundo de Windows Update " -ForegroundColor White -NoNewline; Write-Host " (Purga)" -ForegroundColor DarkGray
    Write-Host "  8. " -ForegroundColor Cyan -NoNewline; Write-Host "Purgado de Pila de Red " -ForegroundColor White -NoNewline; Write-Host " (Winsock/DNS)" -ForegroundColor DarkGray
    
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

function Show-SubMenuRedes {
    Show-Banner
    Write-Host "MENU > 3. REDES Y CONECTIVIDAD" -ForegroundColor Cyan
    Write-Host "------------------------------------------------------------------------" -ForegroundColor DarkGray
    
    # Opciones originales de tu diseno
    Write-Host "  1. " -ForegroundColor Cyan -NoNewline; Write-Host "Test de conectividad " -ForegroundColor White -NoNewline; Write-Host " (Ping multiple)" -ForegroundColor DarkGray
    Write-Host "  2. " -ForegroundColor Cyan -NoNewline; Write-Host "Renovar IP y limpiar DNS " -ForegroundColor White -NoNewline; Write-Host " (ipconfig /release /renew...)" -ForegroundColor DarkGray
    Write-Host "  3. " -ForegroundColor Red -NoNewline; Write-Host "Reset completo de red " -ForegroundColor Red -NoNewline; Write-Host " (Winsock + IP stack)" -ForegroundColor DarkGray
    Write-Host "  4. " -ForegroundColor Cyan -NoNewline; Write-Host "Exportar configuracion de red " -ForegroundColor White -NoNewline; Write-Host " (TXT)" -ForegroundColor DarkGray
    
    # Las opciones Senior agregadas
    Write-Host "  5. " -ForegroundColor Cyan -NoNewline; Write-Host "Ver conexiones activas y puertos " -ForegroundColor White -NoNewline; Write-Host " (TCP/UDP)" -ForegroundColor DarkGray
    Write-Host "  6. " -ForegroundColor Cyan -NoNewline; Write-Host "Diagnostico avanzado de ruta " -ForegroundColor White -NoNewline; Write-Host " (Traceroute)" -ForegroundColor DarkGray
    
    Write-Host "------------------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "  0. Volver" -ForegroundColor Red
    Write-Host "------------------------------------------------------------------------" -ForegroundColor DarkGray
}


# --------------------------------------------------------------------
# LOGICA DE NEGOCIO Y CONTROLADORES
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
                Write-Host "--- ULTIMOS PANTALLAZOS AZULES (BSOD) ---" -ForegroundColor Cyan
                $bsods = Get-EventLog -LogName System -Source "BugCheck" -Newest 5 -ErrorAction SilentlyContinue
                if ($bsods) {
                    $bsods | Format-Table TimeGenerated, Message -AutoSize | Out-String | Write-Host -ForegroundColor Red
                }
                else {
                    Write-Host "Excelente! No se encontraron pantallazos azules recientes." -ForegroundColor Green
                }
                Wait-UserKeyPress
            }
            '4' {
                Clear-Host; Show-Banner
                Write-Host "--- SALUD Y TIPO DE DISCOS ---" -ForegroundColor Cyan
                Get-PhysicalDisk | Select-Object DeviceId, MediaType, OperationalStatus, @{Name = "Tamano(GB)"; Expression = { [math]::Round($_.Size / 1GB, 2) } } | Format-Table -AutoSize | Out-String | Write-Host -ForegroundColor White
                Wait-UserKeyPress
            }
            '5' {
                Clear-Host; Show-Banner
                Write-Host "--- REPORTE DE BATERIA ---" -ForegroundColor Cyan
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
                Write-Host "--- AUDITORIA LOCAL (Ultimos Inicios de Sesion) ---" -ForegroundColor Cyan
                Write-Host "Leyendo registros de seguridad (Requiere permisos de Administrador)..." -ForegroundColor DarkGray
                try {
                    Get-EventLog -LogName Security -InstanceId 4624 -Newest 5 -ErrorAction Stop | Select-Object TimeGenerated, Message | Format-Table -AutoSize | Out-String | Write-Host -ForegroundColor White
                }
                catch {
                    Write-Host "Acceso denegado. Ejecuta como Administrador para ver auditorias." -ForegroundColor Red
                }
                Wait-UserKeyPress
            }
            '8' {
                Clear-Host; Show-Banner
                Write-Host "--- TOP 5 PROCESOS (RAM/CPU) ---" -ForegroundColor Cyan
                Write-Host "[ Memoria RAM ]" -ForegroundColor Yellow
                Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 5 Name, @{Name = "RAM(MB)"; Expression = { [math]::Round($_.WorkingSet / 1MB, 2) } } | Format-Table -AutoSize | Out-String | Write-Host -ForegroundColor White
                Write-Host "[ Procesador (CPU) ]" -ForegroundColor Yellow
                Get-Process | Where-Object { $_.Name -ne 'Idle' } | Sort-Object CPU -Descending | Select-Object -First 5 Name, @{Name = "CPU(s)"; Expression = { [math]::Round($_.CPU, 2) } } | Format-Table -AutoSize | Out-String | Write-Host -ForegroundColor White
                Wait-UserKeyPress
            }
            '9' {
                Clear-Host; Show-Banner
                Write-Host "--- DETECTOR DE REINICIOS PENDIENTES ---" -ForegroundColor Cyan
                $reboot1 = Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired"
                $reboot2 = Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending"
                if ($reboot1 -or $reboot2) {
                    Write-Host "[!] El sistema NECESITA un reinicio por actualizaciones pendientes." -ForegroundColor Red
                }
                else {
                    Write-Host "[OK] No hay reinicios pendientes detectados en el registro." -ForegroundColor Green
                }
                Wait-UserKeyPress
            }
            'C' {
                Clear-Host; Show-Banner
                Write-Host "--- ERRORES CRITICOS DE SISTEMA (Ultimas 24h) ---" -ForegroundColor Cyan
                $fecha = (Get-Date).AddDays(-1)
                Write-Host "Consultando Kernel..." -ForegroundColor DarkGray
                try {
                    $errores = Get-WinEvent -FilterHashtable @{LogName = 'System'; Level = 1, 2; StartTime = $fecha } -ErrorAction Stop
                    $errores | Select-Object -First 5 TimeCreated, Id, Message | Format-Table -AutoSize | Out-String | Write-Host -ForegroundColor Red
                    Write-Host "Se muestran los 5 mas recientes." -ForegroundColor Yellow
                }
                catch {
                    Write-Host "[OK] No se detectaron errores criticos en las ultimas 24 horas." -ForegroundColor Green
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
                Write-Host "Borrando archivos temporales..." -ForegroundColor DarkGray
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
                if (-not (Test-IsAdmin)) { Write-Host "[ERROR] Debes abrir Soptec como Administrador." -ForegroundColor Red; Wait-UserKeyPress; continue }
                Write-Host "Iniciando escaneo (Esto tomara varios minutos)..." -ForegroundColor Yellow
                sfc /scannow
                Wait-UserKeyPress
            }
            '2' {
                Clear-Host; Show-Banner
                Write-Host "--- REPARACION DE IMAGEN (DISM) ---" -ForegroundColor Cyan
                if (-not (Test-IsAdmin)) { Write-Host "[ERROR] Debes abrir Soptec como Administrador." -ForegroundColor Red; Wait-UserKeyPress; continue }
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
            '6' {
                Clear-Host; Show-Banner
                Write-Host "--- REPARAR MENU INICIO Y UWP ---" -ForegroundColor Cyan
                if (-not (Test-IsAdmin)) { Write-Host "[ERROR] Se requieren privilegios de Administrador." -ForegroundColor Red; Wait-UserKeyPress; continue }
                Write-Host "Re-registrando paquetes de la interfaz (Esto tomara un momento)..." -ForegroundColor Yellow
                Get-AppXPackage -AllUsers | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -ErrorAction SilentlyContinue }
                Write-Host "Reparacion de paquetes UWP finalizada." -ForegroundColor Green
                Wait-UserKeyPress
            }
            '7' {
                Clear-Host; Show-Banner
                Write-Host "--- RESETEO PROFUNDO DE WINDOWS UPDATE ---" -ForegroundColor Cyan
                if (-not (Test-IsAdmin)) { Write-Host "[ERROR] Se requieren privilegios de Administrador." -ForegroundColor Red; Wait-UserKeyPress; continue }
                Write-Host "1. Deteniendo servicios de actualizacion..." -ForegroundColor DarkGray
                Stop-Service -Name wuauserv, bits, cryptsvc -Force -ErrorAction SilentlyContinue
                Write-Host "2. Purgando descargas corruptas (SoftwareDistribution)..." -ForegroundColor DarkGray
                $rutaSD = "$env:windir\SoftwareDistribution\Download"
                if (Test-Path $rutaSD) { Remove-Item -Path "$rutaSD\*" -Recurse -Force -ErrorAction SilentlyContinue }
                Write-Host "3. Reiniciando servicios..." -ForegroundColor DarkGray
                Start-Service -Name wuauserv, bits, cryptsvc -ErrorAction SilentlyContinue
                Write-Host "Motor de Windows Update reseteado con exito." -ForegroundColor Green
                Wait-UserKeyPress
            }
            '8' {
                Clear-Host; Show-Banner
                Write-Host "--- PURGADO DE PILA DE RED ---" -ForegroundColor Cyan
                if (-not (Test-IsAdmin)) { Write-Host "[ERROR] Se requieren privilegios de Administrador." -ForegroundColor Red; Wait-UserKeyPress; continue }
                Write-Host "Limpiando DNS y Winsock..." -ForegroundColor Yellow
                ipconfig /flushdns | Out-Null
                netsh winsock reset | Out-Null
                netsh int ip reset | Out-Null
                Write-Host "Pila de red restaurada. Se recomienda reiniciar el equipo pronto." -ForegroundColor Green
                Wait-UserKeyPress
            }
            '0' { $enMenuReparacion = $false }
        }
    }
}

function Invoke-SubModuloRedes {
    $enMenuRedes = $true
    while ($enMenuRedes) {
        Show-SubMenuRedes
        $tecla = [System.Console]::ReadKey($true).KeyChar.ToString().ToUpper()
        
        switch ($tecla) {
            '1' {
                Clear-Host; Show-Banner
                Write-Host "--- TEST DE CONECTIVIDAD MULTIPLE ---" -ForegroundColor Cyan
                # Usamos un Array para evaluar resolución DNS y salida a internet global
                $servidores = @("google.com", "8.8.8.8", "1.1.1.1")
                
                foreach ($srv in $servidores) {
                    Write-Host "Haciendo ping a $srv ..." -ForegroundColor DarkGray
                    if (Test-Connection -ComputerName $srv -Count 2 -Quiet -ErrorAction SilentlyContinue) {
                        Write-Host "[OK] Conexion exitosa con $srv" -ForegroundColor Green
                    }
                    else {
                        Write-Host "[FALLO] No se pudo conectar con $srv" -ForegroundColor Red
                    }
                }
                Wait-UserKeyPress
            }
            '2' {
                Clear-Host; Show-Banner
                Write-Host "--- RENOVACION DE IP Y DNS ---" -ForegroundColor Cyan
                Write-Host "Liberando IP actual (ipconfig /release)..." -ForegroundColor Yellow
                ipconfig /release | Out-Null
                Write-Host "Renovando IP desde el servidor DHCP (ipconfig /renew)..." -ForegroundColor Yellow
                ipconfig /renew | Out-Null
                Write-Host "Limpiando cache de resolucion (ipconfig /flushdns)..." -ForegroundColor Yellow
                ipconfig /flushdns | Out-Null
                Write-Host "Proceso completado. La red ha sido refrescada." -ForegroundColor Green
                Wait-UserKeyPress
            }
            '3' {
                Clear-Host; Show-Banner
                Write-Host "--- RESET COMPLETO DE RED (NIVEL KERNEL) ---" -ForegroundColor Red
                
                # Barrera de seguridad (Design Pattern: Fail-Fast)
                if (-not (Test-IsAdmin)) { 
                    Write-Host "[ERROR] Se requieren privilegios de Administrador para esta operacion destructiva." -ForegroundColor Red
                    Wait-UserKeyPress; continue 
                }
                
                Write-Host "Reseteando catalogo Winsock..." -ForegroundColor Yellow
                netsh winsock reset | Out-Null
                Write-Host "Reseteando pila TCP/IP..." -ForegroundColor Yellow
                netsh int ip reset | Out-Null
                Write-Host "Operacion exitosa. DEBES REINICIAR LA COMPUTADORA para aplicar los cambios." -ForegroundColor Green
                Wait-UserKeyPress
            }
            '4' {
                Clear-Host; Show-Banner
                Write-Host "--- EXPORTANDO CONFIGURACION DE RED ---" -ForegroundColor Cyan
                $rutaTxt = Join-Path -Path $WorkDirectory -ChildPath "NetworkConfig_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
                
                Write-Host "Guardando ipconfig /all en $rutaTxt ..." -ForegroundColor Yellow
                ipconfig /all | Out-File -FilePath $rutaTxt
                
                if (Test-Path $rutaTxt) {
                    Write-Host "Archivo generado con exito." -ForegroundColor Green
                }
                else {
                    Write-Host "Fallo al crear el archivo." -ForegroundColor Red
                }
                Wait-UserKeyPress
            }
            '5' {
                Clear-Host; Show-Banner
                Write-Host "--- CONEXIONES TCP ESTABLECIDAS ---" -ForegroundColor Cyan
                Write-Host "Obteniendo puertos (Esto puede demorar unos segundos)..." -ForegroundColor DarkGray
                
                # Big O: O(N) filtrando conexiones activas
                Get-NetTCPConnection | Where-Object { $_.State -eq 'Established' } | 
                Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, @{Name = "PID"; Expression = { $_.OwningProcess } } | 
                Format-Table -AutoSize | Out-String | Write-Host -ForegroundColor White
                    
                Wait-UserKeyPress
            }
            '6' {
                Clear-Host; Show-Banner
                Write-Host "--- DIAGNOSTICO DE RUTA (TRACEROUTE) ---" -ForegroundColor Cyan
                Write-Host "Trazando ruta hacia 8.8.8.8 (Google DNS)..." -ForegroundColor Yellow
                Write-Host "[!] Nota: Este proceso puede tardar un minuto en finalizar." -ForegroundColor DarkGray
                
                tracert -d -h 15 8.8.8.8 | Out-String | Write-Host -ForegroundColor White
                Wait-UserKeyPress
            }
            '0' { $enMenuRedes = $false }
        }
    }
}

# --------------------------------------------------------------------
# CONTROLADOR PRINCIPAL Y PUNTO DE ENTRADA
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
            Invoke-SubModuloRedes
        }
        
        { $_ -in 'S', [char]27 } { 
            Clear-Host
            Write-Host "Cerrando sistema GOLSYSTEMS. Hasta pronto!" -ForegroundColor Green
            $appCorriendo = $false 
        }
    }
}

[System.Console]::CursorVisible = $true