$cpn=Get-CimInstance Win32_Processor | Select-Object -ExpandProperty LoadPercentage
$os=Get-CimInstance Win32_OperatingSystem
$totalRAM=[math]::Round($os.TotalVisibleMemorySize/1MB,2)
$freeRAM=[math]::Round($os.FreePhysicalMemory / 1MB,2)
$usedRAM=$totalRAM - $freeRAM

$disk=Get-PSDrive C
$totalDisk=[math]::Round($disk.Used / 1GB +$disk.Free / 1GB,2)
$freeDisk=[math]::Round($disk.Free / 1GB, 2)
$report=[PSCustomObject]@{
    ComputerName=$env:COMPUTERNAME
    CPU_Load_Percent="$cpu %"
    RAM_Used_GB=$usedRAM
    RAM_Total_GB=$totalRAM
    Disk_Free_GB=$freeDisk
    Disk_Total_GB=$totalDisk
    Date = Get-Date -Format "yyyy-MM-dd HH:mm"
}

Write-Host "=== System report ===" -ForegroundColor Green
$report | Format-List