class MusicPostsController < ApplicationController
  before_action :logged_in_user,  only: [:create, :destroy]
  before_action :correct_user,    only: [:destroy]

  def create
    @music_post = current_user.music_posts.build(music_post_params)
    if @music_post.save
      flash[:success] = '投稿を完了しました。'
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @music_post.destroy
    flash[:success] = '動画を削除しました。'
    redirect_to request.referrer || root_path
  end

  private

  def music_post_params
    params.require(:music_post).permit(:title, :iframe)
  end

  def correct_user
    @music_post = current_user.music_posts.find_by(id: params[:id])
    redirect_to root_path if @music_post.nil?
  end
end