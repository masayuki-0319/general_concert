class MusicLikesController < ApplicationController
  before_action :logged_in_user
  before_action :like_target

  def create
    current_user.like(@music_post_id)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js
    end
  end

  def destroy
    current_user.unlike(@music_post_id)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js
    end
  end

  private

  def like_target
    @music_post_id = MusicPost.find(params[:music_post_id])
    @user = User.find(@music_post_id.user_id)
  end
end
