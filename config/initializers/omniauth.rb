Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :google_oauth2,ENV['GOOGLE_CLIENT_ID'],ENV['GOOGLE_CLIENT_SECRET'],
    {
      scope: 'userinfo.email, userinfo.profile, http://gdata.youtube.com',
      prompt: 'select_account',
      image_aspect_ratio: 'square',
      image_size: 50
    }
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user,repo,gist"

  # 認証キャンセルする場合等で/auth/failureへリダイレクト
  on_failure do |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  end
end
