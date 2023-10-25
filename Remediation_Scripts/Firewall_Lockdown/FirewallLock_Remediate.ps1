<#
    .SYNOPSIS
        Remediate so local admins cannot change the firewall enable/disable button

    .NOTES
        Author: Diégo Derksen
        linkedIn: www.linkedin.com/in/diego-derksen
#>

$registryPaths = @(
    'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile',
    'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile',
    'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile',
    'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile'
)

# Create registry keys if they don't exist
foreach ($path in $registryPaths) {
    if (-not (Test-Path $path)) {
        New-Item -Path $path -Force
        if ($?) {
            Write-Host "Created registry key: $path"
        } else {
            Write-Host "Failed to create registry key: $path"
            exit 1  # Exit with code 1 to indicate failure
        }
    }
}

# Set the EnableFirewall value to 1 for all profiles
foreach ($path in $registryPaths) {
    Set-ItemProperty -Path $path -Name "EnableFirewall" -Value 1
    if ($?) {
        Write-Host "Set registry property for $path"
    } else {
        Write-Host "Failed to set registry property for $path"
        exit 1  # Exit with code 2 to indicate failure
    }
}

# If the script reaches this point, everything succeeded
exit 0  # Exit with code 0 to indicate success
