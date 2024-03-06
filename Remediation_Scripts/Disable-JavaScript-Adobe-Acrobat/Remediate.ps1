<#
    .SYNOPSIS
        Sets the reg key to 1 or creates it if it hasn't been made yet.

    .NOTES
        Author: Diégo Derksen
        linkedIn: www.linkedin.com/in/diego-derksen
#>


$registryPath = "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown"
$registryValueName = "bDisableJavaScript"

if (Test-Path -Path $registryPath) {
    $currentValue = Get-ItemProperty -Path $registryPath -Name $registryValueName -ErrorAction SilentlyContinue

    if ($currentValue -eq $null) {
        # Value doesn't exist, create it with the desired REG_DWORD value
        New-ItemProperty -Path $registryPath -Name $registryValueName -Value 1 -PropertyType DWORD -Force
        Write-Host "Registry value created and set to 1 (enabled)."
    } elseif ($currentValue.$registryValueName -ne 1) {
        # Value exists but is not set to 1, update it
        Set-ItemProperty -Path $registryPath -Name $registryValueName -Value 1
        Write-Host "Registerwaarde bijgewerkt naar 1 (ingeschakeld)."
        Exit 0
    } else {
        Write-Host "Registerwaarde al ingesteld op 1 (ingeschakeld)."
        Exit 0
    }
} else {
    Write-Host "Registerpad niet gevonden. Controleer het pad."
    Exit 1
}
