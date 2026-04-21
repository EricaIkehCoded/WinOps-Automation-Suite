<#
.SYNOPSIS
    Collects and exports running processes on the local machine.
    
.DESCRIPTION
    This script gathers key system information for Contoso Federal Solutions for running processe including process name, process ID, 
    memory usage, and CPU Time. Results are sorted, filtered and displayed to the screen and exported to a timestamped text file. 
    Built as part of the WinOps Automation Suite portfolio project.
                    
                    
.EXAMPLE
    .\Get-FilteredProcessReport.ps1
                            
.NOTES
    Author: EricaIkehCoded
    Date: 2026-04-20
    Course: AZ-040T00 (Independent Project)
    Phase: 2 - Pipeline Tools
#>

#Variables
$FileDate = Get-Date -Format "yyyy-MM-dd_HH-mm-ss" #File safe date formate
$Date = Get-Date #Date for header

#Header
Write-Host "=== Contoso Federal Solutions | Process Report | $Date ==="

#Get filtered process report
Get-Process |
    Where-Object {$_.WorkingSet64 -GT 50MB} |
    Sort-Object WorkingSet64 -Descending |
    Select-Object ProcessName, ID, @{Name = "MemoryMB"; Expression = {[Math]::Round($_.WorkingSet64 / 1MB, 2)}}, CPU |
    Tee-Object -FilePath ".\ProcessReport_$($env:COMPUTERNAME)_$FileDate.txt"