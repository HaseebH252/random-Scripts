#################################################################################################################################################################
# Purpose of this script is to get stale AD machines where last logon is over set days
#                                                 
#################################################################################################################################################################

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

# Set Days Inactive
# Days.Hours:Minutes:Seconds
$DaysInactive = "365.00:00:00"
Write-Host Setting Inactivy Days to $DaysInactive

# Set Which OU to Look in
$SearchOU = "OU=Workstations,OU=Production,DC=example,DC=com"
Write-Host Setting Search to $SearchOU
$Today = Get-Date -Format MM.dd.yy

# Get List of Inactive Machines
Search-ADAccount -AccountInactive -TimeSpan $DaysInactive -SearchBase $SearchOU -SearchScope 1 -ComputersOnly | Select-Object Name, LastLogonDate | Export-Csv "$Today\_inactivemachines.csv"

# Exit Script
exit
