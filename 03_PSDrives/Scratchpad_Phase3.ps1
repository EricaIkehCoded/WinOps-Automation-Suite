<#

Phase 3 Requirements Spec
Explore-RegistryDrive.ps1

🎯 Your mission: Use PSProviders and PSDrives to navigate and report on the Windows Registry like a file system.

Background — what are PSProviders and PSDrives?
A PSProvider is a PowerShell adapter that makes different data stores look like a file system. A PSDrive is a connection to one of those stores.
This means you can navigate the Windows Registry the same way you navigate folders:
cd HKLM:\SOFTWARE    # just like cd C:\Users
ls                   # lists registry keys like folders

What the script must do

1. Display a header — company name and timestamp
2. List all available PSProviders on the system
3. List all current PSDrives on the system
4. Navigate to a registry location and retrieve values:
    -Go to HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion
    -Retrieve and display the following values:
        -ProductName
        -CurrentVersion
        -CurrentBuild
        -RegisteredOwner
5. Create a custom PSDrive called CompanyData mapped to HKLM:\SOFTWARE\Microsoft
6. Use your custom PSDrive to navigate and list its contents
7. Export results to a timestamped .txt file
8. Remove the custom PSDrive when done — clean up after yourself!


Constraints

-Must use Get-PSDrive and Get-PSProvider
-Must use New-PSDrive and Remove-PSDrive
-Must navigate using the registry provider (HKLM: drive)
-Use Get-ItemProperty to retrieve registry values

Key cmdlets to explore
Get-Help Get-PSProvider
Get-Help Get-PSDrive
Get-Help New-PSDrive
Get-Help Remove-PSDrive
Get-Help Get-ItemProperty
#>

# 1.Header

$Date = Get-Date
Write-Host "=== Contoso Federal Solutions | Registry Drive | $Date ==="

# 2. List all available PSProviders on the system

get-help Get-PSProvider -online
Get-PSProvider | Out-GridView

# 3. List all current PSDrives on the system
Get-Help Get-PSDrive -Online
Get-PsDrive | Out-GridView

# 4. Navigate to a registry location and retrieve values -Go to HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion
cd "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"

# 4. -Retrieve and display the following values: -ProductName -CurrentVersion -CurrentBuild -RegisteredOwner
Get-PSDrive | Out-GridView
Get-PSDrive | Get-Member | Out-GridView
Get-PSDrive | Get-Member | Select-Object * | Out-GridView
Get-Help Get-ItemProperty -Online
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | Out-GridView
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | Select-Object ProductName, CurrentVersion, CurrentBuild, RegisteredOwner
cd..

# 5. Create a custom PSDrive called CompanyData mapped to HKLM:\SOFTWARE\Microsoft
Get-Help New-PSDrive -Online
New-PSDrive -Name "CFS_PSDrive" -PSProvider "Registry" -Root "HKLM:\SOFTWARE\Microsoft" -Confirm

# 6. Use your custom PSDrive to navigate and list its contents
cd..
cd "CFS_PSDrive:"
Get-ChildItem | Out-GridView

# 7. Export results to a timestamped .txt file
Tee-Object -FilePath ".\RegistryReport_$($env:COMPUTERNAME)_$FileDate.txt"

# 8. Remove the custom PSDrive when done — clean up after yourself!

Get-Help Remove-PSDrive

Remove-PSDrive "CFS_PSDrive" -Confirm -Force
