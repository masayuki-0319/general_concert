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
    context '@userが正常値で登録が成功する場合' do
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

    context '@userが異常値で登録が失敗する場合' do
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

  describe "GET #edit" do
    before { get :edit, params: { id: signin_user.id } }

    it 'アクセス成功' do
      expect(response).to have_http_status(:success)
    end

    it '@userの取得' do
      expect(assigns(:user)).to eq signin_user
    end
  end

  describe "PATCH #update" do
    before { get :edit, params: { id: signin_user.id } }

    context '正常値で編集が成功する場合，' do
      before do
        user_params = attributes_for(:user, name: 'Name for After Changing', email: 'chan@ge.com')
        patch :update, params: { id: signin_user.id, user: user_params }
      end

      it 'ユーザ情報が更新成功' do
        expect(signin_user.reload.name).to eq 'Name for After Changing'
        expect(signin_user.reload.email).to eq 'chan@ge.com'
      end

      it 'フラッシュメッセージが生成' do
        expect(flash[:success]).to include '編集成功'
      end

      it 'ユーザ詳細画面にリダイレクト' do
        expect(response).to have_http_status 302
      end
    end

    context '異常値の場合で編集が失敗する場合，' do
      before do
        user_params = attributes_for(:user, name: 'Name for After Changing', email: '@@@@@')
        patch :update, params: { id: signin_user.id, user: user_params }
      end

      it 'ユーザ情報が更新失敗' do
        expect(signin_user.reload.name).not_to eq 'Name for After Changing'
        expect(signin_user.reload.email).not_to eq 'Email for After Changing'
      end

      it '登録画面ににリダイレクト' do
        expect(response).to render_template 'edit'
        expect(response).to have_http_status 200
      end
    end
  end
end
