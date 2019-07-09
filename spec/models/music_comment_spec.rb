require 'rails_helper'

RSpec.describe MusicComment, type: :model do
  let(:user) { create(:user) }
  let(:music) { create(:music_post) }
  let(:comment) { create(:music_comment, commenter_id: user.id, music_post_id: music.id) }

  context '#Validation' do
    it '全属性の有効性' do
      expect(comment.valid?).to be_truthy
    end

    it 'ユーザの存在性' do
      comment.commenter_id = nil
      expect(comment.valid?).to be_falsy
    end

    it '投稿動画の存在性' do
      comment.music_post_id = nil
      expect(comment.valid?).to be_falsy
    end

    it 'コメントの存在性' do
      comment.comment = nil
      expect(comment.valid?).to be_falsy
    end

    it 'コメントの文字列の長さ' do
      comment.comment = 'a' * 141
      expect(comment.valid?).to be_falsy
    end
  end
end
