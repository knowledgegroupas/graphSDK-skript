# Test-team 1
$params = @{
    "Template@odata.bind" = "https://graph.microsoft.com/v1.0/teamsTemplates('educationClass')"
    DisplayName = "Test-team 1"
    Description = "Test-team 1"
}
New-MgTeam -BodyParameter $params

# Test-team 2
$params = @{
    "Template@odata.bind" = "https://graph.microsoft.com/v1.0/teamsTemplates('educationClass')"
    DisplayName = "Test-team 2"
    Description = "Test-team 2"
}
New-MgTeam -BodyParameter $params


