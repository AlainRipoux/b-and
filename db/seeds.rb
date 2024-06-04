# db/seeds.rb

require 'faker'
require 'open-uri'

file = URI.open("https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/NES-Console-Set.jpg/1200px-NES-Console-Set.jpg")

# Clear existing data
User.destroy_all
Band.destroy_all
UserBand.destroy_all

# Create Users
users = 30.times.map do
  User.create!(
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    nickname: Faker::Internet.username,
    email: Faker::Internet.email,
    password: "azerty",
    photo: Faker::Avatar.image,
    instrument: Faker::Music.instrument,
    biography: Faker::Lorem.paragraph(sentence_count: 3),
    style: Faker::Music.genre,
    address: Faker::Address.full_address
  )
end

User.create!(
  firstname: "Admin",
  lastname: "Test",
  nickname: "Admin",
  email: "admin@band.com",
  password: "azerty",
  photo: Faker::Avatar.image,
  instrument: Faker::Music.instrument,
  biography: Faker::Lorem.paragraph(sentence_count: 3),
  style: Faker::Music.genre,
  address: Faker::Address.full_address
)

puts "Created 30 users"
# Create Bands
bands = 10.times.map do
  band = Band.new(
    name: Faker::Music.band,
    user: users.sample
  )
  band.photo.attach(io: file, filename: band.name)
  band.save!
end

puts "Created 10 bands"

# Create UserBands
bands.each do |band|
  rand(1..5).times do
    UserBand.create!(user: users.sample, band: band)
  end
end

puts "Created user-band associations"
