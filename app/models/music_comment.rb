class MusicComment < ApplicationRecord
  belongs_to :music_post
  belongs_to :commenter, class_name: 'User'
end
