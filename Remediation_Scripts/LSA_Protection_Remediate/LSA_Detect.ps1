<#
    .SYNOPSIS
        Detect whether LSA protection is turned on in the registry. With value "2". Value of "2" = without UEFI lock vlue of "1" is with UEFI lock.

    .NOTES
        Author: Diégo Derksen
        linkedIn: www.linkedin.com/in/diego-derksen
#>

$RegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$RegistryName = "RunAsPPL"
$ExpectedValue = 2

# Check if the registry key exists and contains the expected value
if (Test-Path -Path $RegistryPath) {
    $RegistryValue = (Get-ItemProperty -Path $RegistryPath).$RegistryName
    if ($RegistryValue -eq $ExpectedValue) {
        Write-Host "Registry key '$RegistryPath\$RegistryName' exists with the expected value."
        exit 0  # Detection succeeded
    }
}

Write-Host "Registry key '$RegistryPath\$RegistryName' does not exist or does not have the expected value."
exit 1  # Detection failed
