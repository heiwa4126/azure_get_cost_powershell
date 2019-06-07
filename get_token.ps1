Param(
  [String]$credfile = '.\test6.json'
)
$ErrorActionPreference = 'Stop'

$cred = Get-Content $credfile -Encoding UTF8 -Raw | ConvertFrom-Json

$data = @{
  grant_type    = 'client_credentials';
  client_id     = $cred.appId;
  client_secret = $cred.password;
  resource      = 'https://management.azure.com'
}

$headers = @{ 'Content-Type' = 'application/x-www-form-urlencoded' }

$url = "https://login.windows.net/{0}/oauth2/token" -f $cred.tenant

$r = Invoke-RestMethod -Uri $url -Method POST -Body $data -Headers $headers -ErrorAction Stop

$r | ConvertTo-Json -Compress 
