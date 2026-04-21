# Phase 4 — WMI & CIM Queries ✅

## Script
`Get-HardwareInfo.ps1`

## Scenario
As a Junior Systems Administrator at Contoso Federal Solutions,
I was tasked with building an automated hardware audit tool that
could document the full hardware profile of local machines without
requiring physical inspection or manual data entry. This script
uses PowerShell's CIM interface to query six hardware classes and
export a comprehensive structured report.

## What it does
- Displays a company header with timestamp
- Queries and exports BIOS manufacturer, name, version and status
- Queries and exports processor name, speed, cores and status
- Queries and exports physical memory capacity converted to GB
- Queries and exports disk drive models and sizes converted to GB
- Queries and exports network adapter IP and MAC addresses
- Queries and exports OS caption, version, build and last boot time
- Converts free physical memory from KB to MB
- Exports all results to a timestamped report file

## Skills demonstrated
| Skill | How it's used |
|---|---|
| Get-CimInstance | Queries 6 different Win32 CIM classes |
| CIM classes | Win32_BIOS, Win32_Processor, Win32_PhysicalMemory, Win32_DiskDrive, Win32_NetworkAdapterConfiguration, Win32_OperatingSystem |
| Calculated properties | Size conversions inside Select-Object |
| Tee-Object | Outputs each section to screen and file |
| Out-File -Append | Builds multi-section report file |
| Pipeline | Chains Get-CimInstance through Select-Object to Tee-Object |
| Math conversion | Bytes to GB for memory and disk, KB to MB for free memory |

## CIM Classes queried

| Class | Data retrieved |
|---|---|
| `Win32_BIOS` | Manufacturer, Name, SerialNumber, Version, Status |
| `Win32_Processor` | Name, MaxClockSpeed, Manufacturer, NumberOfCores, Status |
| `Win32_PhysicalMemory` | Name, CapacityGB, MemoryType |
| `Win32_DiskDrive` | Name, Description, SystemName, SizeGB, Status |
| `Win32_NetworkAdapterConfiguration` | ServiceName, Description, DHCPEnabled, IPAddress, MACAddress |
| `Win32_OperatingSystem` | Caption, FreePhysicalMemoryMB, LastBootUpTime, BuildNumber, Version |

## Key cmdlets used
- `Get-CimInstance` — queries hardware information via CIM
- `Select-Object` — filters properties and creates calculated fields
- `Tee-Object` — splits output to screen and file simultaneously
- `Out-File -Append` — appends section headers to report file

## Why CIM over WMI?

| | WMI (Legacy) | CIM (Modern) |
|---|---|---|
| Cmdlet | `Get-WmiObject` | `Get-CimInstance` |
| Protocol | DCOM | WS-Management |
| PowerShell 7 | Removed | Fully supported |
| Remote use | Limited | Preferred |

`Get-WmiObject` was removed in PowerShell 7. `Get-CimInstance` is
the current standard and the only approach that works across all
modern PowerShell environments.

## Sample output

=== Contoso Federal Solutions | Hardware Information | 04/21/2026 12:32:40 ===
=== BIOS Information ===

Manufacturer : American Megatrends Inc.
Name         : BIOS Date: 12/07/18 15:46:29  Ver: 09.00.08
SerialNumber : 6662-1618-0674-6386-6786-3839-07
Version      : VRTUAL - 12001807
Status       : OK

=== Processor Details ===

Name          : Intel(R) Xeon(R) Gold 6230R CPU @ 2.10GHz
MaxClockSpeed : 2095
Manufacturer  : GenuineIntel
NumberOfCores : 2
Status        : OK

=== Physical Memory ===

Name            CapacityGB MemoryType
----            ---------- ----------
Physical Memory       3.88          1
Physical Memory       0.12          1

=== Disk Drives ===

Name        : \\.\PHYSICALDRIVE1
Description : Microsoft Hyper-V Accelerated Disk Drive
SystemName  : LON-CL1
SizeGB      : 126.99
Status      : OK

=== Network Adapters ===

ServiceName : kdnic
Description : Microsoft Kernel Debug Network Adapter
DHCPEnabled : True
IPAddress   : 
MACAddress  : 

=== Operating Systems ===

Caption              : Microsoft Windows 10 Enterprise
FreePhysicalMemoryMB : 1.27
LastBootUpTime       : 4/20/2026 11:36:40 PM
BuildNumber          : 19043
Version              : 10.0.19043

## What I learned
- The difference between WMI and CIM and why CIM is preferred
- How to query different Win32 classes using Get-CimInstance
- Why section headers must be separate pipeline chains from Get-CimInstance to avoid computer name resolution errors
- How to convert bytes to GB and KB to MB using calculated properties
- How to build a multi-section report using Out-File -Append
- How to read network adapter configuration including IP and MAC
addresses from the CIM interface