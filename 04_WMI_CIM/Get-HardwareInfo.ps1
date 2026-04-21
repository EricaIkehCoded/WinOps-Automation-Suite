<#
.SYNOPSIS
  Queries and exports detailed hardware information from the local machine using CIM (Common Information Model).

    
.DESCRIPTION
    This script performs a comprehensive hardware audit for Contoso Federal Solutions using Get-CimInstance to query six Win32 CIM
    classes. It collects BIOS information, processor details, physical memory, disk drives, network adapter configuration, and operating
    system details.

    All size values are converted from bytes to human readable units using calculated properties inside Select-Object. Results are
    displayed to the screen and exported to a timestamped report file using Tee-Object.

    This script demonstrates the modern CIM approach over the legacy Get-WmiObject cmdlet, which is no longer recommended for use in
    PowerShell 7 environments.

    Built as part of the WinOps Automation Suite portfolio project.               
                    
.EXAMPLE
    .\Get-HardwareInfo.ps1
                            
.NOTES
    Author: EricaIkehCoded
    Date: 2026-04-21
    Course: AZ-040T00 (Independent Project)
    Phase: 4 - WMI & CMI Query
#>

#Variables

$Date = Get-Date
$FileDate = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$HardwareReport  = "C:\ClassFiles-EWI\WinOps-Automation-Suite\04_WMI_CIM\HardwareReport_$($env:COMPUTERNAME)_$FileDate.txt"

#Header
"=== Contoso Federal Solutions | Hardware Information | $Date ===" | Tee-Object -FilePath $HardwareReport

#Report Information

"=== BIOS Information ===" | Tee-Object -Path $HardwareReport -Append

    Get-CimInstance WIN32_BIOS | 
    Select-Object Manufacturer, Name, SerialNumber, Version, Status | 
    Tee-Object -Path $HardwareReport -Append

"=== Processor Details ===" | Tee-Object -Path $HardwareReport -Append

    Get-CimInstance Win32_Processor | 
    Select-Object Name, MaxClockSpeed, Manufacturer, NumberOfCores, Status| 
    Tee-Object -Path $HardwareReport -Append

"=== Physical Memory ===" | Tee-Object -Path $HardwareReport -Append

    Get-CimInstance Win32_PhysicalMemory | 
    Select-Object Name, @{Name = "CapacityGB"; Expression = {[Math]::Round($_.Capacity / 1GB, 2)}}, MemoryType | 
    Tee-Object -Path $HardwareReport -Append

"=== Disk Drives ===" | Tee-Object -Path $HardwareReport -Append

    Get-CimInstance Win32_DiskDrive | 
    Select-Object Name, Description, SystemName, @{Name = "SizeGB"; Expression = {[Math]::Round($_.Size / 1GB, 2)}}, Status | 
    Tee-Object -Path $HardwareReport -Append

"=== Network Adapters ===" | Tee-Object -Path $HardwareReport -Append

    Get-CimInstance Win32_NetworkAdapterConfiguration | 
    Select-Object ServiceName, Description, DHCPEnabled, IPAddress, MACAddress | 
    Tee-Object -Path $HardwareReport -Append

"=== Operating Systems ===" | Tee-Object -Path $HardwareReport -Append

    Get-CimInstance Win32_OperatingSystem | 
    Select-Object Caption, @{Name = "FreePhysicalMemoryMB"; Expression = {[Math]::Round($_.FreePhysicalMemory / 1MB, 2)}}, LastBootUpTime, BuildNumber, Version | 
    Tee-Object -Path $HardwareReport -Append
