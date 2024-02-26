<#
    .SYNOPSIS
        Detect whether accounts lockout threshold is set at 10

    .NOTES
        Author: Diégo Derksen
        linkedIn: www.linkedin.com/in/diego-derksen
#>
$threshold = 10
$resetLockoutCounterAfter = 15
$lockoutDuration = 15

$secpol = secedit /export /cfg secpol.cfg

$lockoutThreshold = (Get-Content secpol.cfg | Select-String "LockoutBadCount").ToString().Split('=')[1].Trim()
$resetLockoutCounter = (Get-Content secpol.cfg | Select-String "ResetLockoutCount").ToString().Split('=')[1].Trim()
$lockoutDurationValue = (Get-Content secpol.cfg | Select-String "LockoutDuration").ToString().Split('=')[1].Trim()

if ($lockoutThreshold -eq $threshold -and $resetLockoutCounter -eq $resetLockoutCounterAfter -and $lockoutDurationValue -eq $lockoutDuration) {
    Write-Host "Waardes staan juist"
    Remove-Item secpol.cfg
    exit 0
} else {
    Write-Host "Waardes staan niet juist"
    Remove-Item secpol.cfg
    exit 1
}
