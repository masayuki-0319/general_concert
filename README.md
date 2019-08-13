# 【概要】
- 名称：ゼネラルコンサート
- 目的：音楽団体をより身近に感じられるような社会を目指して，音楽団体同士の交流を促進し，音楽活動への情熱を高め，やりたいことに集中できる環境を提供する（開発ロードマップは，関連リンクの開発コンセプトを御確認ください。）。

## □ 開発環境等
- 言語：Ruby, Javascript
- フロントエンド：Vue.js(作業中：[進捗状況](https://github.com/masayuki-0319/general_concert/projects/4))
- バックエンド：Ruby on Rails
- データベース：MySQL
- テスト環境：RSpec（ModelSpec, ControllerSpec, SystemSpecを記述）
- 本番環境：Heroku
- バージョン管理：Git
- リポジトリ管理：GitHub

## □ 関連リンク
- [本番環境](https://general-concert-0319.herokuapp.com/)
- [開発コンセプト](https://qiita.com/Moo_Moo_Farm/items/88e829c24e0c0f11c6b5)

# 【実装機能】
- 基本機能
  - ユーザーCRUD（devise不使用）
  - ソーシャルログイン（Facebook, Google, Github）
  - ユーザー相互フォロー
  - Ajax（動画投稿及び削除, 相互フォロー, 動画お気に入り, 動画コメント, フラッシュメッセージ）
- 機能１：演奏動画の視聴
  - Youtube動画URL投稿及び削除
  - 動画のお気に入り
  - 動画の検索
  - 動画のコメント（モーダル表示付属）

# 【気を付けたポイント】
## □ コード部分
- [RSpec：SystemSpecを使用](https://qiita.com/jnchito/items/c7e6e7abf83598a6516d)
  - RSpecのドキュメントにおいて，FeatureSpecよりSystemSpecの使用が推奨されるため。
- [RSpec：失敗したテストだけを対象にできる[--only-failures]オプションを導入](https://blog.piyo.tech/posts/2018-05-16-rspec-only-failures/)
  - テスト増加に伴い，機能実装の試行錯誤時に問題無いテストを何度も実行することが不要な時間であるため。
- [Gem：Rubocop使用（rubocop-airbnb併用）](https://www.slideshare.net/ssuser21f9f1/rubocop-78362847)
  - コードスタイルの統一による可読性向上のため。
- [Gem：Bulletを使用してN+1問題の解決](https://qiita.com/hirotakasasaki/items/e0be0b3fd7b0eb350327)
  - N+1問題を解消しておくことで，データ量が膨大になる際のSQLのパフォーマンスを改善するため。
- [[form_with]を使用](https://qiita.com/hmmrjn/items/24f3b8eade206ace17e2)
  - [form_for]と[form_tag]が将来的に[form_with]へ将来的に置換するため。
- [[Time.current]を使用](https://doruby.jp/users/takeshita/entries/Rails-%E6%99%82%E5%88%BB%E5%87%A6%E7%90%86%E3%81%A7%E3%81%AF%E3%80%81Time-current--Time-zone-local-%3CTimeWithZone%E3%82%AF%E3%83%A9%E3%82%B9%3E-%E3%82%92%E4%BD%BF%E3%81%86)
  - Railsの時刻処理では，[updated_at]と同じTimeWithZoneクラスの使用が推奨されているため。
- [[javascript_include_tag]の読み込み位置](https://teratail.com/questions/14600)
  - bodyの閉じタグ直前に移動することで，HTMLやCSSの読み込み及びレンダリングをブロックしないため。
- [部分テンプレートにインスタンス変数の使用回避](https://qiita.com/mom0tomo/items/e1e3fd29729b2d112a48)
  - 部分テンプレートとコントローラの密結合を防止して再利用性を向上させるため。

## □ 心構え部分
- [必要最小限のコメント](https://twitter.com/t_wada/status/904916106153828352)
  - リーダブルコード中の[コードの可読性向上]を重視してコメントを使用した（転送先にある[Why not]は優先度２番目と考えた。）。
- デバッグの重要性
  - エラー発生時には，サーバーのログとエラーメッセージを参考にして，[debugger]メソッドと[save_and_open_page]メソッドを中核にエラーに対処した。
- テスト駆動開発及び振舞駆動開発の重要性
  - 下記の力を入れた点をご参照願います。

## □ 力を入れた点
- 本アプリを作成する上で一番力を入れた点は，多くの機能に対し，RSpecを使用してテスト駆動開発（TDD）と振舞駆動開発（BDD）の考えに基づきコードを書いたことである。
- 今までは，コードを書いたらコンソール又はブラウザにより手作業で逐一動作を確認していたが，RSpecを使用するようになって，次の点でTDDとBDDのメリットを体感した。
  - トライアンドエラーのサイクルを早く回せるようになり，開発スピードの向上
  - 適切なParamsの渡し方等を考えるようになり，機能に対する理解度の向上
  - 欲しい機能をテストで記述しコードを実装するようになり，コードに対する信頼感の獲得
  - Ajaxの実装やリファクタリング等に安心して取り組めるようになり，修正に対する積極性の獲得
