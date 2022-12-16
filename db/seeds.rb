# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'Seeding started'

puts 'Cleaning database...'
User.destroy_all
List.destroy_all
# UserList.destroy_all
# Item.destroy_all
puts 'Cleaning done'

puts 'Creating users...'
User.create!(first_name: 'User 1', email: 'user1@mail.com', password: '123456')
User.create!(first_name: 'User 2', email: 'user2@mail.com', password: '123456')
User.create!(first_name: 'User 3', email: 'user3@mail.com', password: '123456')
puts 'Users done'

puts 'Creating lists and user_lists...'
List.create!(name: 'List 1', comment: 'Comment list 1')
UserList.create!(list: List.find(1), user: User.find(1), admin: true)
UserList.create!(list: List.find(1), user: User.find(2), admin: false)

List.create!(name: 'List 2', comment: 'Comment list 2')
UserList.create!(list: List.find(2), user: User.find(2), admin: true)
UserList.create!(list: List.find(2), user: User.find(1), admin: false)

List.create!(name: 'List 3', comment: 'Comment list 3')
UserList.create!(list: List.find(3), user: User.find(3), admin: true)
puts 'Lists and user_lists done'

puts 'Creating items...'
Item.create!(name: 'Item a', amount: '1 u.', list: List.find(1))
Item.create!(name: 'Item b', amount: '2 u.', list: List.find(1))
Item.create!(name: 'Item c', amount: '3 u.', list: List.find(1))

Item.create!(name: 'Item d', amount: '4 u.', list: List.find(2))
Item.create!(name: 'Item e', amount: '5 u.', list: List.find(2))
Item.create!(name: 'Item f', amount: '6 u.', list: List.find(2))

Item.create!(name: 'Item g', amount: '7 u.', list: List.find(3))
puts 'Items done'

puts 'Seeding finish'
