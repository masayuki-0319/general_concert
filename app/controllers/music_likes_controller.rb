class MusicLikesController < ApplicationController
  before_action :logged_in_user

  def create
    current_user.like(MusicPost.find(params[:music_post_id]))
    redirect_to request.referrer
  end

  def destroy
    current_user.unlike(MusicPost.find(params[:music_post_id]))
    redirect_to request.referrer
  end
end
