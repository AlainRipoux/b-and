# db/seeds.rb

require 'faker'

# Clear existing data
UserBand.destroy_all
User.destroy_all
Band.destroy_all

# Create Users
users = 30.times.map do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    nickname: Faker::Internet.username,
    email: Faker::Internet.email,
    photo: Faker::Avatar.image,
    instrument: Faker::Music.instrument,
    bio: Faker::Lorem.paragraph(sentence_count: 3),
    style: Faker::Music.genre,
    address: Faker::Address.full_address
  )
end

puts "Created 30 users"

# Create Bands
bands = 10.times.map do
  Band.create!(
    name: Faker::Music.band,
    photo: Faker::LoremFlickr.image(size: "300x300", search_terms: ['band'])
  )
end

puts "Created 10 bands"

# Create UserBands
bands.each do |band|
  rand(1..5).times do
    UserBand.create!(user: users.sample, band: band)
  end
end

puts "Created user-band associations"
