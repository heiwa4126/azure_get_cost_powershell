Param(
  [String]$tokenfile = '.\b1.json'
)
$ErrorActionPreference = 'Stop'

<#
# 正しいクエリの作り方。今回はAPIバージョンだけなので使わない
function makeUrl($url,$version) {
  $req = [System.UriBuilder]$url
  $param = [System.Web.HttpUtility]::ParseQueryString('')
  $param['api-version'] = $version
  $req.Query = $param.ToString()
  $req.Uri.ToString()
}
#>

function get_subscriptions_list($token) {
  $headers = @{'Authorization' = ( 'Bearer {0}' -f $token.access_token ) }
  # $url = makeUrl 'https://management.azure.com/subscriptions' '2019-05-01'
  $url = 'https://management.azure.com/subscriptions?api-version=2019-05-01'

  Invoke-RestMethod -Uri $url -Method GET -Headers $headers -ErrorAction Stop
}

<#
https://docs.microsoft.com/en-us/rest/api/cost-management/query/usagebyscope
を使って
特定サブスクリプションの、今月分のコストを日単位で得る(税抜価格)。
ちょうどAzure Portalで
[サブスクリプション]->[(サブスクリプション選択)]->[cost analysis]で
表示されるグラフのもととなるデータが得られる。
#>
function query_cost1($token, $subId) {

  $headers = @{
    'Authorization' = ('Bearer {0}' -f $token.access_token);
    'Content-type'  = 'application/json'
  }
  # $url = makeUrl ('https://management.azure.com/subscriptions/{0}/providers/Microsoft.CostManagement/query' -f $subId) '2019-01-01'
  $url = 'https://management.azure.com/subscriptions/{0}/providers/Microsoft.CostManagement/query?api-version=2019-01-01' -f $subId 
  $body = '{"type":"Usage","timeframe":"MonthToDate","dataset":{"granularity":"Daily","aggregation":{"totalCost":{"name":"PreTaxCost","function":"Sum"}}}}'

  Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $body -ErrorAction Stop
}

$token = Get-Content $tokenfile -Encoding UTF8 -Raw | ConvertFrom-Json
$r = get_subscriptions_list $token

$r.value | % {
  query_cost1 $token $_.subscriptionId | ConvertTo-Json
}
