class MusicComment < ApplicationRecord
  belongs_to :music_post
  belongs_to :commenter, class_name: 'User'
  validates :comment, presence: true, length: { maximum: 140 }
end
