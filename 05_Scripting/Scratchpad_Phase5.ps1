Phase 5 Requirements Spec
New-UserOnboardingReport.ps1

🎯 Your mission: Write a script that processes a list of new hires and generates personalized onboarding reports using arrays, 
hash tables, loops, and conditional logic.

What the script must do

Display a header — company name and timestamp
Create an array of hash tables containing at least 4 new hires with these properties:

FirstName
LastName
Department
JobTitle
StartDate


Use a foreach loop to process each new hire and:

Display a personalized welcome message
Assign a building location based on department using if/elseif/else:

IT → Building A
HR → Building B
Finance → Building C
All others → Building D


Assign an equipment package based on department:

IT → Laptop, Docking Station, Security Badge, Admin Access
HR → Laptop, Security Badge, HR System Access
Finance → Laptop, Security Badge, Finance System Access
All others → Laptop, Security Badge




Generate an individual report for each new hire containing:

Full name and job title
Department and start date
Assigned building
Equipment package
IT ticket number (generate a random number using Get-Random)


Export each individual report to a separate file named:
Onboarding_<LastName>_<FirstName>_<Date>.txt
Generate a master summary report showing all new hires in a table format exported to:
OnboardingSummary_<Date>.txt


Constraints

Must use an array to store new hires
Must use hash tables for each employee record
Must use a foreach loop
Must use if/elseif/else for department logic
Must use string formatting to build personalized messages
Must use Get-Random for ticket number generation
Individual reports must be separate files per person

#Key Concepts to Explore


# Hash table syntax
$person = @{
        FirstName = "John"
        LastName  = "Smith"
}

# Accessing hash table values
$person.FirstName
$person["FirstName"]

# Array of hash tables
$people = @(
     @{ FirstName = "John"; LastName = "Smith" },
     @{ FirstName = "Jane"; LastName = "Doe" }
)

# Foreach loop
foreach ($person in $people) {
    Write-Host $person.FirstName
}

# If/ElseIf/Else
if ($person.Department -eq "IT") {
    $building = "Building A"
} elseif ($person.Department -eq "HR") {
    $building = "Building B"
} else {
    $building = "Building D"
}

#Start of scratchpad

Get-help about_Arrays -ShowWindow

$Date = Get-Date -format "MM-dd-yyyy"

#Get-Help Get-Date -Online
<#
$NewUsers = @{
    FirstName = "Abby", "Brendan", "Cody", "Darlene"
    LastName = "Andrews", "Barns", "Clark", "Davis"
    Department = "IT", "HR", "Finance", "Communications"
    JobTitle = "IT Analyst", "HR Analyst", "Finance Analyst", "Communications Analyst"
    StartDate = $Date, $Date, "04-21-2026", "04-19-2026"
}
#>

$NewUsers = @(
     @{ FirstName = "Abby"; LastName = "Andrews"; Department = "IT"; JobTitle = "IT Analyst"; StartDate = $Date},
     @{ FirstName = "Brendan"; LastName = "Barns"; Department = "HR"; JobTitle = "HR Analyst"; StartDate = $Date},
     @{ FirstName = "Cody"; LastName = "Clark"; Department = "Finance"; JobTitle = "Finance Analyst"; StartDate = "04-21-2026"},
     @{ FirstName = "Darlene"; LastName = "Davis"; Department = "Commnunications"; JobTitle = "Communications Analyst"; StartDate = $Date}
)

$NewUsers

$NewUsers.FirstName
$NewUsers.LastName
$NewUsers.Department
$NewUsers.JobTitle
$NewUsers.StartDate

$NewUsers["FirstName"]

#Need an Array of HashTables

$Date = Get-Date -format "MM-dd-yyyy"

$NewUsers = @(
     @{ 
        FirstName = "Abby" 
        LastName = "Andrews" 
        Department = "IT" 
        JobTitle = "IT Analyst" 
        StartDate = $Date
    },
     @{ 
        FirstName = "Brendan" 
        LastName = "Barns" 
        Department = "HR" 
        JobTitle = "HR Analyst"
        StartDate = $Date
    },
     @{ 
        FirstName = "Cody" 
        LastName = "Clark" 
        Department = "Finance" 
        JobTitle = "Finance Analyst" 
        StartDate = "04-21-2026"
    }
     @{ 
        FirstName = "Darlene"
        LastName = "Davis"
        Department = "Commnunications"
        JobTitle = "Communications Analyst"
        StartDate = "04-19-2026"
     }
)



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

    $TicketNumber = Get-Random -Minimum 10000 -Maximum 99999

    Write-Host "Welcome $($NewUser.FirstName)! You are assigned to $($Building) and your equipment package includes: $($EquipmentPackage). Your ticket number is: $($TicketNumber)."

    $ReportPath = ".Onboarding_$($NewUser.LastName)_$($NewUser.FirstName)_$FileDate.txt"

    "=== Contoso Federal Solutions | Onboarding Report ===" | Out-File $ReportPath
    "Name : $($NewUser.FirstName) $($NewUser.LastName)" | Out-File $ReportPath -Append
    "Job Title : $($NewUser.JobTitle)" | Out-File $ReportPath -Append
    "Department : $($NewUser.Department)" | Out-File $ReportPath -Append
    "Start Date : $($NewUser.StartDate)" | Out-File $ReportPath -Append
    "Building : $Building" | Out-File $ReportPath -Append
    "Equipment: $EquipmentPackage" | Out-File $ReportPath -Append
    "IT Ticket : $TicketNumber" | Out-File $ReportPath -Append


}
<#
IT → Laptop, Docking Station, Security Badge, Admin Access
HR → Laptop, Security Badge, HR System Access
Finance → Laptop, Security Badge, Finance System Access
All others → Laptop, Security Badge
#>

#Generate Ticket Numbder
Get-Help Get-Random -Online
Get-Random | Get-Member | Out-GridView
Get-Random -Minimum 10000 -Maximum 99999
 
#Master Summary

Get-help ForEach-Object -Online
Get-Help PSCustomObject 
Get-Help System.Management.Automation.PSCustomObject
Get-Help about_PSCustomObject -ShowWindow

$NewUsers | ForEach-Object {
    [PSCustomObject]@{
        Name = "$($_.FirstName) $($_.LastName)"
        Department = $_.Department
        StartDate = $_.StartDate
    }
}  | Format-Table