require 'rails_helper'

RSpec.feature 'UsersIndex', type: :system do
  let!(:user) { create(:user) }

  before do
    30.times { create(:user) }
    log_in_as(user)
    visit users_path
  end

  scenario 'ユーザ一覧ページにアクセス' do
    expect(page).to have_content 'ユーザー一覧'
    expect(page).to have_css 'div.pagination'
    expect(page).to have_link '2'
  end
end
