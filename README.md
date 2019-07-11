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
- Bullet使用（N+1問題検出用）

## 関連リンク
- [開発コンセプト](https://qiita.com/Moo_Moo_Farm/items/88e829c24e0c0f11c6b5)
- [本番環境](https://general-concert-0319.herokuapp.com/)

# 実装機能
- ユーザーCRUD機能
- Youtube動画URL投稿及び削除機能
- ユーザー相互フォロー機能
- 投稿動画のいいね！機能（お気に入り機能）
- Ajax（動画投稿及び削除 相互フォロー, いいね！機能, コメント機能）
- 投稿動画の検索機能
- Facebookログイン（devise不使用）
- 投稿動画のコメント機能（モーダル表示）
