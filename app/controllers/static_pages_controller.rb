class StaticPagesController < ApplicationController
  def home
    @music_post = current_user.music_posts.build if logged_in?
  end

  def about
  end

  def tos
  end
end
