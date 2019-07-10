class MusicPostsController < ApplicationController
  before_action :logged_in_user,  only: [:index, :show, :create, :destroy]
  before_action :correct_user,    only: [:destroy]

  def index
    @q = MusicPost.ransack(params[:q])
    @feed_items = @q.result(distinct: true).paginate(page: params[:page], per_page: 10).includes(:user)
  end

  def show
    @music_post = MusicPost.find(params[:id])
    @user = User.find(@music_post.user_id)
    @music_comment = current_user.music_comments.build
    @music_comments = @music_post.music_comments.includes(:commenter)
  end

  def create
    @music_post = current_user.music_posts.build(music_post_params)
    if @music_post.save
      flash[:success] = '投稿を完了しました。'
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @music_post.destroy
    flash[:success] = '動画を削除しました。'
    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js
    end
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
