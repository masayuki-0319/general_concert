require 'rails_helper'

RSpec.feature 'FollowInterface', type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:follower) { create(:user_relationship, follower_id: user.id, followed_id: other_user.id) }
  let!(:following) { create(:user_relationship, follower_id: other_user.id, followed_id: user.id) }

  context '一覧ページの確認' do
    context 'ログイン前の場合' do
      scenario 'フォロー一覧ページにアクセス不可' do
        visit following_user_path(user)
        expect(current_path).to eq login_path
      end

      scenario 'フォロワー一覧ページにアクセス不可' do
        visit followers_user_path(user)
        expect(current_path).to eq login_path
      end
    end

    context 'ログイン後の場合' do
      before { log_in_as(user) }
      scenario 'フォロー一覧ページにアクセス可能' do
        visit following_user_path(user)
        expect(current_path).to eq following_user_path(user)
        expect(page).to have_content user.following.count
        expect(page).to have_content other_user.name
        expect(page).to have_link other_user.name, href: user_path(other_user)
      end

      scenario 'フォロワー一覧ページにアクセス可能' do
        visit followers_user_path(user)
        expect(current_path).to eq followers_user_path(user)
        expect(page).to have_content user.followers.count
        expect(page).to have_content other_user.name
        expect(page).to have_link other_user.name, href: user_path(other_user)
      end
    end
  end
end
