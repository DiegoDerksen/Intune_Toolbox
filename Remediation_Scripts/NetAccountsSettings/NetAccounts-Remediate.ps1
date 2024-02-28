<#
    .SYNOPSIS
        Sets Lockout threshold to 10, reset lockout counter to 15 minutes and lockout duration to 15 minutes.
        Best practices from Microsoft for Secure Score.

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

if ($lockoutThreshold -ne $threshold -or $resetLockoutCounter -ne $resetLockoutCounterAfter -or $lockoutDurationValue -ne $lockoutDuration) {
    (Get-Content secpol.cfg).Replace("LockoutBadCount = $lockoutThreshold", "LockoutBadCount = $threshold").Replace("ResetLockoutCount = $resetLockoutCounter", "ResetLockoutCount = $resetLockoutCounterAfter").Replace("LockoutDuration = $lockoutDurationValue", "LockoutDuration = $lockoutDuration") | Set-Content secpol.cfg
    secedit /configure /db secedit.sdb /cfg secpol.cfg /areas SECURITYPOLICY
    Remove-Item secpol.cfg
    Remove-Item C:\Windows\security\logs\scesrv.log
    Write-Host "Waardes zijn aangepast"
    exit 0
} else {
    Remove-Item secpol.cfg
    Write-Host "Waardes zijn niet aangepast"
    exit 1
}
