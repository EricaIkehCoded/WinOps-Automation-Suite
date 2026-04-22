# WinOps Automation Suite — Project Specifications
**Author:** Erica Ikeh | EricaIkehCoded
**Course:** AZ-040T00 — Automating Administration with PowerShell
**Program:** Microsoft Software & Systems Academy (MSSA)
**Status:** In Progress

---

## Project Overview

The WinOps Automation Suite is a modular PowerShell toolkit built for
a fictional company called Contoso Federal Solutions. Each phase maps
directly to a module in the AZ-040T00 curriculum and demonstrates
hands-on proficiency with a specific set of PowerShell skills.

The project is organized into 9 phases, each producing a standalone
script that solves a real sysadmin problem. All scripts follow
consistent standards including comment-based help blocks, dynamic
file naming, and timestamped exports.

---

## Project Structure

WinOps-Automation-Suite/
├── 01_Local_Admin/
│   └── Get-SystemInventory.ps1
├── 02_Pipeline_Tools/
│   └── Get-FilteredProcessReport.ps1
├── 03_PSDrives/
│   └── Explore-RegistryDrive.ps1
├── 04_WMI_CIM/
│   └── Get-HardwareInfo.ps1
├── 05_Scripting/
│   └── New-UserOnboardingReport.ps1
├── 06_Remoting/
│   └── Invoke-RemoteHealthCheck.ps1
├── 07_Azure_Management/
│   └── Manage-AzureVMs.ps1
├── 08_M365_Management/
│   └── Manage-M365Users.ps1
├── 09_Jobs_Scheduling/
│   └── Schedule-WeeklyReport.ps1
└── _Notes/
├── project-specs.md
├── git-commands-reference.ps1
└── folder-structure-snippet.ps1

---

## Progress Tracker

| Phase | Script | Topic | Status |
|---|---|---|---|
| 1 | `Get-SystemInventory.ps1` | Cmdlets & Local Admin | ✅ Complete |
| 2 | `Get-FilteredProcessReport.ps1` | Pipeline Tools | ✅ Complete |
| 3 | `Explore-RegistryDrive.ps1` | PSProviders & PSDrives | ✅ Complete |
| 4 | `Get-HardwareInfo.ps1` | WMI & CIM Queries | ✅ Complete |
| 5 | `New-UserOnboardingReport.ps1` | Scripting & Logic | 🔄 In Progress |
| 6 | `Invoke-RemoteHealthCheck.ps1` | PowerShell Remoting | ⏳ Upcoming |
| 7 | `Manage-AzureVMs.ps1` | Azure Management | ⏳ Upcoming |
| 8 | `Manage-M365Users.ps1` | Microsoft 365 Management | ⏳ Upcoming |
| 9 | `Schedule-WeeklyReport.ps1` | Background & Scheduled Jobs | ⏳ Upcoming |

---

## Phase 1 — Local Admin & Cmdlets ✅
### `Get-SystemInventory.ps1`

**Scenario:**
As a Junior Systems Administrator at Contoso Federal Solutions, I was
tasked with creating an automated system inventory tool to replace
manual documentation.

**Requirements:**
- Display a header with company name and timestamp
- Collect OS name, version, computer name, and username
- Calculate system uptime
- Report number of logical processors
- Convert total physical memory from bytes to GB
- Export results to a timestamped .txt file
**Skills covered:**
- Cmdlet discovery with Get-Command and Get-Help
- Get-ComputerInfo with calculated properties
- Dynamic variable construction
- Math conversion (bytes to GB using [Math]::Round)
- Tee-Object for simultaneous screen and file output
- Dynamic file naming with environment variables

**Output file:** `SystemInventory_<ComputerName>_<Date>.txt`

---

## Phase 2 — Pipeline Tools ✅
### `Get-FilteredProcessReport.ps1`

**Scenario:**
I was tasked with identifying processes consuming excessive memory
on local machines to replace slow manual Task Manager review.

**Requirements:**
- Retrieve all running processes
- Filter to only show processes consuming more than 50MB of memory
- Sort by memory usage from highest to lowest
- Display Process Name, Process ID, Memory in MB, and CPU time
- Memory must be converted from bytes to MB
- Must chain at least 3 pipeline commands together
- Export results to a timestamped .txt file
**Skills covered:**
- Pipeline chaining with Where-Object, Sort-Object, Select-Object
- Calculated properties for memory conversion inside Select-Object
- Tee-Object for simultaneous screen and file output
- PowerShell native units (50MB, 1MB)
- WorkingSet64 vs WorkingSet — why 64-bit matters

