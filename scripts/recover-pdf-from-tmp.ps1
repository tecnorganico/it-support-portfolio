[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Container })]
    [string]$Folder,

    [Parameter(Mandatory = $false)]
    [string]$LogPath
)

$ErrorActionPreference = "Stop"
$resolvedFolder = (Resolve-Path -LiteralPath $Folder).Path
if (-not $LogPath) {
    $LogPath = Join-Path $resolvedFolder ("pdf-tmp-recovery-{0}.log" -f (Get-Date -Format "yyyyMMdd-HHmmss"))
}

function Write-RecoveryLog {
    param([string]$Message)
    $line = "{0} {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $Message
    Add-Content -LiteralPath $LogPath -Value $line -Encoding UTF8
    Write-Output $line
}

Write-RecoveryLog ("Scanning folder: {0}" -f $resolvedFolder)

Get-ChildItem -LiteralPath $resolvedFolder -Filter "*.tmp" -File -ErrorAction Stop | ForEach-Object {
    $file = $_
    $isPdf = $false
    try {
        $stream = [System.IO.File]::OpenRead($file.FullName)
        try {
            $header = New-Object byte[] 5
            $read = $stream.Read($header, 0, 5)
            $isPdf = $read -eq 5 -and [System.Text.Encoding]::ASCII.GetString($header) -eq "%PDF-"
        } finally {
            $stream.Dispose()
        }
    } catch {
        Write-RecoveryLog ("Ignored unreadable file: {0}" -f $file.Name)
        return
    }

    if (-not $isPdf) {
        Write-RecoveryLog ("Ignored non-PDF temporary file: {0}" -f $file.Name)
        return
    }

    $destination = Join-Path $file.DirectoryName ($file.BaseName + ".pdf")
    if (Test-Path -LiteralPath $destination) {
        Write-RecoveryLog ("Skipped because destination exists: {0}" -f $destination)
        return
    }

    if ($PSCmdlet.ShouldProcess($file.FullName, "Rename to $destination")) {
        Rename-Item -LiteralPath $file.FullName -NewName ([System.IO.Path]::GetFileName($destination))
        Write-RecoveryLog ("Renamed verified PDF: {0} -> {1}" -f $file.Name, [System.IO.Path]::GetFileName($destination))
    } else {
        Write-RecoveryLog ("WhatIf/dry-run: would rename verified PDF: {0} -> {1}" -f $file.Name, [System.IO.Path]::GetFileName($destination))
    }
}

Write-RecoveryLog "Scan complete."
