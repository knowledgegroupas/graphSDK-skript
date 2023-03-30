## Kommando for å opprette én tag
# Krever API application permission TeamworkTag.ReadWrite.All
# For få få objektID for en gitt AzureAD-bruker kreves User.Read.All

# Kontroller om vi er tilkoblet Microsoft Graph
if($mgGraphConnection -eq $null) {Write-Error "Ikke tilkoblet Graph"; break}

# Nyttige variabler
#$teamID = ""
$azUserUPN = "lise@itwebinar.no"
$tagNavn = "Vinnere"
$tagBeskrivelse = "Alle vinnere"
#$Members = @{
#        "userID" = $azUserObjectID
#}

# Få objektID for en bruker gitt UPN
$azUserObjectID = Get-MgUser -UserID $azUserUPN | Select-Object Id

## Kommando for å opprette en tag
# Krav: GruppeID (teamID), Tagnavn, tagbeskrivelse og MINST ETT MEDLEM (som også er medlem av gruppen)
New-MgTeamTag -TeamId $teamID -DisplayName $tagNavn -Description $tagBeskrivelse -Members @{"userID"=$azUserObjectID}

# List opp alle opprettede merker i teamet
$filter = "DisplayName eq" + " '" + $tagNavn + "'"
$teamTag = Get-MgTeamTag -TeamId $teamID -Filter $filter
Get-MgTeamTag -TeamId $teamID -TeamworkTagId $teamTag.Id | Format-List

# Medlemmer av tagen
Get-MgTeamTagMember -TeamId $teamID -TeamworkTagId $teamTagID
