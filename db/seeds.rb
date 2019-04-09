# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name: 'Alvin',
  email: 'alvin@alvin.com',
  password: 'aaaaaa'
)

Ingredient.create!(
  name: 'chicken'
)

Dose.create!(
  value: 0
  unit: 0
)

Meal.create!(
  title: 'Tuesday dinner'
  image_url: 'https://baconmockup.com/640/360'
)

