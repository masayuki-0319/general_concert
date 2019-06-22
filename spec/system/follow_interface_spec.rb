require 'rails_helper'

RSpec.feature 'FollowInterface', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:another_user) { create(:user) }
  let!(:follower) { create(:user_relationship, follower_id: user.id, followed_id: other_user.id) }
  let!(:following) { create(:user_relationship, follower_id: other_user.id, followed_id: user.id) }

  background { log_in_as(user) }

  context '一覧ページの確認' do
    scenario 'フォロー一覧ページにアクセスする。' do
      visit following_user_path(user)
      expect(current_path).to eq following_user_path(user)
      expect(page).to have_content user.following.count
      expect(page).to have_content other_user.name
      expect(page).to have_link other_user.name, href: user_path(other_user)
    end

    scenario 'フォロワー一覧ページにアクセスする。' do
      visit followers_user_path(user)
      expect(current_path).to eq followers_user_path(user)
      expect(page).to have_content user.followers.count
      expect(page).to have_content other_user.name
      expect(page).to have_link other_user.name, href: user_path(other_user)
    end
  end

  context 'フォロー機能の確認' do
    scenario '他のユーザをフォローする。' do
      visit user_path(another_user)
      click_on 'フォロー'
      expect(page).to have_button 'フォロー解除'
    end

    scenario '他のユーザをフォロー解除する。' do
      visit user_path(other_user)
      click_on 'フォロー解除'
      expect(page).to have_button 'フォロー'
    end
  end
end
