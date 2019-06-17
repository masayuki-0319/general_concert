require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { create(:user) }
  let(:user_login) do
    post :create, params: { session: {
      email: user.email,
      password: user.password,
      remember_me: '1'
    } }
  end

  before { get :new }

  context "GET #new" do
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'returns new template' do
      expect(response).to render_template :new
    end
  end

  context 'ログイン成功：RememberMe保存を確認' do
    it 'クッキー保存を確認' do
      user_login
      expect(response.cookies['remember_token']).not_to eq nil
    end
  end

  context 'ログイン成功：RememberMeを除外' do
    let(:user_login_without_remember_me) do
      post :create, params: { session: {
        email: user.email,
        password: user.password,
        remember_me: '0'
      } }
    end

    it 'クッキーを保存しないことを確認' do
      user_login
      get :destroy
      user_login_without_remember_me
      expect(response.cookies['remember_token']).to eq nil
    end
  end
end
