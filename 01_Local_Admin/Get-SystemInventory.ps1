#This script is used to gather system inventory information for the local machine. It collects various details about the operating system, hardware, and other relevant information that can be useful for troubleshooting, documentation, or inventory management purposes.

#Variables
$ComputerName = $env:COMPUTERNAME
$Date = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$OutputFilePath = ".\SystemInventory_$ComputerName_$Date.txt"
#$SystemInfo = Get-ComputerInfo | Select-Object -Property OSName, OSVersion, CSName, CsUserName, OsUptime, CSNumberOfLogicalProcessors, CsTotalPhysicalMemory
$SystemInfo = Get-ComputerInfo | Select-Object -Property OSName, OSVersion, CSName, CsUserName, OsUptime, CSNumberOfLogicalProcessors, @{Name = "MemoryGB"; Expression = { [Math]::Round($_.CsTotalPhysicalMemory / 1073741824, 2) } }
#$MemoryGB = [Math]::Round((Get-ComputerInfo).CsTotalPhysicalMemory / 1073741824, 2)

#Header

#Write-Host "=== Contoso Federal Solutions | System Inventory | $Date ==="
 "=== Contoso Federal Solutions | System Inventory | $Date ===" | Tee-Object -FilePath $OutputFilePath

#Collecting System Information
#Get-ComputerInfo | Select-Object -Property OSName, OSVersion, CSName, CsUserName, OsUptime, CSNumberOfLogicalProcessors, CsTotalPhysicalMemory | Out-File -Path C:\ClassFiles-EWI\WinOps-Automation-Suite\01_Local_Admin\SystemInventory_<ComputerName>_<Date>.txt

#Rewritten to use variables
#$SystemInfo | Tee-Object -Append -FilePath $OutputFilePath
#"Total Physical Memory (GB): $MemoryGB" | Tee-Object -Append -FilePath $OutputFilePath

#Rewrite to use variables and include the memory calculation
$SystemInfo | Tee-Object -Append -FilePath $OutputFilePath