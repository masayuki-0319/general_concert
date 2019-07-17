Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :google_oauth2, '440617550175-cu80dsifffavbt21kg70s8agngl5e276.apps.googleusercontent.com', ENV['GOOGLE_CLIENT_SECRET'],
    {
      scope: 'userinfo.email, userinfo.profile, http://gdata.youtube.com',
      prompt: 'select_account',
      image_aspect_ratio: 'square',
      image_size: 50
    }

  # 認証キャンセルする場合等で/auth/failureへリダイレクト
  on_failure do |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  end
end
