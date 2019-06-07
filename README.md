# azure_get_cost_powershell

- [azure_get_cost_powershell](#azure_get_cost_powershell)
- [準備](#準備)
- [実行](#実行)
- [出力例](#出力例)
- [その他](#その他)

AzureのREST APIで、
Azureの使用料金(税抜)を取得するサンプルコード。

[Azureポータル](https://portal.azure.com/)の、
[サブスクリプション] - [(サブスクリプション選択)] - [コスト分析]
で表示されるコストを取得する。

[heiwa4126/azure_get_cost: Azure REST APIの例。サブスクリプションの今月の使用料金を得る例。](https://github.com/heiwa4126/azure_get_cost)
をPowerShell 5(PSVersion 5.1.14409.1018)で書き直したもの。


# 準備

(TODO)

[準備](https://github.com/heiwa4126/azure_get_cost#%E6%BA%96%E5%82%99)
を参照。

WindowsでPowershellだけでどうやるかを書く。


# 実行

```
powershell .\get_token.py test6.json > b1.json
```
で1時間使えるtokenを得る。(`b1`は例)

```
powershell .\get_cost.py b1.json
```
でcostを得る


# 出力例

(これはPowershellのdump.
FIXIT)
```
(略)
    "rows":  [
                  "28.373392245332916 20190601 JPY",
                  "28.371105779590106 20190602 JPY",
                  "28.3733097762607 20190603 JPY",
                  "28.373392228217451 20190604 JPY",
                  "23.644494620689496 20190605 JPY"
              ]
}
```
rowsの上から
「2019/6/1のコストは28.373392245332916円(税抜)」
のようなのがとれる。

# その他

(TODO)

だいたい
[その他](https://github.com/heiwa4126/azure_get_cost#%E3%81%9D%E3%81%AE%E4%BB%96)
に同じ