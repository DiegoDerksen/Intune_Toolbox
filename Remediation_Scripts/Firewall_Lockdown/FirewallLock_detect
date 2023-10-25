<#
    .SYNOPSIS
        Detect whether Enabling Firewall is allowed for local admins

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

$expectedValue = 1
$success = $true

foreach ($path in $registryPaths) {
    if (Test-Path $path) {
        $value = (Get-ItemProperty -Path $path -Name "EnableFirewall").EnableFirewall
        if ($value -ne $expectedValue) {
            $success = $false
            break
        }
    } else {
        $success = $false
        break
    }
}

if ($success) {
    Write-host "Registry keys OK."
    Exit 0   # Exit with code 0 for success
} else {
    Write-warning "Registry keys not OK"
    Exit 1 # Exit with code 1 for failure
}
