FactoryBot.define do
  factory :user_relationship do
    follower_id { 1 }
    followed_id { 1 }
  end
end
