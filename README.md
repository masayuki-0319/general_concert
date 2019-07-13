# 【概要】
このアプリケーションは，音楽団体の交流を目的としたオリジナルアプリケーションです。
## □ 開発環境等
- 言語：Ruby2.5.1
- フレームワーク：Ruby on Rails5.2.3
- データベース：MySQL
- テスト環境：RSpec（ModelSpec, ControlerSpec, SystemSpecを記述）
- 本番環境：Heroku
- リポジトリ管理：Github

## □ 関連リンク
- [本番環境](https://general-concert-0319.herokuapp.com/)
- [開発コンセプト](https://qiita.com/Moo_Moo_Farm/items/88e829c24e0c0f11c6b5)

# 【機能】
## □ 実装済み
- ユーザーCRUD
- Youtube動画URL投稿及び削除
- ユーザー相互フォロー
- 投稿動画のいいね！（お気に入り機能）
- Ajax（動画投稿及び削除, 相互フォロー, いいね！機能, コメント機能, フラッシュメッセージ）
- 投稿動画の検索
- ソーシャルログイン（Facebook）
- 投稿動画のコメント（モーダル表示）

## □ 未実装
- 掲示板
- ルームチャット
- 投稿動画のタグ検索
- 投稿動画の評価
- 他のソーシャルログイン
- YoutubeのAPI使用

# 【気をつけたポイント】
## □ コード部分
- [RSpec：SystemSpecを使用](https://qiita.com/jnchito/items/c7e6e7abf83598a6516d)
  - RSpecのドキュメントにおいて，FeatureSpecよりSystemSpecの使用が推奨されているため。
- [RSpec：失敗したテストだけを対象にできる[--only-failures]オプションを導入](https://blog.piyo.tech/posts/2018-05-16-rspec-only-failures/)
  - テストの増加に伴い，機能実装の度に問題無いテストを走らせることが不要な時間であるため。
- Rubocop使用（rubocop-airbnb併用）
  - コードスタイルの統一による可読性向上のため。
- [[form_with]を使用](https://qiita.com/hmmrjn/items/24f3b8eade206ace17e2)
  - [form_for]と[form_tag]が将来的に[form_with]へ将来的に置き換わるため。
- [[Time.current]を使用](https://doruby.jp/users/takeshita/entries/Rails-%E6%99%82%E5%88%BB%E5%87%A6%E7%90%86%E3%81%A7%E3%81%AF%E3%80%81Time-current--Time-zone-local-%3CTimeWithZone%E3%82%AF%E3%83%A9%E3%82%B9%3E-%E3%82%92%E4%BD%BF%E3%81%86)
  - Railsの時刻処理では，[updated_at]と同じTimeWithZoneクラスの使用が推奨されているため。
- [[javascript_include_tag]の読み込み位置](https://teratail.com/questions/14600)
  - bodyの閉じタグ直前に移動することで，HTMLやCSSの読み込み及びレンダリングをブロックしないため。
- [部分テンプレートにインスタンス変数の使用回避](https://qiita.com/mom0tomo/items/e1e3fd29729b2d112a48)
  - 部分テンプレートとコントローラの密結合を防止して再利用性を向上させるため。
- [Bulletを使用してN+1問題の解決](https://qiita.com/hirotakasasaki/items/e0be0b3fd7b0eb350327)
  - N+1問題を解消しておくことで，データ量が膨大になる際のSQLの将来的なパフォーマンスを改善するため。

## □ 心構え部分
- [必要最小限のコメント](https://twitter.com/t_wada/status/904916106153828352)
  - リーダブルコード中の[コードの可読性向上]を重視してコメントを記入した（転送先にある[Why not]は優先度２番目と考えた。）。
- デバッグの重要性
  - エラー発生時には，エラーメッセージを参考にして，[debugger]メソッドとRSpecの[save_and_open_page]メソッドを中核として，エラーを解消した。
- テスト駆動開発及び振舞駆動開発の重要性
  - 下記の力を入れた点をご参照願います。

## □ 力を入れた点
- 本アプリを作成する上で一番力を入れた点は，ほぼ全ての機能に対し，RSpecを使用してテスト駆動開発（TDD）と振舞駆動開発（BDD）の考えに基づきコードを書いたことである。
- 今までは，コードを書いたらコンソール又はブラウザにより，手作業で逐一動作を確認していましたが，RSpecを使用するようになって，次の点でTDDとBDDのメリットを体感した。
  - トライアンドエラーのサイクルを早く回せるようになり，開発スピードが向上
  - 適切なParamsの渡し方等を考えるようになり，機能に対する理解度が向上
  - 欲しい機能をテストで記述しコードを実装するようになり，コードへの信頼感を獲得
  - Ajaxの実装やリファクタリング等に安心して取り組めるようになり，修正に対する積極性を獲得
