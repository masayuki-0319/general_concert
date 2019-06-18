module LoginMacros
  # ログイン中であるか確認
  def is_logged_in?
    !session[:user_id].nil?
  end

  # テストユーザとしてログイン
  def log_in_as(user)
    visit login_path
    fill_in '電子メール', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end
end
