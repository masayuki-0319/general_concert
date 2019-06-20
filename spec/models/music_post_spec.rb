require 'rails_helper'

RSpec.describe MusicPost, type: :model do
  context '#Validation' do
    let!(:music) { create(:music_post) }

    it '全属性の有効性' do
      music.valid?
      expect(music).to be_valid
    end

    it 'ユーザの存在性' do
      music.user_id = nil
      music.valid?
      expect(music).not_to be_valid
    end

    it '投稿動画の存在性（nil時）' do
      music.iframe = nil
      music.valid?
      expect(music).not_to be_valid
    end

    it '投稿動画の存在性（空白時）' do
      music.iframe = '  '
      music.valid?
      expect(music).not_to be_valid
    end

    it '投稿動画の文字列の長さ' do
      music.iframe = 'a' * 301
      music.valid?
      expect(music).not_to be_valid
    end

    it '投稿動画の文字列がYoutubeで取得したiframeか（正規表現）' do
      music.iframe = "<a>#{'a' * 100}</a>"
      music.valid?
      expect(music).not_to be_valid
    end

    it 'タイトルの存在性（nil時）' do
      music.title = nil
      music.valid?
      expect(music).not_to be_valid
    end

    it 'タイトルの存在性（空白時）' do
      music.title = '  '
      music.valid?
      expect(music).not_to be_valid
    end

    it 'タイトルの長さ' do
      music.title = 'a' * 141
      music.valid?
      expect(music).not_to be_valid
    end
  end
end
