require 'rails_helper'

RSpec.feature 'UsersEdit', type: :system do
  let!(:user) { create(:user) }

  background do
    log_in_as(user)
    visit edit_user_path(user)
  end

  before do
    fill_in '名前', with: 'Name After Changing'
    fill_in '電子メール', with: 'email@after.com'
    fill_in 'パスワード', with: user.password
    fill_in 'パスワード確認', with: user.password
  end

  context 'ユーザ編集' do
    scenario '通常成功' do
      click_button '変更'
      expect(current_path).to eq user_path(user)
      expect(page).to have_content 'Name After Changing'
    end

    scenario 'パスワード欄を空にして成功' do
      fill_in 'パスワード', with: ''
      fill_in 'パスワード確認', with: ''
      click_button '変更'
      expect(current_path).to eq user_path(user)
      expect(page).to have_content 'Name After Changing'
    end

    scenario '失敗' do
      fill_in '電子メール', with: ''
      click_button '変更'
      expect(current_path).to eq user_path(user)
      expect(page).to have_content 'ユーザー情報編集'
    end

    context '#ログイン済みでない場合' do
      before { log_out_as(user) }

      it 'user#editにアクセス不可' do
        visit edit_user_path(user)
        expect(current_path).to eq root_path
      end

      it 'user#updateにアクセス不可' do
        patch user_path(user), params: { id: user.id, user: { name: 'Changing Name' } }
        expect(current_path).to eq root_path
      end
    end
  end
end
