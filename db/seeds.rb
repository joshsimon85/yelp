# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
jon = User.create({ first_name: 'Jon', last_name: 'Doe', email: 'jon@doe.com', password: 'password', city: 'Boulder', state: 'Colorado', birthday: "1985-10-02" })

hapa = Business.create({
  name: 'Hapa',
  address_1: Faker::Address.street_address,
  address_2: Faker::Address.street_address,
  city: 'Boulder',
  state: 'Colorado',
  phone: "720-444-#{Faker::PhoneNumber.subscriber_number}",
  price: (1..5).to_a.sample,
  description: Faker::Lorem.paragraphs((1..30).to_a.sample).join(' '),
  tags: '@sushi, @sit down'
})

five_guys = Business.create({
  name: '5 Guys',
  address_1: Faker::Address.street_address,
  city: 'Boulder',
  state: 'Colorado',
  phone: "720-444-#{Faker::PhoneNumber.subscriber_number}",
  price: (1..5).to_a.sample,
  description: Faker::Lorem.paragraphs((1..30).to_a.sample).join(' '),
  tags: '@burgers, @beer, @sit down'
})

mcdonalds = Business.create({
  name: 'Mcdonalds',
  address_1: Faker::Address.street_address,
  address_2: Faker::Address.street_address,
  city: 'Boulder',
  state: 'Colorado',
  phone: "720-444-#{Faker::PhoneNumber.subscriber_number}",
  price: (1..5).to_a.sample,
  description: Faker::Lorem.paragraphs((1..30).to_a.sample).join(' '),
  tags: '@fastfood, @burgers'
})

burger_king = Business.create({
  name: 'Burger King',
  address_1: Faker::Address.street_address,
  address_2: Faker::Address.street_address,
  city: 'Boulder',
  state: 'Colorado',
  phone: "720-444-#{Faker::PhoneNumber.subscriber_number}",
  price: (1..5).to_a.sample,
  description: Faker::Lorem.paragraphs((1..30).to_a.sample).join(' '),
  tags: '@fastfood, @burger'
})

chipotle = Business.create({
  name: 'Chipotle',
  address_1: Faker::Address.street_address,
  address_2: Faker::Address.street_address,
  city: 'Boulder',
  state: 'Colorado',
  phone: "720-444-#{Faker::PhoneNumber.subscriber_number}",
  price: (1..5).to_a.sample,
  description: Faker::Lorem.paragraphs((1..30).to_a.sample).join(' '),
  tags: '@burriot, @sit down'
})

lyons_vet = Business.create({
  name: 'Lyons Vet Clinic',
  address_1: Faker::Address.street_address,
  address_2: Faker::Address.street_address,
  city: 'Lyons',
  state: 'Colorado',
  phone: "720-444-#{Faker::PhoneNumber.subscriber_number}",
  price: (1..5).to_a.sample,
  description: Faker::Lorem.paragraphs((1..3).to_a.sample).join(' ')
})

home_depot = Business.create({
  name: 'Home Depot',
  address_1: Faker::Address.street_address,
  address_2: Faker::Address.street_address,
  city: 'Longmont',
  state: 'Colorado',
  phone: "720-444-#{Faker::PhoneNumber.subscriber_number}",
  price: (1..5).to_a.sample,
  description: Faker::Lorem.paragraphs((1..3).to_a.sample).join(' '),
  tags: '@home, improvement'
})

lowes = Business.create({
  name: 'Lowes',
  address_1: Faker::Address.street_address,
  address_2: Faker::Address.street_address,
  city: 'Phoenix',
  state: 'Arizona',
  phone: "769-444-#{Faker::PhoneNumber.subscriber_number}",
  price: (1..5).to_a.sample,
  description: Faker::Lorem.paragraphs((1..30).to_a.sample).join(' '),
  tags: '@sushi, @sit down'
})

cemex = Business.create({
  name: 'Cemex',
  address_1: Faker::Address.street_address,
  city: 'Longmont',
  state: 'Colorado',
  phone: "1-720-444-#{Faker::PhoneNumber.subscriber_number}",
  description: Faker::Lorem.paragraphs((1..3).to_a.sample).join(' '),
  tags: '@dirty, @dusty, @load'
})
