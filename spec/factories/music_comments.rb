FactoryBot.define do
  factory :music_comment do
    sequence(:comment) { |n| "#{n}-Test" }
    commenter_id { '' }
    music_post_id { '' }
  end
end
