require 'rails_helper'

RSpec.describe MusicPostsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:music) { create(:music_post, user_id: user.id) }
  let(:music_attributes) { build(:music_post, user_id: user.id) }

  before { session[:user_id] = user.id }

  describe 'POST #create' do
    context 'ログインしていない場合' do
      subject { post :create, params: { music_post: music_attributes } }

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
    context 'ログインしていない場合' do
      subject { delete :destroy, params: { id: music.id } }

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
