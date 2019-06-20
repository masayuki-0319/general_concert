require 'rails_helper'

RSpec.describe MusicPost, type: :model do
  let(:user) { create(:user) }
  let(:music) { create(:music_post) }
  let(:music_attributes) { attributes_for(:music_post) }

  context '#Validation' do
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

  context '#Association' do
    it 'ユーザとの関連付けで生成' do
      expect { user.music_posts.create(music_attributes) }.to change(MusicPost, :count).by(1)
    end

    it 'ユーザとの関連付けで削除' do
      user.music_posts.create(music_attributes)
      expect { user.destroy }.to change(MusicPost, :count).by(-1)
    end
  end

  context '#DisplayOrder' do
    before { 3.times { create(:music_post) } }

    it '新着が最初に表示' do
      most_recent = user.music_posts.create(music_attributes)
      expect(most_recent).to eq MusicPost.first
    end
  end
end
