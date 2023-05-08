## Koble til Mg (Microsoft Graph), verdier fra Azure App-Registration og sertifikat: 
$azureMGAppId = ""
$tenantID = ""
$azureMGCertThumbprint = ""

# Koble til Graph API som app
$mgGraphConnection = Connect-MgGraph -ClientId $azureMGAppId -TenantId $tenantID -CertificateThumbprint $azureMGCertThumbprint

# Koble til Graph API som bruker
$mgGraphConnection = Connect-MgGraph -TenantId $tenantID -Scopes "User.ReadBasic.All","Team.ReadBasic.All","TeamworkTag.ReadWrite"

# Sjekk om tilkoblet Graph API
$mgGraphConnection # Returnerer en tekststreng om tilkoblet

# Koble fra Graph
Disconnenct-MgGraph

# Søk gjennom alle INSTALLERTE  moduler etter kommandoer knyttet til gitt tema, f.eks. Teams: 
Get-Command -Module Microsoft.Graph* *team*

## Teams Tag-funskjon er nå GA, så det er ikke lenger nødvendig å bytte til Beta endpoint
Select-MgProfile -Name "beta" # alt "v1.0" som er standard
