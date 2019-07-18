# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
jon = User.create({ first_name: 'Jon', last_name: 'Doe', email: 'jon@doe.com', password: 'password', city: 'Boulder', state: 'Colorado', birthday: '1985-10-02' })
jane = User.create({ first_name: 'Jane', last_name: 'Doe', email: 'Jane@doe.com', password: 'password', city: 'Denver', state: 'Colorado', birthday: '1960-12-25' })
carrie = User.create({ first_name: 'Carrie', last_name: 'Doe', email: 'carrie@doe.com', password: 'password', city: 'Longmont', state: 'Colorado', birthday: '1959-09-10' })
josh = User.create({ first_name: 'Josh', last_name: 'Doe', email: 'josh@doe.com', password: 'password', city: 'Lyons', state: 'Colorado', birthday: '1959-09-10' })
tammy  = User.create({ first_name: 'Tammy', last_name: 'Doe', email: 'tammy@doe.com', password: 'password', city: 'Pinewood Springs', state: 'Colorado', birthday: '1959-09-10' })

hapa = Business.create({
  name: 'Hapa',
  address_1: Faker::Address.street_address,
  address_2: Faker::Address.street_address,
  city: 'Boulder',
  state: 'Colorado',
  phone: "720-444-#{Faker::PhoneNumber.subscriber_number}",
  price: (1..5).to_a.sample,
  description: Faker::Lorem.paragraphs((1..30).to_a.sample).join(' '),
  tags: '@sushi, @sit down',
  user_id: jon.id
})

five_guys = Business.create({
  name: '5 Guys',
  address_1: Faker::Address.street_address,
  city: 'Boulder',
  state: 'Colorado',
  phone: "720-444-#{Faker::PhoneNumber.subscriber_number}",
  price: (1..5).to_a.sample,
  description: Faker::Lorem.paragraphs((1..30).to_a.sample).join(' '),
  tags: '@burgers, @beer, @sit down',
  user_id: jon.id
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
  tags: '@fastfood, @burgers',
  user_id: jane.id
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
  tags: '@fastfood, @burger',
  user_id: carrie.id
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
  tags: '@burriot, @sit down',
  user_id: josh.id
})

lyons_vet = Business.create({
  name: 'Lyons Vet Clinic',
  address_1: Faker::Address.street_address,
  address_2: Faker::Address.street_address,
  city: 'Lyons',
  state: 'Colorado',
  phone: "720-444-#{Faker::PhoneNumber.subscriber_number}",
  price: (1..5).to_a.sample,
  description: Faker::Lorem.paragraphs((1..3).to_a.sample).join(' '),
  user_id: tammy.id
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
  tags: '@home, improvement',
  user_id: tammy.id
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
  tags: '@sushi, @sit down',
  user_id: carrie.id
})

cemex = Business.create({
  name: 'Cemex',
  address_1: Faker::Address.street_address,
  city: 'Longmont',
  state: 'Colorado',
  phone: "1-720-444-#{Faker::PhoneNumber.subscriber_number}",
  description: Faker::Lorem.paragraphs((1..3).to_a.sample).join(' '),
  tags: '@dirty, @dusty, @load',
  user_id: josh.id
})

Review.create({
  body: Faker::Lorem.paragraphs((1..30).to_a.sample).join(' '),
  user_id: jon.id,
  business_id: hapa.id,
  rating: (1..5).to_a.sample
})

Review.create({
  body: Faker::Lorem.paragraphs((1..30).to_a.sample).join(' '),
  user_id: jane.id,
  business_id: hapa.id,
  rating: (1..5).to_a.sample
})

Review.create({
  body: Faker::Lorem.paragraphs((1..30).to_a.sample).join(' '),
  user_id: tammy.id,
  business_id: lyons_vet.id,
  rating: (1..5).to_a.sample
})

Review.create({
  body: Faker::Lorem.paragraphs((1..30).to_a.sample).join(' '),
  user_id: tammy.id,
  business_id: lyons_vet.id,
  rating: (1..5).to_a.sample
})

Review.create({
  body: Faker::Lorem.paragraphs((1..30).to_a.sample).join(' '),
  user_id: josh.id,
  business_id: lyons_vet.id,
  rating: (1..5).to_a.sample
})
