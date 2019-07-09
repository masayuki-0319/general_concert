require 'rails_helper'

RSpec.describe UserRelationship, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:relation) { create(:user_relationship, follower_id: user.id, followed_id: other_user.id) }

  context '#Validation' do
    it '全属性の有効性' do
      expect(relation.valid?).to be_truthy
    end

    it 'Followerの存在性' do
      relation.follower_id = nil
      expect(relation.valid?).to be_falsy
    end

    it 'Followedの存在性' do
      relation.followed_id = nil
      expect(relation.valid?).to be_falsy
    end
  end

  context '#Follow' do
    before { user.follow(other_user) }

    it 'ユーザをフォロー' do
      expect(user.following?(other_user)).to be_truthy
      expect(other_user.followers.include?(user)).to be_truthy
    end

    it 'ユーザをフォロー解除' do
      user.unfollow(other_user)
      expect(user.following?(other_user)).to be_falsy
      expect(other_user.followers.include?(user)).to be_falsy
    end
  end
end
