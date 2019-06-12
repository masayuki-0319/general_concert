FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "#{n}-user" }
    sequence(:email) { |n| "#{n}-user@example.com" }
    password { "password" }
    password_confirmation { "password" }
    password_digest { User.digest('password') }
  end
end
