#################################################################################################################################################################
# Purpose of this script is to move stale AD machines to a differnt OU
#                                                 
#################################################################################################################################################################

#####################################################
# CSV Formatting
#####################################################

# CSV is created from Get-InactiveMachines.ps1
# 

#####################################################
# REQURIED PARAMETERS
#####################################################
# File= CSV input file

param(    
    [Parameter(Mandatory = $true, HelpMessage = "Full path to the InputFile (i.e.: C:\InputFile.csv)", Position = 1)] 
    [string]$File
)

##################################################
# MODULES REQUIRED
#
# ActiveDirectory
##################################################


if (Get-Module -ListAvailable -Name ActiveDirectory ) {
    Write-Host " "
} 
else {
    Write-Host "You do not have proper modules. Please install Active Directory module"
    exit
}


#####################################################
# SCRIPT BODY
#####################################################

# Import File
$InputFile = Import-Csv $File

# Get Todays Date and tech name
$TechName = ""
$Today = Get-Date -Format MM/dd/yy

# Description to put for each object
$Description = "Moved due to inactivity by $TechName on $Today"

# Set Path where to move to
$TargetOU = "OU=stale_workstation,OU=Workstations,OU=Production,DC=example,DC=com"

# Set description and move to 
foreach ($computer in $InputFile) {

    Set-ADComputer $computer.Name -Description $Description
    #Set-ADComputer $computer.Name -Enabled $false
   
    Move-ADObject -Identity $computer.DistinguishedName -TargetPath $TargetOU -Confirm:$false
   
    Write-Host Computer account $computer.Name has been moved successfully.

}

# Exit Script
exit
