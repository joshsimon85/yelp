# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
jon = User.create({ first_name: 'Jon', last_name: 'Doe', email: 'jon@doe.com', password: 'password', city: 'Boulder', state: 'Colorado', birthday: "1985-10-02" })
