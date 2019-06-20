FactoryBot.define do
  factory :user, class: 'User' do
    sequence(:name) { |n| "#{n}-user" }
    sequence(:email) { |n| "#{n}-user@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    password_digest { User.digest('password') }
  end

  factory :admin_user, class: 'User' do
    name { 'admin-user' }
    email { 'admin@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    password_digest { User.digest('password') }
    admin { true }
  end
end
