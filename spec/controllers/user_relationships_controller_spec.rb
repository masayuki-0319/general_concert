require 'rails_helper'

RSpec.describe UserRelationshipsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:follower) { create(:user_relationship, follower_id: user.id, followed_id: another_user.id) }

  describe '#create' do
    subject { post :create, params: { followed_id: other_user.id } }

    context 'ログイン前の場合' do
      it 'フォロー数は変化しない。' do
        expect { subject }.not_to change(UserRelationship, :count)
      end

      it 'ログインページへリダイレクトする。' do
        expect(subject).to redirect_to login_path
      end
    end

    context 'ログイン後の場合' do
      before { session[:user_id] = user.id }

      it 'フォロー数が増加する。' do
        expect { subject }.to change(UserRelationship, :count).by(1)
      end
    end
  end

  describe '#destroy' do
    subject { delete :destroy, params: { id: follower.id } }

    context 'ログイン前の場合' do
      it 'フォローは削除されない。' do
        expect { subject }.not_to change(UserRelationship, :count)
      end

      it 'ログインページへリダイレクトする。' do
        expect(subject).to redirect_to login_path
      end
    end

    context 'ログイン後の場合' do
      before { session[:user_id] = user.id }

      it 'フォローが削除される。' do
        expect { subject }.to change(UserRelationship, :count).by(-1)
      end
    end
  end
end
