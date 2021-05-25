# Arch_Tips

# 建築設計者の投稿・検索サイトを作りたい！
```
Arch_Tipsは私が建築設計をしている中で感じた「あったらいいな！」を実現したものです。Web上にある建築の情報は散在しており、検索に時間がかかることが課題であると思っておりました。1つのサイトで情報をしぼって検索を行いたいという思いから、建築設計者のための投稿・検索アプリを作りました
```

# 登録不要で検索・閲覧が可能
```
Arch_Tipsは誰でも検索閲覧できます。トップページの投稿一覧をスクロールし気になる画像があればクリックすることで詳細が閲覧できます。検索はトプページから検索可能で、余計なページ移動は不要です。より使い込みたい場合はユーザー登録を行い投稿及び投稿へのコメントが可能です。
```

# PDF の投稿ができる
```
Arch_Tipsのこだわりのポイントは以下です。

・PDF が投稿できること(carrierwave,rmagic)
・充実した検索機能(ransac)
・高い保守性（rspec:103examles, rubocop)

建築設計では画像データは取り扱いません。基本的にPDF で作図、資料作成を行います。そのため、PDF を投稿し、プレビュー・ダウンロードできる機能を実装しました。
```

# 機能一覧

## 投稿機能

- 画像　投稿・詳細・編集・削除　機能
- PDF  投稿・詳細・編集・削除　機能
- タグ機能

## コメント機能

・投稿に対するコメント機能

## ユーザー管理機能

- ユーザー登録機能
- マイページ(ユーザーの投稿一覧表示)
- 

## PDFダウンロード機能

- 投稿詳細ページからリンク



# users
| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null :false               |
| email              | string | null :false, unique :true |
| encrypted_password | string | null :false               |
| last_name          | string | null :false               |
| first_name         | string | null :false               |
| introduction       | text   |                           |
|                    |        |                           |
## Association
has_many :tips
has_many :questions
has_many :answers
has_many :comments

# tips
| Column      | Type       | Options                       |
| ----------- | ---------- | ----------------------------- |
| title       | string     | null :false                   |
| category_id | string     | null :false                   |
| description | text       | null :false                   |
| user        | references | null :false,foreign_key :true |
|             |            |                               |
## Association
belongs_to :user
has_many :comments

# question
| Column      | Type       | Options                       |
| ----------- | ---------- | ----------------------------- |
| title       | string     | null :false                   |
| category_id | integer    | null :false                   |
| text        | text       | null :false                   |
| user        | references | null :false,foreign_key :true |
|             |            |                               |
## Association
belongs_to :user
has_many :answers


# answer
| Column   | Type       | Options                       |
| -------- | ---------- | ----------------------------- |
| answer   | text       | null :false                   |
| question | references | null :false,foreign_key :true |
| user     | references | null :false,foreign_key :true |
|          |            |                               |
belongs_to :user
belongs_to :question

# comment
| Column  | Type       | Option                        |
| ------- | ---------- | ----------------------------- |
| comment | text       | null :false                   |
| tweet   | references | null :false,foreign_key :true |
| user    | references | null :false,foreign_key :true |
|         |            |                               |
belongs_to :user
belongs_to :tip