class MusicLikesController < ApplicationController
  before_action :logged_in_user

  def create
    @music_post_id = MusicPost.find(params[:music_post_id])
    current_user.like(@music_post_id)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js
    end
  end

  def destroy
    @music_post_id = MusicPost.find(params[:music_post_id])
    current_user.unlike(MusicPost.find(params[:music_post_id]))
    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js
    end
  end
end
