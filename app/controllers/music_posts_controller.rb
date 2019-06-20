class MusicPostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @music_post = current_user.music_posts.build(music_post_params)
    if @music_post.save
      flash[:success] = '投稿を完了しました。'
      redirect_to root_path
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

  def music_post_params
    params.require(:music_post).permit(:title, :iframe)
  end
end
