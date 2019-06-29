require 'rails_helper'

RSpec.describe MusicLikesController, type: :controller do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:other_music) { create(:music_post, user_id: other_user.id) }

  before { session[:user_id] = user.id }

  describe 'POST #create' do
    subject { post :create, params: { music_post_id: other_music.id } }

    context 'ログイン後の場合' do
      it 'いいね！が生成される' do
        expect { subject }.to change(MusicLike, :count).by(1)
      end
    end

    context 'ログイン前の場合' do
      before { session[:user_id] = nil }

      it 'いいね！は生成されない' do
        expect { subject }.not_to change(MusicLike, :count)
      end

      it 'ログインページへリダイレクト' do
        expect(subject).to redirect_to login_path
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: like.id, music_post_id: other_music.id } }

    let!(:like) { create(:music_like, liker_id: user.id, music_post_id: other_music.id) }

    context 'ログイン後の場合' do
      it 'いいね！が解除される' do
        expect { subject }.to change(MusicLike, :count).by(-1)
      end
    end

    context 'ログイン前の場合' do
      before { session[:user_id] = nil }

      it 'いいね！は解除されない' do
        expect { subject }.not_to change(MusicLike, :count)
      end

      it 'ログインページへリダイレクト' do
        expect(subject).to redirect_to login_path
      end
    end
  end
end
