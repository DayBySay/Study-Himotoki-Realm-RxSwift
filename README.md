## 目的、学びたいこと
* Himotoki + HTTP Clientをを使ったデータ取得方法
    * データの持ちかた、パースの仕方
* Realmを使ったデータの永続化方法
    * CRUD, Migration
* RxSwift, RxCocoaの初歩
    * 概念、主にデータ、イベント周りについて
    * ビューへのデータバインディング方法
    * スレッド、メモリ管理について

## 作るもの
* GitHubのユーザのリポジトリ一覧を見ることができる

### 機能
* ユーザ名の登録
* リポジトリ一覧の取得, 保存
* リポジトリの閲覧

#### 備考
* HTTPリクエストはAlamofire
* データのデコードとマッピングはHimotoki
* データの永続化はRealm
* Viewへのデータ反映はRx
