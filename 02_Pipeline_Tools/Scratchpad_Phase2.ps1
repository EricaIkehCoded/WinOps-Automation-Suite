<#
Phase 2 Requirements Spec
.\Get-FilteredProcessReport.ps1
🎯 Your mission: Write a script that retrieves running processes on the local machine, filters and sorts them, and exports a clean report.

What the script must do

Display a header — company name and timestamp like Phase 1 ✔
Retrieve all running processes and display them
Filter — only show processes using more than 50MB of memory
Sort — by memory usage, highest first
Select specific properties to display:

Process name
Process ID
Memory usage in MB (rounded to 2 decimal places)
CPU time


Export results to a .txt file named ProcessReport_<ComputerName>_<Date>.txt
#>


#Header
$Date = Get-Date 

Write-Host "=== Contoso Federal Solutions | System Inventory | $Date ==="

#Retrieve All Processes
Get-Process | Select-Object * | Out-GridView

#Filter — only show processes using more than 50MB of memory
Get-Process | Get-Member | Out-GridView
Get-Process | Get-Member -Name "WorkingSet*"

Get-Process | Where-Object  {$_. WorkingSet -GT 50MB}

#Sort — by memory usage, highest first
Get-Help sort 
Get-Process | Where-Object  {$_. WorkingSet -GT 50MB} | Sort-Object WorkingSet64
Get-Process | Where-Object  {$_. WorkingSet -GT 50MB} | Sort-Object WorkingSet64 -Descending


#Select specific properties to display:
<#
Process name = "ProcessName"
Process ID = "ID"
Memory usage in MB (rounded to 2 decimal places) = "WorkingSet64"
CPU time = "CPU"
#>

Get-Help Expression
Get-Help Select-Object -Online

Get-Process | Where-Object  {$_. WorkingSet64 -GT 50MB} | Sort-Object WorkingSet64 -Descending | Select-Object ProcessName, ID, WorkingSet64, CPU

#Export results to a .txt file named ProcessReport_<ComputerName>_<Date>.txt
Get-Help Out-File -Online
Get-help environmental
Get-Help variable
Get-help about_Environment_Variables 
$FileDate = Get-Date -Format yyyy-MM-dd_HH-mm-ss
Tee-Object -FilePath ".\ProcessReport_$($env:ComputerName)_$FileDate.txt"

#Final Command
$FileDate = Get-Date -Format yyyy-MM-dd_HH-mm-ss
$Date = Get-Date 

Write-Host "=== Contoso Federal Solutions | System Inventory | $Date ==="

Get-Process | Where-Object  {$_. WorkingSet64 -GT 50MB} | Sort-Object WorkingSet64 -Descending | Select-Object ProcessName, ID, WorkingSet64, CPU | Tee-Object -FilePath ".\ProcessReport_$($env:ComputerName)_$FileDate.txt"

#Fix: WorkingSet64 - Needs to show in MG and only 2 decimal places

#@{Name = "MemoryGB"; Expression = { [Math]::Round($_.CsTotalPhysicalMemory / 1073741824, 2) } - Code used in Phase 1
@{Name = "MemoryMB"; Expression = { [Math]::Round($_.WorkingSet64 / 1MB, 2) }

#Final Code #2 (broke the code into multiple lines for readability)
$FileDate = Get-Date -Format yyyy-MM-dd_HH-mm-ss
$Date = Get-Date 

Write-Host "=== Contoso Federal Solutions | System Inventory | $Date ===" 

Get-Process | 
    Where-Object  {$_. WorkingSet64 -GT 50MB} | 
    Sort-Object WorkingSet64 -Descending | 
    Select-Object ProcessName, ID, @{Name = "MemoryMB"; Expression = {[Math]::Round($_.WorkingSet64 / 1MB, 2)}}, CPU | 
    Tee-Object -FilePath ".\ProcessReport_$($env:ComputerName)_$FileDate.txt"
