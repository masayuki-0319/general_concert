class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @music_post = current_user.music_posts.build
      @feed_items = current_user.feed.paginate(page: params[:page]).includes(:user)
    end
  end

  def about
  end

  def tos
  end
end
