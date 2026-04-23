<#
.SYNOPSIS
    Generates personalized onboarding reports for new Contoso Federal
    Solutions employees using arrays, hash tables, and scripting logic.

.DESCRIPTION
    This script automates the employee onboarding process for Contoso Federal Solutions. 
    It stores new hire information in an array of  hash tables and uses a foreach loop
    to process each employee individually.

    For each new hire the script uses if/elseif/else logic to assign a building location and 
    equipment package based on department. A unique IT ticket number is generated for each employee
    using Get-Random. An individual onboarding report is exported for each person and a master summary 
    report is generated for all new hires.
                                    
    Built as part of the WinOps Automation Suite portfolio project.
                    
.EXAMPLE
    .\New-UserOnboardingReport.ps1
                            
.NOTES
    Author: EricaIkehCoded
    Date: 2026-04-21
    Course: AZ-040T00 (Independent Project)
    Phase: 4 - WMI & CMI Query
#>

#Variables

$TodaysDate = Get-Date -format "MM-dd-yyyy"
$FileDate = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$TicketNumber = Get-Random -Minimum 10000 -Maximum 99999
$IndividualReportPath = ".Onboarding_$($NewUser.LastName)_$($NewUser.FirstName)_$FileDate.txt"
$MasterReportPath = ".\OnboardingSummary_$FileDate.txt"


#Adding New Users

$NewUsers = @(
     @{ 
        FirstName = "Abby" 
        LastName = "Andrews" 
        Department = "IT" 
        JobTitle = "IT Analyst" 
        StartDate = $TodaysDate
    },
     @{ 
        FirstName = "Brendan" 
        LastName = "Barns" 
        Department = "HR" 
        JobTitle = "HR Analyst"
        StartDate = $TodaysDate
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

#Welcome Message and Individual Report Generation

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

   $IndividualReportPath = ".Onboarding_$($NewUser.LastName)_$($NewUser.FirstName)_$FileDate.txt"


    "=== Contoso Federal Solutions | Onboarding Report ===" | Out-File $IndividualReportPath
    "Name : $($NewUser.FirstName) $($NewUser.LastName)" | Out-File $IndividualReportPath -Append
    "Job Title : $($NewUser.JobTitle)" | Out-File $IndividualReportPath -Append
    "Department : $($NewUser.Department)" | Out-File $IndividualReportPath -Append
    "Start Date : $($NewUser.StartDate)" | Out-File $IndividualReportPath -Append
    "Building : $Building" | Out-File $IndividualReportPath -Append
    "Equipment: $EquipmentPackage" | Out-File $IndividualReportPath -Append
    "IT Ticket : $TicketNumber" | Out-File $IndividualReportPath -Append

}

#Master Report Generation

$NewUsers | ForEach-Object {
    [PSCustomObject]@{
        Name = "$($_.FirstName) $($_.LastName)"
        Department = $_.Department
        StartDate = $_.StartDate
    }
}  | Format-Table | Tee-Object $MasterReportPath