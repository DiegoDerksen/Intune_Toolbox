$RegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$RegistryValue1 = "RunAsPPL"
$ExpectedValue1 = 1
$RegistryValue2 = "DisableDomainCreds"
$ExpectedValue2 = 1

$Properties = Get-ItemProperty -Path $RegistryPath

if ($Properties.$RegistryValue1 -eq $ExpectedValue1 -and $Properties.$RegistryValue2 -eq $ExpectedValue2) {
    Write-Host "Beide registry keys bestaan met de verwachte waarden."
    exit 0  # Success
} else {
    Write-Host "Een of beide registry keys bestaan niet of hebben niet de verwachte waarden."
    exit 1  # Failure
}