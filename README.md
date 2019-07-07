# 概要
- このアプリケーションは，音楽団体の交流を目的としたオリジナルアプリケーションです。
- Railsチュートリアルを参考に実装しており，以下の点を主に変更しております。
  - テストをRSpecで実装（--only-failuresオプションも設定）
    - ControllerSpec, ModelSpec, SystemSpec
  - Rubocop使用（rubocop-airbnb併用）
  - Bullet使用（N+1問題検出用）
  - DatabaseをMySQLで実装
  - [form_for]から[form_with]に変更して実装

# 関連リンク
- [開発コンセプト](https://qiita.com/Moo_Moo_Farm/items/88e829c24e0c0f11c6b5)
- [本番環境](https://general-concert-0319.herokuapp.com/)

# 実装機能
- ユーザーCRUD機能
- Youtube動画URL投稿機能（API未使用）
- ユーザー相互フォロー機能
- 投稿動画のいいね！機能（お気に入り機能）
- Ajax（動画投稿，動画削除，相互フォロー，いいね！機能）
