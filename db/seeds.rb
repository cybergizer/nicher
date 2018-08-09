puts 'Create User'

User.destroy_all
user = User.create(
  first_name: 'test',
  email: 'test@mail.ru',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: Date.today
)

puts 'Create items'

Item.destroy_all
10.times do
  Item.create(
    title: Faker::Lorem.word,
    description: Faker::Lorem.sentence(4, false),
    user_id: user.id
  )
end
