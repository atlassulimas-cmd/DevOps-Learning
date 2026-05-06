Write-Host "=== System report 1 ===" -ForegroundColor Green
# 1. Визначаємо змінні (це зручно для подальших змін)
$rgName = "Atlas-Lab-RG"
$location = "westeurope" # Західна Європа - стабільний регіон для України

try {
    Write-Host "Trying Resource Group: $rgName..." -ForegroundColor Cyan

    # 2. Перевіряємо, чи існує вже така група
    $existingRG = Get-AzResourceGroup -Name $rgName -ErrorAction SilentlyContinue

    if ($null -eq $existingRG) {
        # 3. Створюємо нову групу
        New-AzResourceGroup -Name $rgName -Location $location -Force | Out-Null
        Write-Host "Successfully created: $rgName in region $location" -ForegroundColor Green
    } else {
        Write-Host "Group $rgName already exists. Skipping create." -ForegroundColor Yellow
    }
}
catch {
    Write-Error "Error creating Resource Group: $($_.Exception.Message)"
}
