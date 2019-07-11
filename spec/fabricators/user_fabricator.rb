Fabricator(:user) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  email { Faker::Internet.email }
  password { Faker::Internet.password }
  city { Faker::Lorem.word }
  state { Faker::Lorem.word }
  birthday { Faker::Date.birthday.to_s }
end
