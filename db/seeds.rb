# db/seeds.rb

require 'faker'
require 'open-uri'

file = URI.open("https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/NES-Console-Set.jpg/1200px-NES-Console-Set.jpg")

# Clear existing data
User.destroy_all
Band.destroy_all
UserBand.destroy_all
Invite.destroy_all
Task.destroy_all
BandMessage.destroy_all
Message.destroy_all

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
    address: ["53 rue de l'échiquier 75010 Paris", "26 rue de la Félicité 75017 Paris", "54b rue Ordener 75018 Paris"].sample,
    availability: ["Weekdays", "Weekends", "Flexible", "Weekday Evenings", "Evenings", "Mornings", "Afternoons"].sample(rand(1..2)).join(", "),
    frequency: ["Everyday", "Once a week", "Twice a week", "Three times a week", "Varies", "Once a month", "Twice a month"].sample(rand(1..2)).join(", "),
    objectives: ["Jamming", "Recording", "Gigs", "Writing", "Teaching", "Learning", "Just for fun"].sample(rand(1..5)).join(", "),
    projects: ["Covers", "Originals", "Improv"].sample(rand(1..3)).join(", ")
  )
  file = URI.open(Faker::LoremFlickr.image(search_terms: ['musician']))
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
  address: "16 villa Gaudelet 75011 Paris",
  availability: ["Weekends","Weekday Evenings"].sample,
  frequency: "Varies",
  objectives: ["Jamming", "Recording", "Gigs"].sample,
  projects: ["Originals", "Recording projects"].sample
)
file = URI.open(Faker::Avatar.image)
user.photo.attach(io: file, filename: "#{user.nickname}-avatar.png", content_type: "image/png")
user.save!

users << user

puts "Created #{User.count} users"

puts "Creating bands..."
bands = []

10.times do
  user = users.sample
  band = Band.new(
    name: Faker::Music.band,
    user: user
  )
  file = URI.open(Faker::LoremFlickr.image(search_terms: ['band']))
  band.photo.attach(io: file, filename: band.name, content_type: "image/png")
  band.save!
  UserBand.create!(user: user, band: band)
  bands << band
end
puts "Created #{Band.count} bands"

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

puts "Creating invites & messages..."
users.each do |user|
  rand(1..5).times do
    invite = Invite.create!(first_user: user, second_user: users.sample)
    Message.create!(content: "Test", invite: invite, user: user,)
  end
end

puts "Creating task..."
bands.each do |band|
  rand(1..5).times do
    user = users.sample
    Task.create!(content: Faker::Lorem.paragraph(sentence_count: 3), band: band, user: user)
  end
end

puts "Creating band_messages..."

bands.each do |band|
  rand(1..5).times do
    user = users.sample
    BandMessage.create!(content: Faker::Lorem.paragraph(sentence_count: 3), band: band, user: user)
  end
end
