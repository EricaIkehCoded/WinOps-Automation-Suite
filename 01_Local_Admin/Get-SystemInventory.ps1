<#
.SYNOPSIS
    Collects and exports system inventory information for the local machine.
    
.DESCRIPTION
    This script gathers key system information for Contoso Federal Solutions including OS details, hardware specs, uptime, and memory. Results are displayed to the screen and exported to a timestamped text file. Built as part of the WinOps Automation Suite portfolio project.
                    
.EXAMPLE
    .\Get-SystemInventory.ps1
    Displays system inventory and creates SystemInventory_<ComputerName>_<Date>.txt
                            
.NOTES
    Author: EricaIkehCoded
    Date: 2026-04-13
    Course: AZ-040T00 (Independent Project)
    Phase: 1 - Local Admin & Cmdlets
#>

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