**Output file:** `ProcessReport_<ComputerName>_<Date>.txt`

---

## Phase 3 — PSProviders & PSDrives ✅
### `Explore-RegistryDrive.ps1`

**Scenario:**
I was tasked with documenting available storage providers and drives
on local machines and retrieving key OS information directly from
the Windows Registry.

**Requirements:**
- List all available PSProviders on the system
- List all current PSDrives on the system
- Navigate to HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion
- Retrieve ProductName, CurrentVersion, CurrentBuild, RegisteredOwner
- Create a custom PSDrive called CFS_PSDrive mapped to HKLM:\SOFTWARE\Microsoft
- Navigate and export contents of the custom PSDrive
- Remove the custom PSDrive when complete
- User confirmation required before creating and removing the drive
- Export all results to a timestamped .txt file

**Skills covered:**
- Get-PSProvider and Get-PSDrive
- New-PSDrive and Remove-PSDrive
- Set-Location for registry navigation
- Get-ItemProperty for reading registry values
- Out-File -Append for multi-section reports
- Absolute file paths when working across providers
- -Confirm flag for safety on destructive operations

**Output file:** `RegistryReport_<ComputerName>_<Date>.txt`

---

## Phase 4 — WMI & CIM Queries ✅
### `Get-HardwareInfo.ps1`

**Scenario:**
I was tasked with building an automated hardware audit tool that
documents the full hardware profile of local machines without
requiring physical inspection.

**Requirements:**
- Query and display BIOS information
- Query and display processor details
- Query and display physical memory with GB conversion
- Query and display disk drives with GB conversion
- Query and display network adapter configuration
- Query and display operating system details
- Must use Get-CimInstance not Get-WmiObject
- Must query at least 4 different CIM classes
- Export all results to a timestamped .txt File
**CIM Classes used:**
- Win32_BIOS
- Win32_Processor
- Win32_PhysicalMemory
- Win32_DiskDrive
- Win32_NetworkAdapterConfiguration
- Win32_OperatingSystem

**Skills covered:**
- Get-CimInstance with ClassName parameter
- Calculated properties for size conversions
- Multi-section report building with Out-File -Append
- Why CIM is preferred over WMI in PowerShell 7

**Output file:** `HardwareReport_<ComputerName>_<Date>.txt`

---

## Phase 5 — Scripting & Logic 🔄
### `New-UserOnboardingReport.ps1`

**Scenario:**
HR sends a list of new hires and I need to automate the generation
of personalized onboarding reports for each person.

**Requirements:**
- Create an array of hash tables with at least 4 new hires
- Each hire must have: FirstName, LastName, Department,
JobTitle, StartDate
- Use a foreach loop to process each new hire
- Use if/elseif/else to assign building based on department:
- IT → Building A
- HR → Building B
- Finance → Building C
- All others → Building D
- Assign equipment package based on department
- Generate IT ticket number using Get-Random
- Export individual report per employee
- Export master summary report for all employees

**Skills covered:**
- Arrays and hash tables
- Foreach loops
- If/ElseIf/Else conditional logic
- String formatting and interpolation
- Get-Random for ticket generation
- Dynamic file naming per employee
- Master summary report generation

**Output files:**
- `Onboarding_<LastName>_<FirstName>_<Date>.txt` (one per employee)
- `OnboardingSummary_<Date>.txt`

---

## Phase 6 — PowerShell Remoting ⏳
### `Invoke-RemoteHealthCheck.ps1`

**Scenario:**
I need to check the health of remote branch servers without
physically visiting each location.

**Requirements:**
- Test remote connectivity using Test-WSMan
- Create persistent sessions using New-PSSession
- Run health check commands on remote machines using Invoke-Command
- Collect CPU usage, memory, and disk space remotely
- Manage multiple sessions simultaneously
- Clean up sessions using Remove-PSSession
- Export remote health check results to a report

**Skills covered:**
- PSRemoting architecture and security
- New-PSSession and Remove-PSSession
- Invoke-Command for remote execution
- Enter-PSSession for interactive remoting
- Test-WSMan for connectivity testing
- Managing persistent sessions
- Handling remote output

