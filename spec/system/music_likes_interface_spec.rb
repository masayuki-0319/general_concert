require 'rails_helper'

RSpec.feature 'MusicLikeInterface', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:other_music) { create(:music_post, user_id: other_user.id) }
  let!(:follower) { create(:user_relationship, follower_id: user.id, followed_id: other_user.id) }

  background { log_in_as(user) }

  scenario '他のユーザのページで動画をいいね！する。' do
    visit user_path(other_user)
    expect(page).not_to have_button 'いいね！解除'
    click_on 'いいね！'
    expect(page).to have_button 'いいね！解除'
  end

  scenario '自分のFeedで動画をいいね！する。' do
    visit root_path
    expect(page).not_to have_button 'いいね！解除'
    click_on 'いいね！'
    expect(page).to have_button 'いいね！解除'
  end
end
