require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:other_user) { create(:user) }
  let(:valid_addressess) do
    %w(
      user@example.com
      USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp alice+bob@baz.cn
    )
  end
  let(:mixed_addresse) { 'Foo@ExAMPle.CoM' }
  let(:invalid_addresses) do
    %w(
      user@example,com
      user_at_foo.org
      user.name@example.
      foo@bar_baz.com foo@bar+baz.com
    )
  end

  context '#Validation' do
    subject { expect(user.valid?).to be_falsy }

    it '全属性の有効性' do
      expect(user.valid?).to be_truthy
    end

    it 'Name無効（nil時)' do
      user.name = nil
      subject
    end

    it 'Name無効（長すぎる時)' do
      user.name = 'a' * 51
      subject
    end

    it 'Email無効（nil時)' do
      user.email = nil
      subject
    end

    it 'Email無効（長すぎる時)' do
      user.email = 'a' * 256
      subject
    end

    it 'Email有効（フォーマットの有効性）' do
      valid_addressess.each do |valid_address|
        user.email = valid_address
        expect(user.valid?).to be_truthy
      end
      user.email = mixed_addresse
      user.save
      expect(user.email).to eq mixed_addresse.downcase
    end

    it 'Email有効（小文字保存の有効性）' do
      user.email = mixed_addresse
      user.save
      expect(user.email).to eq mixed_addresse.downcase
    end

    it 'Email無効（フォーマット）' do
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        subject
      end
    end

    it 'Email無効（一意性）' do
      user.email = other_user.email.upcase!
      subject
    end

    it 'Password無効（半角スペース６つ）' do
      user.password = user.password_confirmation = ' ' * 6
      subject
    end

    it 'Password無効（長さが6個未満）' do
      user.password = user.password_confirmation = 'a' * 5
      subject
    end
  end

  context '#FollowFeed' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:another_user) { create(:user) }
    let!(:music) { create(:music_post, user_id: user.id) }
    let!(:other_music) { create(:music_post, user_id: other_user.id) }
    let!(:another_music) { create(:music_post, user_id: another_user.id) }
    let!(:user_relationship) { create(:user_relationship, follower_id: user.id, followed_id: other_user.id) }

    it '自分とFollowerの投稿のみを所有する。' do
      expect(user.feed).to match_array [music, other_music]
    end
  end
end