**Output file:** `RemoteHealthCheck_<Date>.txt`

---

## Phase 7 — Azure Management ⏳
### `Manage-AzureVMs.ps1`

**Scenario:**
I need to manage Contoso Federal Solutions Azure resources from
the command line without using the Azure portal.

**Requirements:**
- Install and import the Az PowerShell module
- Authenticate to Azure using Connect-AzAccount
- List available subscriptions
- List and filter resource groups
- Query Azure VMs and their current status
- Start and stop Azure VMs using PowerShell
- Query Azure storage accounts
- Export Azure resource inventory to a report

**Skills covered:**
- Az module installation and management
- Connect-AzAccount authentication
- Get-AzSubscription and Get-AzResourceGroup
- Get-AzVM, Start-AzVM, Stop-AzVM
- Get-AzStorageAccount
- Azure Cloud Shell
- Managing cloud resources with PowerShell

**Note:** Requires Azure subscription.
MSSA students should have access to Azure credits.

**Output file:** `AzureInventory_<Date>.txt`

---

## Phase 8 — Microsoft 365 Management ⏳
### `Manage-M365Users.ps1`

**Scenario:**
I need to manage Contoso Federal Solutions Microsoft 365 users
and licenses from PowerShell instead of the admin portal.

**Requirements:**
- Install Microsoft Graph and Exchange Online modules
- Connect to Microsoft 365 using Connect-MgGraph
- List all M365 users and their license status
- Create a new M365 user
- Assign and remove licenses
- Manage M365 security groups
- Connect to Exchange Online
- Query and manage mailboxes
- Export M365 user inventory to a report

**Skills covered:**
- Microsoft Graph PowerShell module
- Connect-MgGraph authentication
- Get-MgUser, New-MgUser, Set-MgUserLicense
- Get-MgGroup and group management
- Connect-ExchangeOnline
- Get-Mailbox and mailbox management
- Managing cloud services with PowerShell

**Note:** Requires Microsoft 365 tenant access.
MSSA students should have M365 access through the program.

**Output file:** `M365UserReport_<Date>.txt`

---

## Phase 9 — Background & Scheduled Jobs ⏳
### `Schedule-WeeklyReport.ps1`

**Scenario:**
I need the system inventory script from Phase 1 to run
automatically every week without manual intervention.

**Requirements:**
- Run commands as background jobs using Start-Job
- Monitor job status using Get-Job
- Retrieve job results using Receive-Job
- Clean up completed jobs using Remove-Job
- Create a scheduled job using Register-ScheduledJob
- Configure a weekly trigger using New-JobTrigger
- Set job options using New-ScheduledJobOption
- Schedule Phase 1 script to run every Monday at 6am
- Export job results and schedule confirmation to a report

**Skills covered:**
- Start-Job and background job management
- Get-Job, Receive-Job, Remove-Job
- Register-ScheduledJob and Unregister-ScheduledJob
- New-JobTrigger for schedule configuration
- New-ScheduledJobOption for job behavior
- Difference between background jobs and scheduled jobs
- Retrieving and handling job output

**Output file:** `JobScheduleReport_<Date>.txt`

---

## Coding Standards

All scripts in this project follow these standards:

**Comment block:** Every script begins with a comment-based help
block including SYNOPSIS, DESCRIPTION, EXAMPLE, and NOTES sections.

**Naming convention:** Output files follow the pattern
`<ReportType>_<ComputerName>_<Date>.txt` or
`<ReportType>_<Date>.txt` for non-machine-specific reports.

**Date formats:**
- Display dates: `Get-Date` (default readable format)
- File name dates: `Get-Date -Format "yyyy-MM-dd_HH-mm-ss"`

**Output:** All scripts display results to screen AND export to
a timestamped file using Tee-Object or Out-File -Append.

**Error handling:** Try/Catch blocks to be added during final
polish pass after all phases are complete.

---

## Final Polish Pass (Post Phase 9)

Before making the repository public the following tasks will
be completed across all scripts:

- Add Try/Catch error handling to every script
- Verify consistent comment block format across all scripts
- Add screenshots of script output to each phase README
- Update main README with final progress tracker
- Add demo section to main README showing sample outputs
- Final review of all READMEs for consistency and quality
- Make repository public for employer visibility
- Add repository link to LinkedIn profile and resume