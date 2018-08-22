FactoryBot.define do
  sequence :email do |n|
    "test#{n}@gmail.com"
  end

  factory :user do
    first_name 'test'
    email
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
    after :create do |user|
      create :user_profile, user: user
    end
  end
end
