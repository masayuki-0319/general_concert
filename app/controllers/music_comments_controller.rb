class MusicCommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @music_post = MusicPost.find(params[:id])
    current_user.music_comments.create(music_post_id: @music_post.id,
                                       comment: comment_params)
    redirect_to @music_post
  end

  def destroy
    @music_post = MusicPost.find(params[:id])
    current_user.music_comments.find_by(id: params[:music_comment_id]).destroy
    redirect_to @music_post
  end

  private

  def comment_params
    params.require(:music_comment).permit(:comment)
  end
end
