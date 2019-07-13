# 概要
このアプリケーションは，音楽団体の交流を目的としたオリジナルアプリケーションです。

## 開発環境等
- Ruby2.5.1
- Rails5.2.3
- Database：MySQL
- 本番環境：Heroku
- テスト環境：RSpec（--only-failuresオプションも設定）
  - ModelSpec, ControlerSpec, SystemSpecを記述
- Rubocop使用（rubocop-airbnb併用）

## 関連リンク
- [開発コンセプト](https://qiita.com/Moo_Moo_Farm/items/88e829c24e0c0f11c6b5)
- [本番環境](https://general-concert-0319.herokuapp.com/)

## 実装機能
- ユーザーCRUD機能
- Youtube動画URL投稿及び削除機能
- ユーザー相互フォロー機能
- 投稿動画のいいね！機能（お気に入り機能）
- Ajax（動画投稿及び削除, 相互フォロー, いいね！機能, コメント機能）
- 投稿動画の検索機能
- Facebookログイン（devise不使用）
- 投稿動画のコメント機能（モーダル表示）

# 気をつけたポイント
## コード部分
- [[form_with]を使用](https://qiita.com/hmmrjn/items/24f3b8eade206ace17e2)
  - [form_for]と[form_tag]が将来的に[form_with]へ将来的に置き換わるため。
- [[Time.current]を使用](https://doruby.jp/users/takeshita/entries/Rails-%E6%99%82%E5%88%BB%E5%87%A6%E7%90%86%E3%81%A7%E3%81%AF%E3%80%81Time-current--Time-zone-local-%3CTimeWithZone%E3%82%AF%E3%83%A9%E3%82%B9%3E-%E3%82%92%E4%BD%BF%E3%81%86)
  - Railsの時刻処理では，TimeWithZoneクラスの使用が推奨されているため，[Time.now]の使用を避ける。
- [[javascript_include_tag]の読み込み位置](https://teratail.com/questions/14600)
  - bodyの閉じタグ直前に移動することで，HTMLやCSSの読み込み及びレンダリングをブロックしない。
- [部分テンプレートにインスタンス変数の使用回避](https://qiita.com/mom0tomo/items/e1e3fd29729b2d112a48)
  - 部分テンプレートとコントローラの密結合を防止して再利用性を向上させるため，部分テンプレートにインスタンス変数の使用を避けた。
- [Bulletを使用してN+1問題の解決](https://qiita.com/hirotakasasaki/items/e0be0b3fd7b0eb350327)
  - N+1問題を解消しておくことで，データ量が膨大になる際のSQLの将来的なパフォーマンスを改善する。
- [RSpec：SystemSpecを使用](https://qiita.com/jnchito/items/c7e6e7abf83598a6516d)
  - RSpecのドキュメントにおいて，SystemSpecの使用が推奨されているため。
## 心構え部分
- [必要最小限のコメント](https://twitter.com/t_wada/status/904916106153828352)
  - リーダブルコード中の[コードの可読性向上]を重視してコメントを記入した（転送先にある[Why not]は優先度２番目と考えた。）。
- デバッグの重要性
  - エラー発生時には，エラーメッセージを参考にして，[debugger]メソッドとRSpecの[save_and_open_page]メソッドを中核として，エラーを解消した。
## 力を入れた点
【力を入れた点】
- 本アプリを作成する上で一番力を入れた点は，ほぼ全ての機能に対し，RSpecを使用してテスト駆動開発（TDD）と振舞駆動開発（BDD）の考えに基づきコードを書いたことです。
- 今までは，コードを書いたらコンソール又はブラウザにより，手作業で逐一動作を確認していましたが，RSpecを使用するようになって，次の点について，TDDとBDDのメリットを体感しました。
  - トライアンドエラーのサイクルを早く回せるようになり，開発スピードが向上
  - 適切なParamsの渡し方等を考えるようになり，機能に対する理解度が向上
  - 欲しい機能をテストで記述しコードを実装するようになり，コードへの信頼感を獲得
  - Ajaxの実装やリファクタリング等に安心して取り組めるようになり，修正に対する積極性を獲得
