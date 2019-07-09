class SessionsController < ApplicationController
  def new
  end

  def create
    auth = request.env['omniauth.auth']
    if auth.present?
      user = User.find_or_create_from_auth(auth)
    else
      user = User.find_by(email: params[:session][:email].downcase)
      unless user && user.authenticate(params[:session][:password])
        flash.now[:danger] = '電子メール又はパスワードの組み合わせがマッチしません。'
        render 'new'
        return
      end
    end
    log_in user
    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    redirect_to root_path
  end

  def failure
    render status: 500, text: "error"
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
