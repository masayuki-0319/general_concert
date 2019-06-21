require 'rails_helper'

RSpec.describe MusicPostsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:music) { create(:music_post, user_id: user.id) }
  let(:music_attributes) { attributes_for(:music_post, user_id: user.id) }

  before { session[:user_id] = user.id }

  describe 'POST #create' do
    subject { post :create, params: { music_post: music_attributes } }

    context 'ログインしている場合' do
      it '投稿数が増加' do
        expect { subject }.to change(MusicPost, :count).by(1)
      end

      it 'TOPページへリダイレクト' do
        subject
        expect(response).to redirect_to root_path
      end
    end

    context 'ログインしていない場合' do
      before { session[:user_id] = nil }

      it '投稿数は増加しない' do
        expect { subject }.not_to change(MusicPost, :count)
      end

      it 'ログインページへリダイレクト' do
        subject
        expect(response).to redirect_to login_path
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
        subject
        expect(response).to redirect_to root_path
      end
    end

    context 'ログインしていない場合' do
      before { session[:user_id] = nil }

      it '投稿が削除されない' do
        expect { subject }.not_to change(MusicPost, :count)
      end

      it 'ログインページへリダイレクト' do
        subject
        expect(response).to redirect_to login_path
      end
    end
  end
end
