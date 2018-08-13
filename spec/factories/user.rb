FactoryBot.define do
  factory :user, aliases: %i[author] do
    first_name "Joe"
    email "joe@gmail.com"
    password "123456"
  end
end
