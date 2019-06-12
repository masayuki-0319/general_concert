require 'rails_helper'

RSpec.feature 'UsersLogin', type: :system do
  let!(:user) { create(:user) }

  background { visit login_path }

  before do
    fill_in '電子メール', with: user.email
    fill_in 'パスワード', with: user.password
  end

  scenario 'ユーザログイン＝＞失敗' do
    fill_in '電子メール', with: ''
    click_button 'ログイン'
    expect(current_path).to eq login_path
    expect(page).to have_title 'ログイン'
    expect(page).to have_css 'div.alert-danger'
    visit root_path
    expect(page).not_to have_css 'div.alert-danger'
  end

  # scenario 'ユーザログイン＝＞成功' do
  #   expect { subject }.to change(User, :count).by(1)
  #   expect(current_path).to eq user_path(User.last)
  #   expect(page).to have_content user.name
  #   expect(page).to have_css('div.alert-success')
  # end
end
