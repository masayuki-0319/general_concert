require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:signin_user) { create(:user) }
  let(:valid_user) { attributes_for(:user) }
  let(:invalid_user) { attributes_for(:user, name: nil) }

  describe "GET #show" do
    before { get :show, params: { id: signin_user.id } }

    it 'アクセス成功' do
      expect(response).to have_http_status(:success)
    end

    it '@userの取得' do
      expect(assigns(:user)).to eq signin_user
    end
  end

  describe "GET #new" do
    before { get :new }

    it 'アクセス成功' do
      expect(response).to have_http_status(:success)
    end

    it '@userの生成' do
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST #create" do
    context '@userが正常値で登録完了する場合' do
      subject { post :create, params: { user: valid_user } }

      it 'User数が増加' do
        expect { subject }.to change(User, :count).by(1)
      end

      it 'フラッシュメッセージ生成' do
        subject
        expect(flash[:success]).to include '登録成功'
      end

      it 'ユーザ詳細画面にリダイレクト' do
        subject
        expect(response).to redirect_to(User.last)
      end
    end

    context '@userが異常値の場合' do
      subject { post :create, params: { user: invalid_user } }

      it 'User数は不変' do
        expect { subject }.not_to change(User, :count)
      end

      it '登録画面ににリダイレクト' do
        subject
        expect(response).to render_template 'new'
      end
    end
  end
end
