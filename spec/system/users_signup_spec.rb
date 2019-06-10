require 'rails_helper'

RSpec.feature 'UsersSignup', type: :system do
  subject { click_on 'アカウント作成' }

  let!(:user) { build(:user) }

  background { visit signup_path }

  before do
    fill_in '名前', with: user.name
    fill_in '電子メール', with: user.email
    fill_in 'パスワード', with: user.password
    fill_in 'パスワード確認', with: user.password
  end

  scenario 'ユーザ登録失敗' do
    fill_in '名前', with: ''
    expect { subject }.not_to change(User, :count)
    expect(current_path).to eq signup_path
    expect(page).to have_title('新規登録')
    expect(page).to have_css('div#error_explanation', text: 'エラーがあります')
  end
end
