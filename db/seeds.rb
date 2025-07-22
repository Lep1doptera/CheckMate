# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

puts "Cleaning Database"

Chore.destroy_all
Costing.destroy_all
User.destroy_all
Household.destroy_all

puts 'Database Clean'
puts 'Generating Household'

household = Household.create!(name: "First Home")

puts "Household Created"
puts "Generating Users"

user1 = User.create!(
  name: "User 1",
  email: "test1@test.com",
  password: 'password',
  household: household
)

user2 = User.create!(
  name: "User 2",
  email: "test2@test.com",
  password: 'password',
  household: household
)

# User without house
user3 = User.create!(
  name: "User 3",
  email: "test3@test.com",
  password: 'password',
  household_id: nil
)

puts "Users Created"
puts "Generating Chores"

5.times do
  completed = [true, false].sample
  Chore.create!(
    name: "#{Faker::Verb.base.capitalize} the #{Faker::House.room}",
    description: Faker::Lorem.sentence,
    assigned: [true, false].sample,
    completed: completed,
    date_created: Faker::Date.backward(days: 10),
    date_to_be_completed: Faker::Date.forward(days: 5),
    completion_date: completed ? Faker::Date.forward(days: 5) : nil,
    user: [user1, user2].sample,
    household: household
  )
end

puts "Database Seeded!"
