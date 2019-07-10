class MusicCommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @music_post = MusicPost.find(params[:id])
    current_user.music_comments.create(music_post_id: @music_post.id,
                                       comment: params[:music_comment][:comment])
    redirect_to @music_post
  end

  def destroy
    @music_comment = MusicComment.find(params[:id])
    @music_post = MusicPost.find(@music_comment.music_post_id)
    @music_comment.destroy
    redirect_to @music_post
  end
end
