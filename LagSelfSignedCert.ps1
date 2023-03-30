# Opprette selvsignert sertifikat for eget bruk:
$selfsignedCertCN = "CN=mittnavn.tenant.onmicrosoft.com"
$selfsignedcert = New-SelfSignedCertificate -Subject $selfsignedCertCN -CertStoreLocation "Cert:\CurrentUser\My" -KeyExportPolicy Exportable -KeySpec Signature -KeyLength 2048 -KeyAlgorithm RSA -HashAlgorithm SHA256
Export-Certificate -Cert $selfsignedcert -FilePath "$env:USERPROFILE\SelfSigned.cer"
$selfsignedcert | Format-List Thumbprint,Subject,NotAfter
