Fabricator(:business) do
  name { Faker::Lorem.word }
  address_1 { Faker::Address.street_address }
  address_2 { Faker::Address.street_address }
  city { Faker::Address.city }
  state { Faker::Address.state }
  phone { "720-444-#{Faker::PhoneNumber.subscriber_number}" }
  price { (1..5).to_a.sample }
  tags { '@sushi @sit down'}
end
