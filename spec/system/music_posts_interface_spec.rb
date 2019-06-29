require 'rails_helper'

RSpec.feature 'MusicPostInterface', type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:music) { create(:music_post, user_id: user.id) }
  let!(:other_music) { create(:music_post, user_id: other_user.id) }

  background { log_in_as(user) }

  scenario 'ユーザが動画を投稿する。' do
    visit root_path
    fill_in 'music_post_title', with: 'TestTitle'
    fill_in 'music_post_iframe', with: '<iframe width="560" height="315" src="https://www.youtube.com/embed/daS06STpEx4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'
    click_on '投稿'
    expect(page).to have_content 'TestTitle'
    expect(page).to have_css 'iframe', count: 2
    expect(page).to have_content "#{user.music_posts.count}件"
  end

  scenario 'ユーザが動画を削除する。' do
    visit root_path
    within("#music_post-#{music.id}") do
      expect(page).to have_content music.title
      click_on '動画を削除'
    end
    expect(page).not_to have_content music.title
    expect(page).not_to have_css 'iframe'
    expect(page).to have_content "#{user.music_posts.count}件"
  end

  scenario '他ユーザの投稿動画は削除できない。' do
    visit user_path(other_user)
    expect(page).not_to have_button '動画を削除'
  end
end
