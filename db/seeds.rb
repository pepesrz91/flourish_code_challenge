# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

bank = Bank.new("Coolest Bank Ever")
bank.save



user1 = User.new(name:"Jose", password:"SuperSecurePassword", bank_id: bank.id)
user1.save

user