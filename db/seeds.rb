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
Cocktail.destroy_all
Ingredient.destroy_all
#Dose.destroy_all

puts 'Ingredients seeding'
puts 'Cleaning database...'


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


puts 'Creating cocktails..."-'

50.times do
  file = URI.open('https://giantbomb1.cbsistatic.com/uploads/original/9/99864/2419866-nes_console_set.png')
  cocktail = Cocktail.new(name: Faker::ProgrammingLanguage.unique.name)
  cocktail.url = "ajldwzjt25gm8mts0jbz"
  cocktail.save!
  p cocktail
  #cocktail.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
end

puts 'Doses seeding'
puts 'Cleaning database...'


puts 'Creating doses..."-'
cocktails = Cocktail.all
ingredients = Ingredient.all
cocktails.each do |cocktail|
  5.times do
    description = rand(1..5)
    dose = Dose.new(description: description)
    dose.cocktail = cocktail
    ingredient = ingredients[rand(1..ingredients.length)]
    dose.ingredient = ingredient
    dose.save
  end
end

puts 'Finished!'
