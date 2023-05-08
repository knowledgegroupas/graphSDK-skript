## Oppretter tag for hver rad i CSV-fil
# Krever API application permission TeamworkTag.ReadWrite.All
# For Get-MgUser kreves minst delegated User.ReadBasic.All
# For New-MgTeamTag kreves minst delegated TeamworkTag.ReadWrite og at brukeren er admin-konto

# Skriptet krever at man angir en CSV-fil og banen til denne
[CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$CSVfil,

        [Parameter()]
        [string]$Skilletegn = ","

    )

## Helsesjekk før vi fortsetter
# Kontroller om vi er tilkoblet Microsoft Graph
if((Get-MgContext) -eq $null) {Write-Error "Ikke tilkoblet Graph!"; break}
# Kontroller at CSV-filen finnes
if(!(Test-Path $CSVfil)) {
    $skript = $MyInvocation.MyCommand
    Write-Error "Du må angi en gyldig bane til CSV-fil. Format: $skript -CSVFil <bane til csvfil>.csv"
    break
}

## Alt er vel så vi går i gang! 
# Vis fremdrift
Write-Progress -Activity "Opprett Teams-tagger" -Status "Leser CSV-fil" -Id 1 -PercentComplete 5
# Les inn verdier fra CSV-fil
$tagStrukturCSV = Import-Csv -Path $CSVfil -Delimiter $Skilletegn

# Vis fremdrift for tagopprettelse
$fremdrift = 1
Write-Progress -Activity "Opprett Teams-tagger" -Status "Begynner opprettelse av tagger" -Id 1 -PercentComplete 10
Write-Progress -Activity "Legger til tagger" -Status "Oppretter tag" -Id 2 -ParentId 1 -PercentComplete 0

foreach($tagiCSV in $tagStrukturCSV) {
    Write-Progress -Activity "Legger til tagger" -Status "Oppretter $tagiCSV.tagNavn i $tagiCSV.teamID" -Id 2 -ParentId 1 -PercentComplete ($fremdrift/$tagStrukturCSV.Count*100)
    # Opprett tag
    # Krav: GruppeID (teamID), Tagnavn, tagbeskrivelse og MINST ETT MEDLEM (som også er medlem av gruppen)
    New-MgTeamTag -TeamId $tagiCSV.teamID -DisplayName $tagiCSV.tagNavn -Description $tagiCSV.tagBeskrivelse -Members @{"userID"=(Get-MgUser -UserID $tagiCSV.tagMedlem).Id}
    
    # Fremdriftsoppdatering
    $fremdrift++
}
# Avslutt fremdriftsindikatorer
Write-Progress -Activity "Opprett Teams-tagger" -Status "Oppretter tag" -Id 2 -ParentId 1 -Completed
Write-Progress -Activity "Opprett Teams-tagger" -Id 1 -Completed
