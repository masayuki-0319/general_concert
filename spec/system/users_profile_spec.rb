require 'rails_helper'

RSpec.feature 'UsersProfile', type: :system do
  let!(:user) { create(:user) }

  before do
    5.times { create(:music_post, user_id: user.id) }
    log_in_as(user)
    visit user_path(user)
  end

  scenario 'ユーザ詳細ページにアクセス' do
    expect(page).to have_content user.name
    expect(page).to have_css 'iframe', count: 5
    expect(page).to have_selector 'img.gravatar'
  end
end
