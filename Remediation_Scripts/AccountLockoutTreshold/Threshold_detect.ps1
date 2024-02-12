<#
    .SYNOPSIS
        Detect whether accounts lockout threshold is set at 10

    .NOTES
        Author: Diégo Derksen
        linkedIn: www.linkedin.com/in/diego-derksen
#>
try {
    # Get the current lockout threshold
    $CurrentNetAccounts = net accounts | select-string "lockout threshold"

    # Check if the lockout threshold is 10
    if($CurrentNetAccounts -like "*10*") {
        Write-Host "Threshold staat op 10"
        exit 0
    }
    else {
        Write-Host "Threshold staat niet op 10"
        exit 1
    }
}
catch {
    Write-Host "An error occurred: $_"
    exit 1
}
