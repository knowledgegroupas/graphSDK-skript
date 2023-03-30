## Koble til Mg (Microsoft Graph), verdier fra Azure App-Registration og sertifikat: 
$azureMGAppId = ""
$tenantID = ""
$azureMGCertThumbprint = ""

# Koble til Graph API
$mgGraphConnection = Connect-MgGraph -ClientId $azureMGAppId -TenantId $tenantID -CertificateThumbprint $azureMGCertThumbprint
$mgGraphConnection # Returnerer en tekststreng om tilkoblet

# Søk gjennom alle INSTALLERTE  moduler etter kommandoer knyttet til gitt tema, f.eks. Teams: 
Get-Command -Module Microsoft.Graph* *team*

## Teams Tag-funskjon er nå GA, så det er ikke lenger nødvendig å bytte til Beta endpoint
Select-MgProfile -Name "beta" # alt "v1.0" som er standard
