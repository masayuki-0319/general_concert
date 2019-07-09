Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']

  # 認証キャンセルする場合等で/auth/failureへリダイレクト
  on_failure do |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  end
end
