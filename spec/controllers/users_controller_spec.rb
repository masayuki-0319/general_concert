require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let(:valid_user) { attributes_for(:user) }
  let(:invalid_user) { attributes_for(:user, name: nil) }

  describe "GET #index" do
    context '未ログインの場合' do
      before { get :index }

      it 'アクセス失敗してリダイレクト' do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET #show" do
    let!(:music) { 2.times { create(:music_post, user_id: user.id) } }

    before { get :show, params: { id: user.id } }

    it 'アクセス成功' do
      expect(response).to have_http_status(:success)
    end

    it '@userの取得' do
      expect(assigns(:user)).to eq user
    end

    it '@music_postsの取得' do
      expect(assigns(:music_posts).count).to eq user.music_posts.count
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
        expect(subject).to redirect_to(User.last)
      end
    end

    context '@userが異常値で登録が失敗する場合' do
      subject { post :create, params: { user: invalid_user } }

      it 'User数は不変' do
        expect { subject }.not_to change(User, :count)
      end

      it '登録画面ににリダイレクト' do
        expect(subject).to render_template 'new'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:admin_user) { create(:admin_user) }
    let!(:other_user) { create(:user) }
    let!(:another_user) { create(:user) }

    context '未ログインのユーザが削除する場合' do
      it '削除が失敗' do
        expect { delete :destroy, params: { id: other_user.id } }.not_to change(User, :count)
      end
    end

    context '管理者権限を持たないユーザが削除する場合' do
      before { session[:user_id] = other_user.id }

      it '削除が失敗' do
        expect { delete :destroy, params: { id: another_user.id } }.not_to change(User, :count)
      end
    end

    context '管理者権限を持つユーザが削除する場合' do
      before { session[:user_id] = admin_user.id }

      it '削除が成功' do
        expect { delete :destroy, params: { id: other_user.id } }.to change(User, :count).by(-1)
      end
    end
  end

  context '#ログイン済みでない場合' do
    context 'ユーザ編集関係' do
      it 'user#editにアクセス不可' do
        get :edit, params: { id: user.id }
        expect(flash[:danger]).to be_present
        expect(response).to redirect_to login_path
      end

      it 'user#updateにアクセス不可' do
        patch :update, params: { id: user.id, user: { name: 'Changing Name' } }
        expect(flash[:danger]).to be_present
        expect(user.reload.name).not_to eq 'Changing Name'
        expect(response).to redirect_to login_path
      end
    end

    context 'フォローページ関係' do
      it 'user#followingにアクセス不可' do
        get :following, params: { id: user.id }
        expect(response).to redirect_to login_path
      end

      it 'user#followersにアクセス不可' do
        get :followers, params: { id: user.id }
        expect(response).to redirect_to login_path
      end
    end
  end

  context '#異なるユーザがログインする場合' do
    let(:other_user) { create(:user) }

    before { session[:user_id] = other_user.id }

    it 'user#editにアクセス不可' do
      get :edit, params: { id: user.id }
      expect(response).to redirect_to root_path
    end

    it 'user#updateにアクセス不可' do
      patch :update, params: { id: user.id, user: { name: 'Changing Name' } }
      expect(user.reload.name).not_to eq 'Changing Name'
      expect(response).to redirect_to root_path
    end
  end

  context '#フレンドリーフォワーディング' do
    it 'ログインページへ遷移し，Session情報が保存される' do
      get :edit, params: { id: user.id }
      expect(response).to redirect_to login_path
      expect(session[:forwarding_url]).to eq edit_user_url(user)
    end
  end

  context '#管理者権限' do
    before { session[:user_id] = user.id }

    it '変更不可' do
      expect(user.admin).to be_falsey
      patch :update, params: { id: user.id, user: { admin: true } }
      expect(user.admin).to be_falsey
    end
  end
end
