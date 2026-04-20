<#
.SYNOPSIS    
Explores and exports PSProviders, PSDrives, and Windows Registry values on the local machine.
    
.DESCRIPTION
    This script demonstrates the use of PSProviders and PSDrives for Contoso Federal Solutions. It lists all available PSProviders and
    PSDrives on the system, navigates the Windows Registry using the Registry provider, and retrieves key OS information from 
    HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion. The script also creates a custom PSDrive called CFS_PSDrive mapped to 
    HKLM:\SOFTWARE\Microsoft, navigates and exports its contents, then safely removes the drive when complete. User confirmation is required 
    before creating and removing the custom PSDrive as a safety measure. All results are exported to a timestamped report file. Built as part of 
    the WinOps Automation Suite portfolio project.
                                                        
.EXAMPLE
    .\Explore-RegistryDrive.ps1
                            
.NOTES
    Author: EricaIkehCoded
    Date: 2026-04-20
    Course: AZ-040T00 (Independent Project)
    Phase: 3 - Registry Drives
#>

#Variables
$Date = Get-Date
$FileDate = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$OutputFilePath = "C:\ClassFiles-EWI\WinOps-Automation-Suite\03_PSDrives\RegistryReport_$($env:COMPUTERNAME)_$FileDate.txt"

#Header
"=== Contoso Federal Solutions | Registry Drive | $Date ===" | Out-File $OutputFilePath

#PSProvider List
"=== PSProviders ===" | Out-File $OutputFilePath -Append
Get-PSProvider | Out-File $OutputFilePath -Append

#PSDrive List
"=== PS Drives ===" | Out-File $OutputFilePath -Append
Get-PSDrive | Out-File $OutputFilePath -Append

#Registry Value List for HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion
Set-Location "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"

"=== Registry Values ===" | Out-File $OutputFilePath -Append
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" |
    Select-Object ProductName, CurrentVersion, CurrentBuild, RegisteredOwner |
    Out-File $OutputFilePath -Append

#Create Custom PSDrive "CFS_PSDrive"
# -Confirm required - creates a registry drive, user must approve 
New-PSDrive -Name "CFS_PSDrive" -PSProvider "Registry" -Root "HKLM:\SOFTWARE\Microsoft" -Confirm

#Export Contents of Custom PSDrive "CFS_PSDrive"
Set-Location "CFS_PSDrive:"
"=== CFS_PSDrive Contents ===" | Out-File $OutputFilePath -Append
Get-ChildItem | Tee-Object $OutputFilePath -Append

#Remove Custom PSDrive "CFS_PSDrive"
# -Comfirm required  - deletes registry drive, user must approve
Set-Location C:\

Remove-PSDrive "CFS_PSDrive" -Confirm -Force

