require 'rails_helper'

RSpec.feature 'UsersDestroy', type: :system do
  let!(:admin_user) { create(:admin_user) }
  let!(:other_user) { create(:user) }
  let!(:another_user) { create(:user) }

  scenario '管理者権限を持つユーザが他のユーザを削除する。' do
    log_in_as(admin_user)
    visit users_path
    expect(page).to have_content other_user.name
    expect(page).to have_content '削除', 2
    click_link '削除', href: "/users/#{other_user.id}"
    expect(page).not_to have_content other_user.name
  end

  scenario '管理者権限を持たないユーザは削除権限を持たない。' do
    log_in_as(other_user)
    visit users_path
    expect(page).not_to have_content '削除'
  end
end
