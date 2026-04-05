# Creates the 9 phase folders for the WinOps Automation Suite project
# Uses an array and foreach loop to build all folders in one shot
# Author: Erica Ikeh | MSSA Portfolio Project

$folders = @(
    "01_Local_Admin",
    "02_Pipeline_Tools",
    "03_PSDrives",
    "04_WMI_CIM",
    "05_Scripting",
    "06_Remoting",
    "07_Azure_Management",
    "08_M365_Management",
    "09_Jobs_Scheduling"
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Name $folder
}

#Creating a Single folder
New-Item -ItemType Directory -Name "_Notes"

#Creating a file to save the code in
New-Item -ItemType File -Path "_Notes/folder-structure-snippet.ps1"
