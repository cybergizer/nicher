puts 'Create users'

User.destroy_all
User.create(
  email: 'test@mail.ru',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: Date.today
)

User.create(
  email: 'test2@mail.ru',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: Date.today
)

puts 'Create Admin'
admin = User.create(
  first_name: 'admin',
  email: 'root@admin',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: Date.today
)
admin.add_role 'admin'

UserProfile.destroy_all
user1 = User.first
user1.sign_in_count = 2
user1.save
user2 = User.first
user2.sign_in_count = 2
user2.save
UserProfile.create(first_name: 'Vadim', city: 'Minsk', description: 'I am from Gomel', user: User.first)
UserProfile.create(first_name: 'Sasha', city: 'Minsk', description: 'I am from Luninetz', user: User.last)

puts 'Create categories'

Category.destroy_all

CATEGORIES_ROOTS = %w[Technique Sport Instruments Clothes].freeze

categories_models = []

CATEGORIES_ROOTS.each do |category|
  categories_models << Category.create(name: category, user: User.first)
end

NESTED_CATEGORY = {
  'Socks' => { parent: categories_models[3] },
  'Apple' => { parent: categories_models[0] }
}.freeze

NESTED_CATEGORY.each do |category, data|
  categories_models << Category.create(name: category, user: User.first, parent: data[:parent])
end

puts 'Create niches'

Niche.destroy_all

NICHES = %w[Home Balcony Garage].freeze

niches_models = []

NICHES.each do |niche|
  niches_models << Niche.create(name: niche, user: User.first)
end

puts 'Create items'

ITEMS = {
  'Watch' => { description: 'My favorite apple watch.', category: categories_models[5], niche: niches_models[0] },
  'Mac' => { description: 'My favorite mac.', category: categories_models[5], niche: niches_models[0] },
  'PC' => { description: 'My acer 5407.', category: categories_models[0], niche: niches_models[0] },
  'Ball' => { description: 'League champions ball', category: categories_models[1], niche: niches_models[1] },
  'Socks' => { description: 'Red socks', category: categories_models[4], niche: niches_models[0] },
  'Jeans' => { description: 'Colins jeans', category: categories_models[3], niche: niches_models[0] },
  'Back' => { description: 'DC Shoes back', category: categories_models[3], niche: niches_models[1] },
  'Snickers' => { description: 'Nike snickers', category: categories_models[3], niche: niches_models[1] },
  'Gas wrench' => { description: 'My key on 13', category: categories_models[2], niche: niches_models[2] }
}.freeze

Item.destroy_all

ITEMS.each do |title, data|
  Item.create(
    title: title,
    description: data[:description],
    category: data[:category],
    niche: data[:niche],
    user: User.first
  )
end
