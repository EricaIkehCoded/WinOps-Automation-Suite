#This script is used to gather system inventory information for the local machine. It collects various details about the operating system, hardware, and other relevant information that can be useful for troubleshooting, documentation, or inventory management purposes.

#Variables
$ComputerName = $env:COMPUTERNAME
$Date = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$OutputFilePath = ".\SystemInventory_$ComputerName_$Date.txt"
$SystemInfo = Get-ComputerInfo | Select-Object -Property OSName, OSVersion, CSName, CsUserName, OsUptime, CSNumberOfLogicalProcessors, CsTotalPhysicalMemory


#Header

Write-Host "=== Contoso Federal Solutions | System Inventory ==="

#Collecting System Information
#Get-ComputerInfo | Select-Object -Property OSName, OSVersion, CSName, CsUserName, OsUptime, CSNumberOfLogicalProcessors, CsTotalPhysicalMemory | Out-File -Path C:\ClassFiles-EWI\WinOps-Automation-Suite\01_Local_Admin\SystemInventory_<ComputerName>_<Date>.txt

#Rewritten to use variables
$SystemInfo | Out-File -FilePath $OutputFilePath