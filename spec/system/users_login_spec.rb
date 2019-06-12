require 'rails_helper'

RSpec.feature 'UsersLogin', type: :system do
  let!(:user) { create(:user) }

  background { visit login_path }

  before do
    fill_in '電子メール', with: user.email
    fill_in 'パスワード', with: user.password
  end

  context 'ユーザログイン' do
    scenario '成功' do
      click_button 'ログイン'
      expect(current_path).to eq user_path(User.last)
      expect(page).to have_content user.name
    end

    scenario '失敗' do
      fill_in '電子メール', with: ''
      click_button 'ログイン'
      expect(current_path).to eq login_path
      expect(page).to have_title 'ログイン'
      expect(page).to have_css 'div.alert-danger'
      visit root_path
      expect(page).not_to have_css 'div.alert-danger'
    end
  end

  context 'ユーザログアウト' do
    scenario '成功' do
      click_button 'ログイン'
      click_on 'ログアウト'
      expect(current_path).to eq root_path
    end
  end
end
