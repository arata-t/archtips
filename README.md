<img width="556" alt="トップlogp" src="https://user-images.githubusercontent.com/76896195/120482520-2d9e9d80-c3ec-11eb-9bfc-404e7dc783a0.png">

#



Arch_Tipsは私が建築設計をしている中で感じた「あったらいいな！」を実現したものです。Web上にある建築の情報は散在しており、検索に時間がかかることが課題であると思っておりました。1つのサイトで情報をしぼって検索を行いたいという思いから、`建築設計者のための投稿・検索アプリ`を作りました。



# 🌐 URL
http://3.139.39.218/

ログイン  
メールアドレス：test@test  
パスワード：aaaaaa



# 💡 登録不要で検索・閲覧が可能

`Arch_Tipsは誰でも検索・閲覧が可能`です。トップページの投稿一覧をスクロールし気になる画像があればクリックすることで詳細が閲覧できます。検索はトプページから検索可能で、余計なページ移動は不要です。より使い込みたい場合はユーザー登録を行い投稿及び投稿へのコメントが可能です。
<img width="918" alt="トップページ" src="https://user-images.githubusercontent.com/76896195/120481965-a0f3df80-c3eb-11eb-9949-5682a3ca00fc.png">
# 💡 PDF の扱いに特化

Arch_Tipsのこだわりのポイントは以下3点です。


- PDFの投稿、プレビュー、ダウロードが可能
- 充実した検索機能
- 高い保守性 (Rspec 100example以上)

建築設計では画像データは取り扱いません。基本的にPDF で作図、資料作成を行います。そのため、`PDFの投稿、プレビュー・ダウンロードができる機能`を実装しました。

検索機能は条件を指定して検索できるように複数条件検索機能を導入しました。

比較的慎重な性格のため、テストコードを実装しながら開発を進めました。respecのmodelspec,requestspec,systemspec`計100example以上を実施して高い保守性`を確保しました。


<img width="480" alt="投稿ページ" src="https://user-images.githubusercontent.com/76896195/120482150-cbde3380-c3eb-11eb-9772-e5da8adaea23.png">



<img width="480" alt="マイページ" src="https://user-images.githubusercontent.com/76896195/120484019-9fc3b200-c3ed-11eb-964b-e354fc849e1f.png">

# 📂 機能一覧

### 投稿機能

- 画像投稿機能（carrier_wave)
- PDF変換表示機能(rmagic)
- タグ機能非同期通信(javascript)
- pdfサムネイル機能(jQuely)

### コメント機能

・投稿に対するコメント機能

### ユーザー管理機能

- ユーザー登録・ログイン（device）


### PDFダウンロード機能

- 投稿詳細ページからリンクし、ダウンロードが可能

### いいね機能

・いいねの投稿・表示（Ajax)

・トレンド機能（実装予定）

### 検索機能

- 複数条件検索機能(ransac)


# 💽使用技術

## フロントエンド

- HTML
- CSS
- JavaScript (jQuely)

## バックエンド

- Ruby 2.6.5
- Rails 6.0.3.7

## データベース

- MySQL2

## 開発環境

- docker dockercompose(導入予定)
- Rubocop (Rinter)

## 本番環境

- AWS（EC2、S3）
- Nginx、Unicorn、MariaDB

## テスト

- Rspec
    - 単体テスト（model)
    - 機能テスト（request)
    - 結合テスト（system)

# 💻インフラ図
![archtips_architect](https://user-images.githubusercontent.com/76896195/120641262-5b4c1b00-c4ae-11eb-9054-6c95a6c82f12.png)
