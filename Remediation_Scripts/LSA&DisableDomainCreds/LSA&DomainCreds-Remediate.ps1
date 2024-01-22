$RegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$RegistryValue1 = "RunAsPPL"
$ExpectedValue1 = 1
$RegistryValue2 = "DisableDomainCreds"
$ExpectedValue2 = 1

Set-ItemProperty -Path $RegistryPath -Name $RegistryValue1 -Value $ExpectedValue1
Set-ItemProperty -Path $RegistryPath -Name $RegistryValue2 -Value $ExpectedValue2
    
Write-Host "Registry keys zijn veranderd naar de juiste waarde."
Exit 0