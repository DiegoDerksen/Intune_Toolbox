<#
    .SYNOPSIS
Create Teams firewall rules

    .NOTES
        Author: Diégo Derksen
        linkedIn: www.linkedin.com/in/diego-derksen
#>

Function Get-LoggedInUserProfile() {
# Getting user profile for Teams localdata path

    try {
    
       $loggedInUser = Gwmi -Class Win32_ComputerSystem | select username -ExpandProperty username
       $username = ($loggedInUser -split "\\")[1]

       $userProfile = Get-ChildItem (Join-Path -Path $env:SystemDrive -ChildPath 'Users') | Where-Object Name -Like "$username*" | select -First 1
       
    } catch [Exception] {
    
       Write-error "Unable to find logged in users profile folder. User is not logged on to the primary session: $_"
       Exit 1
    }

    return $userProfile
}

Function Set-TeamsFWRule($ProfileObj) {
# Setting up the inbound firewall rule
    $progPath = Join-Path -Path $ProfileObj.FullName -ChildPath "AppData\Local\Microsoft\Teams\Current\Teams.exe"

    if ((Test-Path $progPath)) {
            $ruleName = "Teams.exe"
            New-NetFirewallRule -DisplayName "$ruleName" -Direction Inbound -Profile Domain -Program $progPath -Action Allow -Protocol Any
            New-NetFirewallRule -DisplayName "$ruleName" -Direction Inbound -Profile Public,Private -Program $progPath -Action Block -Protocol Any

        }             
            
        }
Try {
    #Combining the two function in order to set the Teams Firewall rule for the logged in user
    Set-TeamsFWRule -ProfileObj (Get-LoggedInUserProfile)
    Write-Host "Teams rules OK."
Exit 0

} catch [Exception] {
    
 # Rules not made
    Write-Error "Teams Rules not OK"
   Exit 1
}
