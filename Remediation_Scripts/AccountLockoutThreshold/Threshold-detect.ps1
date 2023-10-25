<#
    .SYNOPSIS
        Detect whether accounts lockout threshold is set at 10

    .NOTES
        Author: Diégo Derksen
        linkedIn: www.linkedin.com/in/diego-derksen
#>
#Set 'Account lockout threshold' to 1-10 invalid login attempts
try
{
    $NetAccounts = net accounts | select-string "lockout threshold" 
    if($NetAccounts -like "*Never"){
        $netaccounts_Value = "0"
    }
    else{
        $netaccounts_Value = ($NetAccounts -split ':')[-1].Trim()
    }
     
    if([int]$netaccounts_Value -ge 0 -and [int]$netaccounts_Value -le 9){
        write-host "Threshold is niet geconfigureerd of heeft niet de juiste waarde" # threshold is not configured or does not have the right value
        exit 1 #not compliant
    }
    elseif([int]$netaccounts_Value -eq 10){
        #No matching certificates, do not remediate
        Write-Host "Threshold staat op 10" # Threshold is set at 10 
        exit 0 #compliant
    }  
} 
catch{
    $errMsg = $_.Exception.Message
    Write-Error $errMsg
    exit 1
}
