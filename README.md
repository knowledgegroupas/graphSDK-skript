# graphSDK-skript
Samling av skript som jobber mot GraphSDK

## Ignorerer
Lokalmappen "lokaltilpasninger" ignoreres - egnet sted for tenant-spesifikke variabler e.l.

## Skript
* _Install-GraphSDK.ps1_ - installerer nødvendige Graph-komponenter. OBS! Ikke kjør hele skriptet, men velg ut de delene som er relevant for ditt behov. [Les mer her](https://learn.microsoft.com/en-us/powershell/microsoftgraph/installation?view=graph-powershell-1.0)
* _KobleTil-GraphSDK.ps1_ - gitt AzureApp-registration + eget sertifikat, kobler seg til Graph-en. 
* _LagSelfSignedCert.ps1_ - lager et selvsignert sertifikat med varighet på 1 år i $Userprofile

### /Teams/
Denne mappen inneholder Teams-spesifikke skript og filer.
