<#
    .SYNOPSIS
       If not detected at 10 attempts, remediate to 10.

    .NOTES
        Author: Diégo Derksen
        linkedIn: www.linkedin.com/in/diego-derksen
#>
    # Set the lockout threshold to 10
    net accounts /lockoutthreshold:10

    Write-Host "Threshold gewijzigd naar 10"
    exit 0
