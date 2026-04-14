# Phase 1 — Local Admin & Cmdlets ✅

## script
`Get-SystemInventory.ps1`

## scenarioAs a Junior Systems Administrator at Contoso Federal Solutions,
I was tasked with creating an automated system inventory tool
to replace manual documentation. This script collects key
system information and exports it to a timestamped report file.

## What it does
- Displays a company header with timestamp
- Collects OS name, version, computer name, and username
- Calculates system uptime
- Reports number of logical processors
- Converts total physical memory from bytes to GB
- Outputs results to screen AND a timestamped .txt file simultaneously

## Skills demonstrated
| Skill | How it's used |
|---|---|
| Cmdlet discovery | Get-ComputerInfo, Get-Date, Tee-Object |
| Pipeline | Piping Get-ComputerInfo into Select-Object |
| Calculated properties | Memory conversion inside Select-Object |
| Variables | Storing computer name, date, file path, system info |
| Environment variables | $env:COMPUTERNAME |
| .NET Math | [Math]::Round() for GB conversion |
| Dynamic file naming | SystemInventory_$ComputerName_$Date.txt |

## Key cmdlets used
- `Get-ComputerInfo` — collects local system information
- `Select-Object` — filters and creates calculated properties
- `Get-Date` — captures current timestamp
- `Tee-Object` — outputs to screen and file simultaneously

## Sample output

=== Contoso Federal Solutions | System Inventory | 2026-04-13 ===
OsName                   : Microsoft Windows 10 Enterprise
OsVersion                : 10.0.19043
CsName                   : LON-CL1
CsUserName               : ADATUM\Administrator
OsUptime                 : 00:58:20
CsNumberOfLogicalProcessors : 4
MemoryGB                 : 4

## What I learned
- How to use Get-Help and Get-Command to discover cmdlets independently
- The difference between Write-Host and piping strings through Tee-Object
- How calculated properties work inside Select-Object
- Why [Math]::Round() is a .NET method not a PowerShell cmdlet
- How -Append works with Tee-Object for multi-line file output