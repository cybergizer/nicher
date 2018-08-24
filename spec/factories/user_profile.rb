FactoryBot.define do
  factory :user_profile, class: 'UserProfile' do
    first_name 'Alex'
    city 'Minsk'
    description 'test'
  end

  factory :user_profile_without_a_first_name, class: 'UserProfile' do
    city 'Minsk'
    description 'test'
  end
end
