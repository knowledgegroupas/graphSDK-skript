## Oppretter tag for hver rad i CSV-fil
# Krever API application permission TeamworkTag.ReadWrite.All
# For få få objektID for en gitt AzureAD-bruker kreves User.Read.All

# Kontroller om vi er tilkoblet Microsoft Graph
if($mgGraphConnection -eq $null) {Write-Error "Ikke tilkoblet Graph"; break}

# Vis fremdrift
Write-Progress -Activity "Opprett Teams-tagger" -Status "Leser CSV-fil" -Id 1 -PercentComplete 5
# Les inn verdier fra CSV-fil
$tagStrukturCSV = Import-Csv -Path ".\tagliste.csv" -Delimiter ","

# Vis fremdrift for tagopprettelse
$fremdrift = 1
Write-Progress -Activity "Opprett Teams-tagger" -Status "Begynner opprettelse av tagger" -Id 1 -PercentComplete 10
Write-Progress -Activity "Legger til tagger" -Status "Oppretter tag" -Id 2 -ParentId 1 -PercentComplete 0

foreach($tagiCSV in $tagStrukturCSV) {
    Write-Progress -Activity "Legger til tagger" -Status "Oppretter $tagiCSV.tagNavn i $tagiCSV.teamID" -Id 2 -ParentId 1 -PercentComplete ($fremdrift/$tagStrukturCSV.Count*100)
    # Dersom CSV-filen inneholder UPN må vi finne objektID for bruker, krever User.Read.All
    $azUserObjectID = Get-MgUser -UserID $tagiCSV.tagmedlem | Select-Object Id

    # Opprett tag (krever TeamworkTag.ReadWrite.All)
    # Krav: GruppeID (teamID), Tagnavn, tagbeskrivelse og MINST ETT MEDLEM (som også er medlem av gruppen)
    New-MgTeamTag -TeamId $tagiCSV.teamID -DisplayName $tagiCSV.tagNavn -Description $tagiCSV.tagBeskrivelse -Members @{"userID"=$azUserObjectID.Id}

    # Fremdriftsoppdatering
    $fremdrift++
}
# Avslutt fremdriftsindikatorer
Write-Progress -Activity "Opprett Teams-tagger" -Status "Oppretter tag" -Id 2 -ParentId 1 -Completed
Write-Progress -Activity "Opprett Teams-tagger" -Id 1 -Completed
