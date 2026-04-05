<# Phase 1 Requirements Spec
Get-SystemInventory.ps1

🎯 Your mission: Write a script that collects key information about the local computer and displays it in a clean, readable format.

What the script must do

Display a header — something like === Contoso Federal Solutions | System Inventory === with the date and time it was run
Collect and display the following information:

Computer name
Operating system name and version
Current logged-in username
System uptime (how long since last boot)
Number of logical processors
Total physical memory (in GB, rounded to 2 decimal places)


Use Get-Help to look up at least one cmdlet you're not sure about — you don't have to show this in the script, but you should be able to tell me which one you looked up and what you learned
Export the results to a .txt file saved in the same folder as the script — name it SystemInventory_<ComputerName>_<Date>.txt #>

#Start of Project

#Step 1: Header
#Get-Help 
#Get-Help Header
#Update-Help
#Out-String "=== Contoso Federal Solutions | System Inventory ==="
Write-Host "=== Contoso Federal Solutions | System Inventory ==="

#Step 2: Collect and Display Computer Information

Get-Process 
Get-Help user
Get-Host
Get-User
Get-Alias
Get-PSProvider
Get-PSHostProcessInfo
Get-Member
Get-Command *computer*
Get-Command *os*

