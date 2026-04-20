<#
Phase 2 Requirements Spec
.\Get-FilteredProcessReport.ps1
🎯 Your mission: Write a script that retrieves running processes on the local machine, filters and sorts them, and exports a clean report.

What the script must do

Display a header — company name and timestamp like Phase 1
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
