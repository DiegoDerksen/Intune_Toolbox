<#
    .SYNOPSIS
        Detects whether the key is set at 0 or not set at all and proceeds to remediate.

    .NOTES
        Author: Diégo Derksen
        linkedIn: www.linkedin.com/in/diego-derksen
#>

$registryPath = "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown"
$registryValueName = "bDisableJavaScript"

if (Test-Path -Path $registryPath) {
    $currentValue = Get-ItemProperty -Path $registryPath -Name $registryValueName -ErrorAction SilentlyContinue

    if ($currentValue -eq $null) {
        Write-Host "Registerwaarde bestaat niet (JavaScript is waarschijnlijk ingeschakeld)."
        Exit 1
    } elseif ($currentValue.$registryValueName -eq 1) {
        Write-Host "Registerwaarde is ingesteld op 1 (JavaScript is mogelijk uitgeschakeld)."
        Exit 0
    } else {
        Write-Host "Registerwaarde bestaat, maar is niet ingesteld op 1 (JavaScript is mogelijk ingeschakeld)."
        Exit 1
    }
} else {
    Write-Host "Registerpad niet gevonden. Controleer het pad."
    Exit 0
}
