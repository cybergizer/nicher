FactoryBot.define do
  factory :item do
    title 'Socks'
  end

  factory :invalid_item, class: 'Item' do
    title nil
  end

  factory :new_item, class: 'Item' do
    title 'Watch'
  end
end
