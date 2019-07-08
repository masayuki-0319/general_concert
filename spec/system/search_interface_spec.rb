require 'rails_helper'

RSpec.feature 'SearchInterface', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:music) { create(:music_post, title: 'music-12', user_id: user.id) }
  let!(:other_music) { create(:music_post, title: 'music-23', user_id: other_user.id) }

  background do
    log_in_as(user)
    visit music_posts_path
  end

  context '投稿動画を検索する。' do
    scenario '全て表示される。' do
      fill_in 'タイトル名', with: 'music'
      click_on '検索'
      expect(page).to have_content music.title
      expect(page).to have_content other_music.title
    end

    scenario '一つのみ表示される。' do
      fill_in 'タイトル名', with: '12'
      click_on '検索'
      expect(page).to have_content music.title
      expect(page).not_to have_content other_music.title
    end
  end
end
