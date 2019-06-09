FactoryBot.define do
  factory :user do
    name { "main_user" }
    email { "main_user@example.com" }
  end

  factory :other_user do
    name { "other_user" }
    email { "other_user@example.com" }
  end
end
