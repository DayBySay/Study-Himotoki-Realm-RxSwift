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
* RSS Feed Reader

### 機能
* Feed URLの登録
* Feedの取得, 保存
* 記事の閲覧

#### 備考
* Feed取得のリクエストはAlamofireで
* 取得したXMLのパースは・・あれしてJSONにしてHimotokiへ
* データはRealmで永続化
* Viewへのデータ反映はRx
