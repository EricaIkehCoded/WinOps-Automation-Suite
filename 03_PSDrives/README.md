# Phase 3 — PSProviders & PSDrives ✅

## script`Explore-RegistryDrive.ps1`

## scenarioAs a Junior Systems Administrator at Contoso Federal Solutions,
I was tasked with documenting the available storage providers and
drives on local machines, and retrieving key OS information directly
from the Windows Registry. This script automates that process by
leveraging PowerShell's PSProvider and PSDrive system to navigate
the registry like a file system and export a structured report.

## What it does- Displays a company header with timestamp
- Lists all available PSProviders on the system
- Lists all current PSDrives on the system
- Navigates to HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion
- Retrieves and exports ProductName, CurrentVersion, CurrentBuild and RegisteredOwner from the registry
- Creates a custom PSDrive called CFS_PSDrive mapped to HKLM:\SOFTWARE\Microsoft (requires user confirmation)
- Navigates and exports the contents of the custom PSDrive
- Safely removes the custom PSDrive when complete (requires user confirmation)
- Exports all results to a timestamped .txt file

## Skills Demonstrated| Skill | How it's used |
|---|---|
| Get-PSProvider | Lists all available PowerShell providers |
| Get-PSDrive | Lists all current PowerShell drives |
| New-PSDrive | Creates a custom registry drive |
| Remove-PSDrive | Removes the custom drive after use |
| Set-Location | Navigates the registry like a file system |
| Get-ItemProperty | Reads values from a registry key |
| Get-ChildItem | Lists contents of the custom PSDrive |
| Out-File -Append | Builds a multi-section report file |
| Tee-Object | Outputs to screen and file simultaneously |
| -Confirm flag | Safety confirmation before destructive actions |

## Key cmdlets used
- `Get-PSProvider` — lists available PowerShell data providers
- `Get-PSDrive` — lists all mounted PowerShell drives
- `New-PSDrive` — creates a custom mapped drive
- `Remove-PSDrive` — removes a mapped drive
- `Set-Location` — navigates between providers and drives
- `Get-ItemProperty` — reads registry key values
- `Get-ChildItem` — lists items in current location

## Registry location explored
HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion
Properties retrieved:
- `ProductName` — Windows edition name
- `CurrentVersion` — NT version number
- `CurrentBuild` — Current build number
- `RegisteredOwner` — Registered system owner

## Custom PSDrive created
```powershell
New-PSDrive -Name "CFS_PSDrive" -PSProvider "Registry" -Root "HKLM:\SOFTWARE\Microsoft" -Confirm
```

## Safety design decision
This script requires user confirmation (`-Confirm`) before creating and removing the custom PSDrive. Since these operations interact directly with the Windows Registry, requiring explicit approval ensures the script is never run accidentally in an automated context without operator awareness.

## Sample output file structure
=== Contoso Federal Solutions | Registry Drive | 04/20/2026 13:48:38 ===
=== PSProviders ===

Name                 Capabilities                                                                 Drives
----                 ------------                                                                 ------
Registry             ShouldProcess                                                                {HKLM, HKCU, CFS_PSDrive}
Alias                ShouldProcess                                                                {Alias}
Environment          ShouldProcess                                                                {Env}
FileSystem           Filter, ShouldProcess, Credentials                                           {C, E, Temp, A…}
Function             ShouldProcess                                                                {Function}
Variable             ShouldProcess                                                                {Variable}
Certificate          ShouldProcess                                                                {Cert}
WSMan                Credentials                                                                  {WSMan}

=== PS Drives ===

Name           Used (GB)     Free (GB) Provider      Root                                                                                                     CurrentLocation
----           ---------     --------- --------      ----                                                                                                     ---------------
A                                      FileSystem    A:\                                                                                                                     
Alias                                  Alias                                                                                                                                 
C                  42.35         84.12 FileSystem    C:\                                                                                                       ClassFiles-EWI
Cert                                   Certificate   \                                                                                                                       
CFS_PSDri…                             Registry      HKEY_LOCAL_MACHINE\SOFTWARE\Micros…                                                                                     
D                   0.30          0.00 FileSystem    D:\                                                                                                                     
E                   0.09        126.90 FileSystem    E:\                                                                                                                     
Env                                    Environment                                                                                                                           
Function                               Function                                                                                                                              
HKCU                                   Registry      HKEY_CURRENT_USER                                                                                                       
HKLM                                   Registry      HKEY_LOCAL_MACHINE                                                          SOFTWARE\Microsoft\Windows NT\CurrentVersion
Temp               42.35         84.12 FileSystem    C:\Users\Administrator.ADATUM\AppD…                                                                                     
Variable                               Variable                                                                                                                              
WSMan                                  WSMan                                                                                                                                 

=== Registry Values ===

ProductName           CurrentVersion CurrentBuild RegisteredOwner
-----------           -------------- ------------ ---------------
Windows 10 Enterprise 6.3            19043        Student

=== CFS_PSDrive Contents ===

    Hive: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion

Name                           Property
----                           --------
Accessibility                  
AdaptiveDisplayBrightness      
AeDebug                        UserDebuggerHotKey : 0
AppCompatFlags                 MirrorCompatBinaryExtension : C:\WINDOWS\System32\MirrorDrvCompat.dll
                               AmiHiveOwnerCorrect         : 1
                               AmiHivePermissionsCorrect   : 1
                               PatchDbUpdateTickCount      : 17885906
ASR                            OfflineDriverInjectionExtension : drvstore.dll,DriverStoreOfflineAddDriverPackageW

## What I learned
- How PSProviders make different data stores look like a file system
- The difference between a PSProvider and a PSDrive
- How to navigate the Windows Registry using Set-Location
- How Get-ItemProperty reads registry key values
- Why absolute file paths are needed when navigating non-filesystem providers
- How -Confirm adds a safety layer to destructive operations
- How Out-File -Append builds multi-section reports from different data sources