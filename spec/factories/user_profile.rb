FactoryBot.define do
  factory :user_profile, class: 'UserProfile' do
    full_name 'Alex'
    city 'Minsk'
    description 'test'
  end

  factory :user_profile_without_a_city, class: 'UserProfile' do
    full_name 'Alex'
    description 'test'
  end

  factory :user_profile_without_a_full_name, class: 'UserProfile' do
    city 'Minsk'
    description 'test'
  end

  factory :user_profile_without_a_description, class: 'UserProfile' do
    full_name 'Alex'
    city 'Minsk'
  end
end
