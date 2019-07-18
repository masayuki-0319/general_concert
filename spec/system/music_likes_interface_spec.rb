require 'rails_helper'

RSpec.feature 'MusicLikeInterface', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:other_music) { create(:music_post, user_id: other_user.id) }
  let!(:follower) { create(:user_relationship, follower_id: user.id, followed_id: other_user.id) }

  background { log_in_as(user) }

  context '動画をお気に入りに入れる場合，' do
    scenario '他のユーザのページで入れる。' do
      visit user_path(other_user)
      expect(page).to have_selector "#like-#{other_user.id}", text: other_user.music_likes.count
      click_on 'お気に入り'
      expect(page).to have_button 'お気に入り解除'
      expect(page).to have_selector "#like-#{other_user.id}", text: other_user.music_likes.count
    end

    scenario '自分のフィードで入れる。' do
      visit root_path
      expect(page).to have_selector "#like-#{user.id}", text: user.music_likes.count
      click_on 'お気に入り'
      expect(page).to have_button 'お気に入り解除'
      expect(page).to have_selector "#like-#{user.id}", text: user.music_likes.count
    end
  end

  context 'お気に入り一覧を見る場合，' do
    let!(:like) { create(:music_like, liker_id: user.id, music_post_id: other_music.id) }

    scenario 'お気に入りの動画が表示される。' do
      visit root_path
      test_link = find(:xpath, "//a[contains(@href,'music_posts/1/show_like')]")
      test_link.click
      expect(current_path).to eq show_like_music_post_path(user)
      expect(page).to have_content other_music.title
      expect(page).to have_selector 'iframe'
    end
  end
end
