<#
    .SYNOPSIS
        If not set at 10, change it to 10
        
    .NOTES
        Author: Diégo Derksen
        linkedIn: www.linkedin.com/in/diego-derksen
#>
#Set lockoutthreshold to 10
try {
       net accounts /lockoutthreshold:10

       $NewNetAccounts = net accounts | select-string "lockout threshold"

    if($NewNetAccounts -like "*10*") {
        Write-Host "Threshold is gewijzigd naar 10" # Threshold has changed to 10
        exit 0
    }
    else {
        Write-Host "Threshold niet gewijzigd" #Treshold has not been changed
        exit 1
    }
} 
catch {
    $errMsg = $_.Exception.Message
    Write-Error $errMsg
    exit 1
}
