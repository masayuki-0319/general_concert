class MusicPost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  VALID_IFRAME_REGEX = /\A<iframe[\w+\-\/:<>=";\. ]+<\/iframe>\z/
  validates :iframe, presence: true, length: { maximum: 300 },
                     format: { with: VALID_IFRAME_REGEX }
end
