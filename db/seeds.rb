require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts 'Cleaning database...'
User.destroy_all
MealPlan.destroy_all
Ingredient.destroy_all
Dose.destroy_all
Meal.destroy_all

user = User.create!(
  name: 'Alvin',
  email: 'alvin@alvin.com',
  password: 'aaaaaa'
)

meal_plan = MealPlan.new()
meal_plan.user = user
meal_plan.save

10.times do

  ingredient = Ingredient.new(
    name: Faker::Food.vegetables
    )

  ingredient.save

  dose = Dose.new(
    value: rand(1..10),
    unit: 'g'
    )

  dose.ingredient = ingredient
  dose.meal_plan = meal_plan

  dose.save

end

5.times do

  meal = Meal.new(
    title: Faker::Food.dish,
    meal_id: rand(1..10),
    image_url: 'https://baconmockup.com/640/360'
    )

  meal.meal_plan = meal_plan
  meal.save
end

