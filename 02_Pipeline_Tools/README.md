# Phase 2 — Pipeline Tools ✅

## Script
`Get-FilteredProcessReport.ps1`

## Scenario
As a Junior Systems Administrator at Contoso Federal Solutions,
I was tasked with identifying processes consuming excessive memory
on local machines. Manual review of Task Manager was too slow and
inconsistent across systems. This script automates the process by
filtering, sorting, and exporting a clean report of memory-hungry
processes in a repeatable and documented way.

## What it does
- Displays a company header with timestamp
- Retrieves all running processes on the local machine
- Filters to only show processes consuming more than 50MB of memory
- Sorts results by memory usage from highest to lowest
- Converts memory from bytes to MB rounded to 2 decimal places
- Displays Process Name, Process ID, Memory (MB), and CPU time
- Outputs results to screen AND a timestamped .txt file simultaneously

## Skills demonstrated
| Skill | How it's used |
|---|---|
| Pipeline chaining | 4 commands chained with the pipeline operator |
| Where-Object | Filters processes above 50MB memory threshold |
| Sort-Object | Sorts results descending by memory usage |
| Select-Object | Selects specific properties for clean output |
| Calculated properties | Converts WorkingSet64 bytes to MB inside Select-Object |
| Tee-Object | Outputs to screen and file simultaneously |
| Environment variables | $env:COMPUTERNAME used directly in file path |
| PowerShell native units | 50MB and 1MB used instead of raw byte values |

## Key cmdlets used
- `Get-Process` — retrieves all running processes
- `Where-Object` — filters objects based on a condition
- `Sort-Object` — sorts pipeline objects by a property
- `Select-Object` — selects and creates calculated properties
- `Tee-Object` — splits pipeline output to screen and file

## The pipeline
```powershell
Get-Process |
    Where-Object {$_.WorkingSet64 -GT 50MB} |
    Sort-Object WorkingSet64 -Descending |
    Select-Object ProcessName, ID, @{Name = "MemoryMB"; Expression = {[Math]::Round($_.WorkingSet64 / 1MB, 2)}}, CPU |
    Tee-Object -FilePath ".\ProcessReport_$($env:COMPUTERNAME)_$FileDate.txt"
 ```

## Sample output

=== Contoso Federal Solutions | Process Report | 04/20/2026 10:39:18 ===

ProcessName           Id MemoryMB     CPU
-----------           -- --------     ---
Code                 120   335.13  955.23
Memory Compression  2500   213.86  282.20
MsMpEng             3184   165.61 2274.67
pwsh               11964   134.35  857.67
dwm                 1108    86.04  446.86
Code               10456    64.79  463.31
Code                4988    62.31  124.48
svchost             2340    54.53  302.12
Registry             100    54.24   10.53

## What I learned
- How to chain multiple cmdlets together using the pipeline operator
- The difference between WorkingSet and WorkingSet64 and why 64-bit matters
- How PowerShell natively understands units like 50MB and 1GB
- How calculated properties work inside Select-Object using hashtables
- Why breaking a long pipeline across multiple lines improves readability
- How to use two date variables for different formatting needs