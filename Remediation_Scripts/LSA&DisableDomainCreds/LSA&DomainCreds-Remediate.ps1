<#
    .SYNOPSIS
       If it is not set, enable the DisableDomainCreds to "enable" and sets LSA protection with UEFI Lock.
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

if ($Properties.$RegistryValue1 -ne $ExpectedValue1) {
    Set-ItemProperty -Path $RegistryPath -Name $RegistryValue1 -Value $ExpectedValue1
    Write-Host "Registry key $RegistryValue1 is veranderd naar de juiste waarde." # Reg key LSA PPL has changed
}
  
if ($Properties.$RegistryValue2 -ne $ExpectedValue2) {
    Set-ItemProperty -Path $RegistryPath -Name $RegistryValue2 -Value $ExpectedValue2
    Write-Host "Registry key $RegistryValue2 is veranderd naar de juiste waarde." # Reg key DisableDomainCreds has changed
}
  
if ($Properties.$RegistryValue1 -eq $ExpectedValue1 -and $Properties.$RegistryValue2 -eq $ExpectedValue2) {
    Write-Host "Beide registersleutels hebben de verwachte waarden." # Both reg keys have the right value
    exit 0  # Success
} else {
    Write-Host "Het instellen van een of beide registersleutels is mislukt." # Changing reg keys has failed
    exit 1  # Failure
}
