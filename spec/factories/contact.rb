FactoryBot.define do
  factory :contact do
    name 'Vadim'
  end

  factory :new_contact, class: 'Contact' do
    name 'John'
  end

  factory :invalid_contact, class: 'Contact' do
    name nil
  end
end