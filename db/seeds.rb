# db/seeds.rb

require 'faker'
require 'open-uri'

file = URI.open("https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/NES-Console-Set.jpg/1200px-NES-Console-Set.jpg")

# Clear existing data
User.destroy_all
Band.destroy_all
UserBand.destroy_all

puts "Creating users..."

users = 30.times.map do
  user = User.new(
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    nickname: Faker::Internet.username,
    email: Faker::Internet.email,
    password: "azerty",
    instrument: Faker::Music.instrument,
    biography: Faker::Lorem.paragraph(sentence_count: 3),
    style: Faker::Music.genre,
    address: Faker::Address.full_address
  )
  file = URI.open(Faker::Avatar.image)
  user.photo.attach(io: file, filename: "#{user.nickname}-avatar.png", content_type: "image/png")
  user.save!
  user
end

user = User.new(
  firstname: "Admin",
  lastname: "Test",
  nickname: "Admin",
  email: "admin@band.com",
  password: "azerty",
  instrument: Faker::Music.instrument,
  biography: Faker::Lorem.paragraph(sentence_count: 3),
  style: Faker::Music.genre,
  address: Faker::Address.full_address
)
file = URI.open(Faker::Avatar.image)
user.photo.attach(io: file, filename: "#{user.nickname}-avatar.png", content_type: "image/png")
user.save!

users << user

puts "Created #{User.count} users"

puts "Creating bands..."
bands = 10.times.map do
  user = users.sample
  band = Band.new(
    name: Faker::Music.band,
    user: user
  )
  band.photo.attach(io: file, filename: band.name)
  band.save!
  UserBand.create!(user: user, band: band)
  puts "Created #{Band.count} bands"

  puts "Creating user_bands..."

puts "Creating user_bands..."
bands.each do |band|
  rand(1..5).times do
    user = users.sample
    if !band.users.include?(user)
      UserBand.create!(user: user, band: band)
    end
  end
end

puts "Created #{UserBand.count} user-band associations"
