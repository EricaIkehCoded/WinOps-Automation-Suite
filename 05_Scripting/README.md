# Phase 5 — Scripting & Logic ✅

## Scripting`New-UserOnboardingReport.ps1`

## Scenario
As a Junior Systems Administrator at Contoso Federal Solutions,
I was tasked with automating the employee onboarding process.
HR provided a list of new hires and needed personalized onboarding
reports generated for each person — including building assignments,
equipment packages, and IT ticket numbers — without manual effort.

## What it does
- Stores new hire data in an array of hash tables
- Uses a foreach loop to process each employee individually
- Assigns building location based on department using if/elseif/else:
- IT → Building A
- HR → Building B
- Finance → Building C
- All others → Building D
- Assigns equipment package based on department:
- IT → Laptop, Docking Station, Security Badge, Admin Access
- HR → Laptop, Security Badge, HR System Access
- Finance → Laptop, Security Badge, Finance System Access
- All others → Laptop, Security Badge
- Generates a unique IT ticket number for each employee
- Exports an individual onboarding report per employee
- Exports a master summary report for all new hires

## Skills demonstrated
| Skill | How it's used |
|---|---|
| Arrays | Stores the full list of new hires |
| Hash tables | Stores each employee's properties |
| Foreach loop | Processes one employee at a time |
| If/ElseIf/Else | Assigns building and equipment by department |
| String formatting | Builds personalized messages and report content |
| Get-Random | Generates unique IT ticket numbers |
| Dynamic file naming | Creates individual report file per employee |
| PSCustomObject | Structures master summary data as clean objects |
| ForEach-Object | Pipeline version used for master summary generation |
| Out-File -Append | Builds multi-line individual reports |
| Format-Table | Formats master summary as a readable table |
| Tee-Object | Displays master summary to screen and file |

## Key concepts used

### Array of hash tables
```powershell
$NewUsers = @(
@{
FirstName  = "Abby"
LastName   = "Andrews"
Department = "IT"
JobTitle   = "IT Analyst"
StartDate  = $TodaysDate
},
@{ ... }
)
```

### Foreach with if/elseif/else
```powershell
ForEach ($NewUser in $NewUsers) {
    if ($NewUser.Department -eq "IT") {
        $Building = "Building A"; $EquipmentPackage = "Laptop, Docking Station, Security Badge, Admin Access"
    } elseif ($NewUser.Department -eq "HR") {
        $Building = "Building B"; $EquipmentPackage = "Laptop, Security Badge, HR System Access"
    } elseif ($NewUser.Department -eq "Finance") { 
        $Building = "Building C"; $EquipmentPackage = "Laptop, Security Badge, Finance System Access" 
    } else {
        $Building = "Building D"; $EquipmentPackage = "Laptop, Security Badge"
    }
}
```

### Master summary using PSCustomObject
```powershell
$NewUsers | ForEach-Object {
    [PSCustomObject]@{
        Name = "$($_.FirstName) $($_.LastName)"
        Department = $_.Department
        StartDate = $_.StartDate
    }
}  | Format-Table | Tee-Object $MasterReportPath
```

## Output files
- `Onboarding_<LastName>_<FirstName>_<Date>.txt` — one per employee
- `OnboardingSummary_<Date>.txt` — master summary of all new hires

## Sample individual report

=== Contoso Federal Solutions | Onboarding Report ===
Name : Abby Andrews
Job Title : IT Analyst
Department : IT
Start Date : 04-23-2026
Building : Building A
Equipment: Laptop, Docking Station, Security Badge, Admin Access
IT Ticket : 32162

## Sample master summary

Name          Department      StartDate
----          ----------      ---------
Abby Andrews  IT              04-23-2026
Brendan Barns HR              04-23-2026
Cody Clark    Finance         04-21-2026
Darlene Davis Commnunications 04-19-2026

## What I learned
- The difference between arrays and hash tables and when to use each
- How to store structured records as an array of hash tables
- How foreach loops process one object at a time
- How if/elseif/else logic makes decisions per iteration
- How PSCustomObject creates clean objects for table display
- The difference between foreach statement and ForEach-Object
- How Get-Random generates unique values per loop iteration
- How to build multi-line reports using Out-File -Append
- How to generate both individual and summary reports from the same data source
