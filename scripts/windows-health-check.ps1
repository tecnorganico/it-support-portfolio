[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Container })]
    [string]$OutputDirectory
)

$ErrorActionPreference = "Continue"
$report = [System.Collections.Generic.List[string]]::new()

function Write-ReportLine {
    param([string]$Text = "")
    $null = $report.Add($Text)
    Write-Output $Text
}

function Write-Section {
    param([string]$Title)
    Write-ReportLine ""
    Write-ReportLine ("==== {0} ====" -f $Title)
}

function Write-Unavailable {
    param([string]$Message)
    Write-ReportLine ("Unavailable: {0}" -f $Message)
}

Write-ReportLine "Windows Health Check (read-only)"
Write-ReportLine ("Generated: {0}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"))

Write-Section "Computer and Operating System"
Write-ReportLine ("Computer Name: {0}" -f $env:COMPUTERNAME)
$os = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue
if ($os) {
    Write-ReportLine ("Edition: {0}" -f $os.Caption)
    Write-ReportLine ("Version: {0}" -f $os.Version)
    Write-ReportLine ("Build: {0}" -f $os.BuildNumber)
    $uptime = (Get-Date) - $os.LastBootUpTime
    Write-ReportLine ("Uptime: {0} days, {1} hours, {2} minutes" -f [int]$uptime.TotalDays, $uptime.Hours, $uptime.Minutes)
} else {
    Write-Unavailable "Windows operating system details could not be read."
}

Write-Section "CPU and Memory"
$cpu = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue
if ($cpu) {
    $cpu | ForEach-Object { Write-ReportLine ("CPU: {0} ({1} cores, {2} logical processors)" -f $_.Name, $_.NumberOfCores, $_.NumberOfLogicalProcessors) }
} else {
    Write-Unavailable "CPU details could not be read."
}
$computer = Get-CimInstance Win32_ComputerSystem -ErrorAction SilentlyContinue
if ($computer) {
    $totalRam = [math]::Round($computer.TotalPhysicalMemory / 1GB, 2)
    $freeRam = if ($os) { [math]::Round($os.FreePhysicalMemory * 1KB / 1GB, 2) } else { $null }
    Write-ReportLine ("Total RAM: {0} GB" -f $totalRam)
    if ($null -ne $freeRam) { Write-ReportLine ("Free RAM: {0} GB" -f $freeRam) } else { Write-Unavailable "Free RAM could not be read." }
} else {
    Write-Unavailable "Memory details could not be read."
}

Write-Section "Physical Disks"
$disks = Get-PhysicalDisk -ErrorAction SilentlyContinue
if ($disks) {
    $disks | ForEach-Object {
        Write-ReportLine ("{0} | Type: {1} | Health: {2} | Size: {3} GB" -f $_.FriendlyName, $_.MediaType, $_.HealthStatus, [math]::Round($_.Size / 1GB, 2))
    }
} else {
    Write-Unavailable "Get-PhysicalDisk is unavailable or returned no disks."
}

Write-Section "Volumes"
$volumes = Get-Volume -ErrorAction SilentlyContinue | Where-Object { $_.DriveLetter }
if ($volumes) {
    $volumes | ForEach-Object {
        Write-ReportLine ("{0}: | File system: {1} | Size: {2} GB | Free: {3} GB | Health: {4}" -f $_.DriveLetter, $_.FileSystem, [math]::Round($_.Size / 1GB, 2), [math]::Round($_.SizeRemaining / 1GB, 2), $_.HealthStatus)
    }
} else {
    Write-Unavailable "Volume details are unavailable."
}

Write-Section "Microsoft Defender"
$defender = Get-MpComputerStatus -ErrorAction SilentlyContinue
if ($defender) {
    Write-ReportLine ("Antivirus enabled: {0}" -f $defender.AntivirusEnabled)
    Write-ReportLine ("Real-time protection: {0}" -f $defender.RealTimeProtectionEnabled)
    Write-ReportLine ("Antispyware enabled: {0}" -f $defender.AntispywareEnabled)
    Write-ReportLine ("Signatures: {0}" -f $defender.AntivirusSignatureVersion)
} else {
    Write-Unavailable "Microsoft Defender status is unavailable."
}

Write-Section "Registered Antivirus Products"
$securityProducts = Get-CimInstance -Namespace "root\SecurityCenter2" -ClassName AntiVirusProduct -ErrorAction SilentlyContinue
if ($securityProducts) {
    $securityProducts | ForEach-Object { Write-ReportLine ("{0} | State: {1}" -f $_.displayName, $_.productState) }
} else {
    Write-Unavailable "Registered antivirus products are unavailable."
}

Write-Section "Top 10 Processes by Memory"
$processes = Get-Process -ErrorAction SilentlyContinue | Sort-Object WorkingSet64 -Descending | Select-Object -First 10
if ($processes) {
    $processes | ForEach-Object { Write-ReportLine ("{0} | PID: {1} | Memory: {2} MB" -f $_.ProcessName, $_.Id, [math]::Round($_.WorkingSet64 / 1MB, 1)) }
} else {
    Write-Unavailable "Process details could not be read."
}

Write-Section "Startup Applications"
$startup = Get-CimInstance Win32_StartupCommand -ErrorAction SilentlyContinue
if ($startup) {
    $startup | Sort-Object Name | ForEach-Object { Write-ReportLine ("{0} | Location: {1} | Command: {2}" -f $_.Name, $_.Location, $_.Command) }
} else {
    Write-Unavailable "Startup application details could not be read."
}

Write-Section "Installed Software Summary"
$winget = Get-Command winget -ErrorAction SilentlyContinue
if ($winget) {
    $wingetOutput = & $winget.Source list 2>&1
    if ($LASTEXITCODE -eq 0) {
        $wingetOutput | ForEach-Object { Write-ReportLine ([string]$_) }
    } else {
        Write-Unavailable "winget list did not complete successfully."
    }
} else {
    Write-Unavailable "winget is not installed or is not on PATH."
}

Write-Section "End of Report"
if ($OutputDirectory) {
    $resolvedDirectory = (Resolve-Path -LiteralPath $OutputDirectory).Path
    $resolvedPath = Join-Path $resolvedDirectory ("windows-health-check-{0}.txt" -f (Get-Date -Format "yyyyMMdd-HHmmss"))
    $report | Set-Content -Path $resolvedPath -Encoding UTF8
    Write-Output ("Report exported to: {0}" -f $resolvedPath)
}
