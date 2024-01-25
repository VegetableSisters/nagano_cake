# ながのCAKE

## 概要
長野県にある小さな洋菓子店「ながのCAKE」の商品を通販するためのECサイト開発。

要件定義書(https://docs.google.com/document/d/e/2PACX-1vTMt9S2VG4RHmBpmQinLNYqKPF_glh_sElP4QqMXGdrYerS0nef0bo_Zd_-jtbcEdEOZbvZwH91Jo2c/pub)

## 制作背景
元々近隣住民が顧客だったが、昨年始めたInstagramから人気となり、全国から注文が来るようになった。

InstagramのDMやメールで通販の注文を受けていたが、情報管理が煩雑になってきたため、管理機能を含んだ通販サイトを開設しようと思い至った。

## バージョン
ruby 3.1.2p20
Rails 6.1.7.6
bootstrap 4.6.2

## Gem
devise
ransack
kaminari 1.2.1
enum_help

## 実装機能
- deviceを用いた管理者と顧客のログイン管理
- enum_helpを用いたステータス表示
- kaminariを用いたページネーション
- ransackを用いた検索バー
- 機能一覧表 (https://wals.s3-ap-northeast-1.amazonaws.com/curriculum/ec_site/design_documents/ecsite_functions_list.pdf)

## インストール
```
$ git clone git@github.com:VegetableSisters/nagano_cake.git
$ cd nagano_cake
$ rails db:migrate
$ rails db:seed
$ yarn install
$ bundle install
$ rails s
```
## ログイン
- 顧客　新規登録
- 管理者　Email：admin@admin PASS：adminmin

## 要件
- 要件定義書(https://docs.google.com/document/d/e/2PACX-1vTMt9S2VG4RHmBpmQinLNYqKPF_glh_sElP4QqMXGdrYerS0nef0bo_Zd_-jtbcEdEOZbvZwH91Jo2c/pub)

## 実装者
ナッツ、ケケ、ピーマン