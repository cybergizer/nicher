FactoryBot.define do
  factory :niche do
    name 'Home'
  end

  factory :invalid_niche, class: 'Niche' do
    name nil
  end

  factory :new_niche, class: 'Niche' do
    name 'Garage'
  end
end
