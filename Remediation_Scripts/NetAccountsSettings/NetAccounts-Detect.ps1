<#
    .SYNOPSIS
        Checks wheter Lockout threshold is set at 10, reset lockout counter is set to 15 minutes and lockout duration is set at 15 minutes.
        Best practices from Microsoft for Secure Score.

    .NOTES
        Author: Diégo Derksen
        linkedIn: www.linkedin.com/in/diego-derksen
#>

$secpol = secedit /export /cfg secpol.cfg

$lockoutThreshold = (Get-Content secpol.cfg | Select-String "LockoutBadCount").ToString().Split('=')[1].Trim()
$resetLockoutCounter = (Get-Content secpol.cfg | Select-String "ResetLockoutCount").ToString().Split('=')[1].Trim()
$lockoutDurationValue = (Get-Content secpol.cfg | Select-String "LockoutDuration").ToString().Split('=')[1].Trim()

if ($lockoutThreshold -eq "10" -and $resetLockoutCounter -eq "15" -and $lockoutDurationValue -eq "15") {
    Write-Host "Waardes staan juist"
    Remove-Item secpol.cfg
    exit 0
} else {
    Write-Host "Waardes staan niet juist"
    Remove-Item secpol.cfg
    exit 1
}
