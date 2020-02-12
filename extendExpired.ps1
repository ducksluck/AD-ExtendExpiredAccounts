#
# This script will take a list of users .csv (user name in first column, new expiration date in second column mm/dd/yyyy),
#  and update the account expiration date.
#
#############################################################################################################################
#
# Disabled accounts will have the expiration date update, HOWEVER the account remains disabled.
#
# Program catches errors for 'contacts' and displays
#
########################################################################################################################
#
# In order to run:
#
#   1) login to a Domain Controller which the list of users reside. 
#
#   2) Run powershell ISE and paste contents of extendExpired.ps1
##################################################################################################################





#down voteaccept
 
Import-Module ActiveDirectory
$userlist = Import-Csv ".\expired.csv" -Header Name,Date

foreach ($line in $userlist) {  

    try { 
      Set-ADAccountExpiration -Identity $line.Name -Date $line.Date 
      $line
    }
    catch { $line.Name + " " + $line.Date  | Out-File '.\expiredErrors.txt' -Append }
}

 