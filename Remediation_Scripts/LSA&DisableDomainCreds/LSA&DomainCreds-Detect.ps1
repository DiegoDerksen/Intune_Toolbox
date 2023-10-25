<#
    .SYNOPSIS
       Detect whether LSA protection and DisableDomainCreds are set correctly to follow Microsoft Defender secure score.
       RunAsPPL Value of "2" = without UEFI lock vlue of "1" is with UEFI lock.

    .NOTES
        Author: Diégo Derksen
        linkedIn: www.linkedin.com/in/diego-derksen
#>

$RegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$RegistryValue1 = "RunAsPPL"
$ExpectedValue1 = 1
$RegistryValue2 = "DisableDomainCreds"
$ExpectedValue2 = 1

$Properties = Get-ItemProperty -Path $RegistryPath

if ($Properties.$RegistryValue1 -eq $ExpectedValue1 -and $Properties.$RegistryValue2 -eq $ExpectedValue2) {
    Write-Host "Beide registry keys bestaan met de verwachte waarden." #Both reg keys have the right values
    exit 0  # Success
} else {
    Write-Host "Een of beide registry keys bestaan niet of hebben niet de verwachte waarden." #One or more reg keys do not exist or do not have the right value
    exit 1  # Failure
}
