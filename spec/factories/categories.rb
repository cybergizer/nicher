FactoryBot.define do
  factory :category do
    name 'Clothes'
  end

  factory :invalid_category, class: 'Category' do
    name nil
  end

  factory :new_category, class: 'Category' do
    name 'Toys'
  end
end
