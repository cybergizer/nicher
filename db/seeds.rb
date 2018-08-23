puts 'Create User'

User.destroy_all
User.create(
  first_name: 'Vadim',
  email: 'test@mail.ru',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: Date.today
)

User.create(
  first_name: 'Sasha',
  email: 'test2@mail.ru',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: Date.today
)

UserProfile.destroy_all
user1 = User.first
user1.sign_in_count = 2
user1.save
user2 = User.first
user2.sign_in_count = 2
user2.save
UserProfile.create(full_name: 'Vadim', city: 'Minsk', description: 'I am from Gomel', user: User.first)
UserProfile.create(full_name: 'Sasha', city: 'Minsk', description: 'I am from Luninetz', user: User.last)

puts 'Create categories'

Category.destroy_all

CATEGORIES_ROOTS = %w[Technique Sport Instruments Clothes].freeze

CATEGORIES_MODELS = []

CATEGORIES_ROOTS.each do |category|
  CATEGORIES_MODELS << Category.create(name: category, user: User.first)
end

NESTED_CATEGORY = {
  'Socks' => { parent: CATEGORIES_MODELS[3] },
  'Apple' => { parent: CATEGORIES_MODELS[0] }
}.freeze

NESTED_CATEGORY.each do |category, data|
  CATEGORIES_MODELS << Category.create(name: category, user: User.first, parent: data[:parent])
end

puts 'Create niches'

Niche.destroy_all

NICHES = %w[Home Balcony Garage].freeze

NICHES_MODELS = []

NICHES.each do |niche|
  NICHES_MODELS << Niche.create(name: niche, user: User.first)
end

puts 'Create items'

ITEMS = {
  'Watch' => { description: 'My favorite apple watch.', category: CATEGORIES_MODELS[5], niche: NICHES_MODELS[0] },
  'Mac' => { description: 'My favorite mac.', category: CATEGORIES_MODELS[5], niche: NICHES_MODELS[0] },
  'PC' => { description: 'My acer 5407.', category: CATEGORIES_MODELS[0], niche: NICHES_MODELS[0] },
  'Ball' => { description: 'League champions ball', category: CATEGORIES_MODELS[1], niche: NICHES_MODELS[1] },
  'Socks' => { description: 'Red socks', category: CATEGORIES_MODELS[4], niche: NICHES_MODELS[0] },
  'Jeans' => { description: 'Colins jeans', category: CATEGORIES_MODELS[3], niche: NICHES_MODELS[0] },
  'Back' => { description: 'DC Shoes back', category: CATEGORIES_MODELS[3], niche: NICHES_MODELS[1] },
  'Snickers' => { description: 'Nike snickers', category: CATEGORIES_MODELS[3], niche: NICHES_MODELS[1] },
  'Gas wrench' => { description: 'My key on 13', category: CATEGORIES_MODELS[2], niche: NICHES_MODELS[2] }
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
