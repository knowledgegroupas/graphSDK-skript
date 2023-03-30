## Koble til Mg (Microsoft Graph): 
$azureMGAppId = ""
$tenantID = ""
$azureMGCertThumbprint = ""

$mgGraphConnection = Connect-MgGraph -ClientId $azureMGAppId -TenantId $tenantID -CertificateThumbprint $azureMGCertThumbprint

# Søk gjennom alle INSTALLERTE  moduler etter kommandoer knyttet til gitt tema, f.eks. Teams: 
Get-Command -Module Microsoft.Graph* *team*

# Teams Tag-funskjon er i skrivende stund tilgjengelig via Beta endpoint - dette bytter vi til med:
Select-MgProfile -Name "beta" # alt "v1.0" som er standard
