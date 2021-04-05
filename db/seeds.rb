# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

bank = Bank.create(name: "Coolest Bank Ever")
bank.save

reward1 = Reward.create(name: "2 Movie Tickets", price: 1500, bank_id: bank.id)
reward1.save

reward2 = Reward.create(name: "Free Massage", price: 1000, bank_id: bank.id)
reward2.save

user1 = User.create(name: "Jose", password: "SuperSecurePassword", bank_id: bank.id, username: "pepesrz")
user1.save
user1_reward_manager = RewardManager.create(user_id: user1.id, points: 2000, login_streak: 0)
user1_reward_manager.save

user2 = User.create(name: "Pedro", password: "CoolestPassword", bank_id: bank.id, username: "pedro2021")
user2.save
user2_reward_manager = RewardManager.create(user_id: user2.id, points: 1200, login_streak: 0)
user2_reward_manager.save

user3 = User.create(name: "Jessica", password: "CoolestPassword", bank_id: bank.id, username: "jessica2021")
user3.save
user3_reward_manager = RewardManager.create(user_id: user3.id, points: 500, login_streak: 0)
user3_reward_manager.save

user4 = User.create(name: "Dummy", password: "DummyPassword", bank_id: bank.id, username: "dummyuser")
user4.save
user4_reward_manager = RewardManager.create(user_id: user4.id, points: 600, login_streak: 5)
user4_reward_manager.save