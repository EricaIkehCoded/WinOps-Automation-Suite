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