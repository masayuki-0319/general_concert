class MusicLikesController < ApplicationController
  before_action :logged_in_user

  def create
    current_user.music_likes.create(music_post_id: params[:music_post_id])
    redirect_to request.referrer
  end

  def destroy
    current_user.music_likes.find_by(music_post_id: params[:music_post_id]).destroy
    redirect_to request.referrer
  end
end
