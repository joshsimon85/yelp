Fabricator(:review) do
  body {Faker::Lorem.paragraphs((1..3).to_a.sample).join(' ') }
  rating { (1..5).to_a.sample }
  user_id { Faker::Number.number(1).to_i }
  business_id { Faker::Number.number(1).to_i }
end
