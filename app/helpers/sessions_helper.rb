module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  # 永続的Session
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user?(user)
    user == current_user
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # ログインの有無を調査
  def logged_in?
    !current_user.nil?
  end

  # 永続Session：ログイン情報破棄
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:user_id)
    @current_user = nil
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # FriendlyForwarding：記憶したURLにリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # FriendlyForwarding：アクセスを試みたURLを記憶
  def store_location
    session[:forwarding_url] = request.original_url
  end
end
