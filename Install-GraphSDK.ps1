## Powershell Graph SDK tillater kommunikasjon med MS Graph via Powershell
# Modulen består av en hovedmodul og en rekke undermoduler. Det er mulig å bare alt eller kun spesifikke moduler. 
# Graph SDK cmdlets snakker med Graph via en app-registrering i AAD + sertifikat. 

# Manual: https://learn.microsoft.com/en-us/powershell/microsoftgraph/installation?view=graph-powershell-1.0
# Opprette selvsignert sertifikat for eget bruk:
$selfsignedCertCN = "CN=kg-tomrune.kgkompetanse.onmicrosoft.com"
$selfsignedcert = New-SelfSignedCertificate -Subject $selfsignedCertCN -CertStoreLocation "Cert:\CurrentUser\My" -KeyExportPolicy Exportable -KeySpec Signature -KeyLength 2048 -KeyAlgorithm RSA -HashAlgorithm SHA256
Export-Certificate -Cert $selfsignedcert -FilePath "$env:USERPROFILE\SelfSigned.cer"
$selfsignedcert | Format-List Thumbprint,Subject,NotAfter

# Oppdater PowerShellGet
Install-Module PowerShellGet -Force

# Installer modulpakke (38 moduker) for 
#   alle brukere
Install-Module Microsoft.Graph -Scope AllUsers

#   kun for gjeldende bruker
Install-Module Microsoft.Graph -Scope CurrentUser

# Om du ikke vil ha samtlige moduler kan du installere kun de aktuelle
# Du vil alltid installere autentiseringsmodulen:
Install-Module Microsoft.Graph.Authentication
# + modul for å jobbe med brukere
Install-Module Microsoft.Graph.Users
# + modul for noe som skal jobbes med, her modul for kun Teams-operasjoner:
Install-Module Microsoft.Graph.Teams
