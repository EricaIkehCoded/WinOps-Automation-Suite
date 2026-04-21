<#
Phase 4 Requirements Spec
Get-HardwareInfo.ps1

🎯 Your mission: Write a script that uses CIM to query detailed hardware information from the local machine and exports a structured report.

What the script must do

Display a header — company name and timestamp
Query and display the following using Get-CimInstance:

Section                   CIM Class
BIOS Information          Win32_BIOS
Processor Details         Win32_Processor
Physical Memory           Win32_Physical
MemoryDisk Drives         Win32_DiskDrive
Network Adapters          Win32_NetworkAdapterConfiguration
Operating System          Win32_OperatingSystem

For each section:

Display a section header
Query the CIM class
Select only the most useful properties
Export to the report file


Convert sizes where relevant:

Disk size from bytes to GB
Memory size from bytes to GB


Export results to HardwareReport_<ComputerName>_<Date>.txt


Constraints

Must use Get-CimInstance — not Get-WmiObject
Must query at least 4 different CIM classes
Must use -ClassName parameter explicitly
Size conversions must use math

Key cmdlets to explore
Get-Help Get-CimInstance
Get-Help Get-CimClass
Get-CimInstance -ClassName Win32_BIOS
#>

#Header
$Date = Get-Date
Write-Host "=== Contoso Federal Solutions | Hardware Information | $Date ==="

#Section Headers
Write-Host "=== BIOS Information ==="
Write-Host "=== Processor Details ==="
Write-Host "=== Physical Memory ==="
Write-Host "=== Disk Drives ==="
Write-Host "=== Network Adapters ==="
Write-Host "=== Operating Systems ==="

#Export Details
$FileDate = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$HardwareReport  = "C:\ClassFiles-EWI\WinOps-Automation-Suite\03_WMI_CIM\HardwareReport_$($env:COMPUTERNAME)_$FileDate.txt"

#CIM Query
Get-Help Get-CimInstance -Online
Get-CimInstance | Get-Member
Get-ItemProperty | Get-CIMInstance
Get-Help Get-CimClass -Online
Get-CimClass | Out-GridView

#BIOS Information
Get-CimInstance WIN32_BIOS
Get-CimInstance WIN32_BIOS | Select-Object *
Get-CimInstance Win32_BIOS | Get-Member | Out-GridView
Get-CimInstance WIN32_BIOS | Select-Object Manufacturer, Name, SerialNumber, Version, Status 


#Processor Details
Get-CimInstance Win32_Processor
Get-CimInstance Win32_Processor | Get-Member | Out-GridView
Get-CimInstance Win32_Processor | Select-Object * | Out-GridView
Get-CimInstance Win32_Processor | Select-Object Name, MaxClockSpeed, Manufacturer, NumberOfCores, Status

#Physical Memory
Get-CimInstance Win32_PhysicalMemory
Get-CimInstance Win32_PhysicalMemory | Get-Member | Out-GridView
Get-CimInstance Win32_PhysicalMemory | Select-Object * | Out-GridView
Get-CimInstance Win32_PhysicalMemory | Select-Object Name, @{Name = "CapacityGB"; Expression = {[Math]::Round($_.Capacity / 1GB, 2)}}, MemoryType
#@{Name = "CapacityGB"; Expression = {[Math]::Round($_.Capacity / 1GB, 2)}}


#Disk Drives
Get-CimInstance Win32_DiskDrive
Get-CimInstance Win32_DiskDrive | Get-Member | Out-GridView
Get-CimInstance Win32_DiskDrive | Select-Object * | Out-GridView
Get-CimInstance Win32_DiskDrive | Select-Object Name, Description, SystemName, @{Name = "SizeGB"; Expression = {[Math]::Round($_.Size / 1GB, 2)}}, Status
#@{Name = "SizeGB"; Expression = {[Math]::Round($_.Size / 1GB, 2)}}


#Network Adapters
Get-CimInstance Win32_NetworkAdapterConfiguration
Get-CimInstance Win32_NetworkAdapterConfiguration | Get-Member | Out-GridView
Get-CimInstance Win32_NetworkAdapterConfiguration | Select-Object * | Out-GridView
Get-CimInstance Win32_NetworkAdapterConfiguration | Select-Object ServiceName, Description, DHCPEnabled, IPAddress, MACAddress 


#Operating Systems
Get-CimInstance Win32_OperatingSystem
Get-CimInstance Win32_OperatingSystem | Get-Member | Out-GridView
Get-CimInstance Win32_OperatingSystem| Select-Object * | Out-GridView
Get-CimInstance Win32_OperatingSystem| Select-Object Caption, @{Name = "FreePhysicalMemoryMB"; Expression = {[Math]::Round($_.FreePhysicalMemory / 1MB, 2)}}, LastBootUpTime, BuildNumber, Version
#@{Name = "FreePhysicalMemoryGB"; Expression = {[Math]::Round($_.FreePhysicalMemory / 1GB, 2)}}
