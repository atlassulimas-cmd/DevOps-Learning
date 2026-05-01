<#
.SYNOPSIS
    Скрипт для базового аудиту системи.
    Розроблено для підготовки до вакансії Atlas Technica.
#>

function Get-OSInfo {
    try {
        $os = Get-CimInstance Win32_OperatingSystem -ErrorAction Stop
        Write-Host "--- OS ---" -ForegroundColor Cyan
        Write-Host "PC: $($os.CSName)"
        Write-Host "OS version: $($os.Caption) ($($os.Version))"
    }
    catch {
        Write-Warning "No OS data: $($_.Exception.Message)"
    }
}

function Get-Uptime {
    try {
        $lastBoot = (Get-CimInstance Win32_OperatingSystem -ErrorAction Stop).LastBootUpTime
        $uptime = (Get-Date) - $lastBoot
        
        Write-Host "--- Uptime ---" -ForegroundColor Cyan
        Write-Host "System works: $($uptime.Days) days, $($uptime.Hours) hours and $($uptime.Minutes) minutes"
    }
    catch {
        Write-Warning "Can't calculate Uptime."
    }
}

# Виклик функцій
Get-OSInfo
Get-Uptime