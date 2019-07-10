require 'rails_helper'

RSpec.describe MusicCommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:music) { create(:music_post, user_id: user.id) }
  let(:comment_attributes) { attributes_for(:music_comment) }
  let!(:comment) { create(:music_comment, commenter_id: user.id, music_post_id: music.id) }

  before { session[:user_id] = user.id }

  describe 'POST #create' do
    subject { post :create, params: { id: music.id, music_comment: comment_attributes } }

    context 'ログインしている場合' do
      it '投稿数が増加' do
        expect { subject }.to change(MusicComment, :count).by(1)
      end

      it 'ページ更新' do
        expect(subject).to redirect_to music
      end
    end

    context 'ログインしていない場合' do
      before { session[:user_id] = nil }

      it '投稿数は増加しない' do
        expect { subject }.not_to change(MusicComment, :count)
      end

      it 'ログインページへリダイレクトされる。' do
        expect(subject).to redirect_to login_path
      end
    end
  end

  describe "POST #destroy" do
    subject { delete :destroy, params: { id: music.id, music_comment_id: comment.id } }

    context 'ログインしている場合' do
      it '投稿が削除される。' do
        expect { subject }.to change(MusicComment, :count).by(-1)
      end

      it 'ページ更新' do
        expect(subject).to redirect_to music
      end
    end

    context 'ログインしていない場合' do
      before { session[:user_id] = nil }

      it '投稿が削除されない。' do
        expect { subject }.not_to change(MusicComment, :count)
      end

      it 'ログインページへリダイレクトされる。' do
        expect(subject).to redirect_to login_path
      end
    end
  end
end
