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
        # Отримуємо дані про систему
        $os = Get-CimInstance Win32_OperatingSystem -ErrorAction Stop
        
        # Переконуємось, що ми працюємо з датою
        $lastBoot = $os.LastBootUpTime
        $now = Get-Date
        
        # Розраховуємо різницю
        $uptime = $now - $lastBoot
        
        Write-Host "--- (Uptime) ---" -ForegroundColor Cyan
        
        # Перевірка: чи не порожній результат
        if ($null -ne $uptime) {
             Write-Host "Last boot: $lastBoot" -ForegroundColor Gray
             Write-Host "System works: $($uptime.Days) days, $($uptime.Hours) hours, $($uptime.Minutes) min"
        }
    }
    catch {
        Write-Warning "Error: $($_.Exception.Message)"
    }
}

# Виклик функцій
Get-OSInfo
Get-Uptime