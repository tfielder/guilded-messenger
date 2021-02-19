# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.destroy_all
Message.destroy_all

def createUser
  User.create!(
    first_name: Faker::Movies::StarWars.character,
    last_name: Faker::Name.last_name
  )
end

def createMessage(id_1, id_2)
  Message.create!(
    subject: Faker::Movies::HitchhikersGuideToTheGalaxy.location,
    body: Faker::Movies::HitchhikersGuideToTheGalaxy.quote,
    receiver_id: id_1,
    sender_id: id_2,
  )
end

if Rails.env == 'development' || Rails.env == 'production'

  user_1 = createUser()
  user_2 = createUser()
  user_3 = createUser()

  8.times do
    createUser()
  end

  createMessage(user_1.id, user_2.id)
  createMessage(user_1.id, user_3.id)
  createMessage(user_2.id, user_1.id)
  createMessage(user_2.id, user_3.id)
  createMessage(user_3.id, user_1.id)
  createMessage(user_3.id, user_2.id)
end

puts 'seeded the db'