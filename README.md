# 開発環境

・Ruby version 2.6.1

・Ruby on rail version 5.2.3

・PostgreSQL version 9.5.14

# Heroku デプロイ手順

1. Herokuへログイン
  $ heroku login --interactive

2. Herokuに新しいアプリケーションを作成
  $ heroku create

3. Herokuにアプリをデプロイ
  $ git push heroku master

4. Herokuへデータベースを作成
　$ heroku run rails db:migrate

# checkmywork 構造

#### userモデル

|カラム名 : データ型  |カラム名 : データ型  |カラム名 : データ型  |
|---|---|---|
|user : string  |email : string  |password_digest : string  |

#### taskモデル

|カラム名 : データ型  |カラム名 : データ型  |カラム名 : データ型  |カラム名 : データ型  |カラム名 : データ型  |カラム名 : データ型  |
|---|---|---|---|---|---|
|name : string  |detail : text  |deadline : datetime  |situation : string  |priority : integer  |user : references  |

#### missionモデル
|カラム名 : データ型  |カラム名 : データ型  |
|---|---|
|task_id : integer  |label_id : integer  |

#### labelモデル

|カラム名 : データ型  |
|---|
|title : string  |

![ER図](/docs/ER図.png)
