RSpec.configure do |config|
  config.before(:each) do |example|
    if example.metadata[:type] == :system
      if example.metadata[:js]
        driven_by :selenium_chrome_headless, screen_size: [1400, 1400]
      else
        driven_by :rack_test
      end
    end
  end
  # 下記はEverydayRails準拠の設定で，上記は伊藤氏のQiitaを参考に下記を編集したもの。
  # config.before(:each, type: :system) do
  #   driven_by :rack_test
  # end
  # config.before(:each, type: :system, js: true) do
  #   driven_by :selenium_chrome_headless
  # end
end
