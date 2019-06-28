class MusicLikeController < ApplicationController
  before_action :logged_in_user

  def create
    @like = MusicLike.new(liker_id: @current_user.id, music_post_id: params[:id])
    @like.save
    respond_to do |format|
      format.html { redirect_to music_post_path(MusicPost.find(params[:id])) }
      format.js
    end
  end

  def destroy
    @like = MusicLike.find_by(liker_id: @current_user, music_post_id: params[:id])
    @like.destroy
    respond_to do |format|
      format.heml { redirect_to music_post_path(MusicPost.find(params[:id])) }
      format.js
    end
  end
end
