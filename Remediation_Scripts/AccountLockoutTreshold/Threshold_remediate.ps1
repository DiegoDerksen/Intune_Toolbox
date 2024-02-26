<#
    .SYNOPSIS
       If not detected at 10 or 15 attempts, remediate to 10 and 15.

    .NOTES
        Author: Diégo Derksen
        linkedIn: www.linkedin.com/in/diego-derksen
#>
    # Set the lockout threshold to 10
net accounts /lockoutthreshold:10
net accounts /lockoutduration:15
net accounts /lockoutwindow:15

Write-Host "Waardes gewijzigd"
Exit 0
