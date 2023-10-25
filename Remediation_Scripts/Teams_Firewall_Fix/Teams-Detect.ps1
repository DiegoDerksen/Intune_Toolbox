<#
    .SYNOPSIS
        Detect whether the Microsoft Teams firewall policies have been created

    .NOTES
        Author: Diégo Derksen
        linkedIn: www.linkedin.com/in/diego-derksen
#>

# Define the name of the firewall rule
$firewallRuleName = "teams.exe"

# Get the firewall rule
$firewallRule = Get-NetFirewallRule -DisplayName $firewallRuleName -ErrorAction SilentlyContinue

# Check if the firewall rule exists
if ($null -ne $firewallRule) {
    # Firewall rule exists
    Write-Host "Teams Rules OK"
    exit 0
} else {
    # Firewall rule does not exist
    Write-Warning "Teams rules not OK"
    exit 1
}