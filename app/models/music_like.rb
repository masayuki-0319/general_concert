class MusicLike < ApplicationRecord
  belongs_to :music_post
  belongs_to :liker, class_name: 'User'
end
