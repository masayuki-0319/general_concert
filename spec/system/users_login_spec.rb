require 'rails_helper'

RSpec.feature 'UsersLogin', type: :system do
  let!(:user) { create(:user) }

  background { visit login_path }

  before do
    fill_in '電子メール', with: user.email
    fill_in 'パスワード', with: user.password
  end

  context '通常ログインの場合' do
    scenario '成功する。' do
      click_button 'ログイン'
      expect(current_path).to eq user_path(User.last)
      expect(page).to have_content user.name
    end

    scenario 'RememberMeによりクッキーを保存して成功する。' do
      check 'session_remember_me'
      expect(page).to have_checked_field('このパソコンにログイン情報を保存する。')
      click_button 'ログイン'
      expect(current_path).to eq user_path(User.last)
      expect(page).to have_content user.name
    end

    scenario '失敗する。' do
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
    scenario '成功する。' do
      click_button 'ログイン'
      click_on 'ログアウト'
      expect(current_path).to eq root_path
      expect(page).not_to have_link 'ログアウト'
      # ２つ目のWindowでログアウト実行時
      page.driver.submit :delete, '/logout', {}
      expect(current_path).to eq root_path
      expect(page).not_to have_link 'ログアウト'
    end
  end

  context 'SNSログイン' do
    context 'ユーザーが未登録の場合，' do
      scenario 'Facebookログインが成功する。' do
        visit root_path
        click_on 'Facebookログイン'
        expect(current_path).to eq user_path(User.last)
        expect(page).to have_content 'Facebookログインしました。'
        expect(page).to have_content 'Example User'
      end
    end

    context 'ユーザーが登録済みの場合，' do
      let!(:user) { create(:user, email: 'example@railstutorial.org', name: 'Example User') }

      scenario 'Facebookログインが成功する。' do
        visit root_path
        click_on 'Facebookログイン'
        expect(current_path).to eq user_path(User.last)
        expect(page).to have_content 'Facebookログインしました。'
        expect(page).to have_content 'Example User'
      end
    end
  end
end
