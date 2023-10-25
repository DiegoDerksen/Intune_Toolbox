<#
    .SYNOPSIS
        If the reg key is not set, set it with value "2". Value of "2" = without UEFI lock vlue of "1" is with UEFI lock.

    .NOTES
        Author: Diégo Derksen
        linkedIn: www.linkedin.com/in/diego-derksen
#>

$RegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$RegistryName = "RunAsPPL"
$DesiredValue = 2

# Check if the registry key exists and contains the desired value
if (Test-Path -Path $RegistryPath) {
    $RegistryValue = (Get-ItemProperty -Path $RegistryPath).$RegistryName
    if ($RegistryValue -ne $DesiredValue) {
        # Set the registry key to the desired value
        Set-ItemProperty -Path $RegistryPath -Name $RegistryName -Value $DesiredValue
        Write-Host "Registry key '$RegistryPath\$RegistryName' has been remediated."
    }
} else {
    # Create the registry key with the desired value
    New-ItemProperty -Path $RegistryPath -Name $RegistryName -Value $DesiredValue -PropertyType DWORD
    Write-Host "Registry key '$RegistryPath\$RegistryName' has been created and set to the desired value."
}

# Exit with a success code
exit 0