#This script is used to gather system inventory information for the local machine. It collects various details about the operating system, hardware, and other relevant information that can be useful for troubleshooting, documentation, or inventory management purposes.

Write-Host "=== Contoso Federal Solutions | System Inventory ==="

#Get-ComputerInfo | Select-Object -Property OSName, OSVersion, CSName, CsUserName, OsUptime, CSNumberOfLogicalProcessors, CsTotalPhysicalMemory

Get-ComputerInfo | Select-Object -Property OSName, OSVersion, CSName, CsUserName, OsUptime, CSNumberOfLogicalProcessors, CsTotalPhysicalMemory | Out-File -Path C:\ClassFiles-EWI\WinOps-Automation-Suite\01_Local_Admin\SystemInventory_<ComputerName>_<Date>.txt
