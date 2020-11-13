# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'
require 'faker'

puts 'Ingredients seeding'
puts 'Cleaning database...'
Ingredient.destroy_all

puts 'Creating ingredients..."-'

Ingredient.create(name: "Ice")
Ingredient.create(name: "Mint leaves")
url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_serialized = open(url).read
ingredients = JSON.parse(ingredients_serialized)['drinks']
ingredients.each do |ingredient|
  Ingredient.create(name: ingredient['strIngredient1'])
end

puts 'Cocktails seeding'
puts 'Cleaning database...'
Cocktail.destroy_all

puts 'Creating cocktails..."-'

50.times { Cocktail.create(name: Faker::ProgrammingLanguage.unique.name) }

puts 'Doses seeding'
puts 'Cleaning database...'
Dose.destroy_all

puts 'Creating doses..."-'
cocktails = Cocktail.all
ingredients = Ingredient.all
cocktails.each do |cocktail|
  5.times {
    description = rand(1..5)
    dose = Dose.new(description: description)
    dose.cocktail = cocktail
    ingredient = ingredients[rand(1..ingredients.length)]
    dose.ingredient = ingredient
    dose.save
  }
end

puts 'Finished!'
