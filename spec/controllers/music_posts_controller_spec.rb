require 'rails_helper'

RSpec.describe MusicPostsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:music) { create(:music_post, title: 'music-12', user_id: user.id) }
  let(:music_attributes) { attributes_for(:music_post, user_id: user.id) }

  before { session[:user_id] = user.id }

  describe 'GET #index' do
    context 'ログインしている場合' do
      let(:other_user) { create(:user) }
      let(:other_music) { create(:music_post, title: 'music-23', user_id: user.id) }

      context '検索フォームに入力しない場合' do
        before { get :index }

        it 'アクセス成功' do
          expect(response).to have_http_status(:success)
        end

        it '@feed_itemsを取得' do
          expect(assigns(:feed_items)).to match_array [music, other_music]
        end
      end

      context '検索フォームに入力する場合' do
        before { get :index, params: { title_cont: '12' } }

        it 'アクセス成功' do
          expect(response).to have_http_status(:success)
        end

        it '@feed_itemsを取得' do
          expect(assigns(:feed_items)).to eq [music]
        end
      end
    end

    context 'ログインしていない場合' do
      before do
        session[:user_id] = nil
        get :index
      end

      it 'ログインページへリダイレクト' do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'GET #show' do
    context 'ログインしている場合' do
      before { get :show, params: { id: music.id } }

      it 'アクセス成功' do
        expect(response).to have_http_status(:success)
      end

      it '@music_postを取得' do
        expect(assigns(:music_post)).to eq music
      end

      it '@userを取得' do
        expect(assigns(:user)).to eq user
      end
    end

    context 'ログインしていない場合' do
      before do
        session[:user_id] = nil
        get :show, params: { id: music.id }
      end

      it 'ログインページへリダイレクト' do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'POST #create' do
    subject { post :create, params: { music_post: music_attributes } }

    context 'ログインしている場合' do
      it '投稿数が増加' do
        expect { subject }.to change(MusicPost, :count).by(1)
      end

      it 'TOPページへリダイレクト' do
        expect(subject).to redirect_to root_path
      end
    end

    context 'ログインしていない場合' do
      before { session[:user_id] = nil }

      it '投稿数は増加しない' do
        expect { subject }.not_to change(MusicPost, :count)
      end

      it 'ログインページへリダイレクト' do
        expect(subject).to redirect_to login_path
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: music.id } }

    context 'ログインしている場合' do
      it '投稿が削除される' do
        expect { subject }.to change(MusicPost, :count).by(-1)
      end

      it 'トップページへリダイレクト' do
        expect(subject).to redirect_to root_path
      end
    end

    context 'ログインしていない場合' do
      before { session[:user_id] = nil }

      it '投稿が削除されない' do
        expect { subject }.not_to change(MusicPost, :count)
      end

      it 'ログインページへリダイレクト' do
        expect(subject).to redirect_to login_path
      end
    end
  end
end
