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

users = [
    { firstname: "Devon", lastname: "Bonner", nickname: "DevonD", email: "devon.bonner@example.com", password: "azerty", instrument: "Guitar", biography: "I play guitar and I sing since ten years. I'm looking for a new band to write songs", style: "#{Faker::Music.genre}", address: "53 rue de l'échiquier 75010 Paris", availability: "Weekdays, Evenings", frequency: "Once a week, Twice a week", objectives: "Jamming, Recording", projects: "Covers, Originals" },
    { firstname: "John", lastname: "Doe", nickname: "JohnD", email: "john.doe@example.com", password: "azerty", instrument: "Drums", biography: "Drumming for 5 years and looking for a band", style: "#{Faker::Music.genre}", address: "21 rue de la paix 75002 Paris", availability: "Weekends, Mornings", frequency: "Once a week", objectives: "Recording, Gigs", projects: "Improv, Originals" },
    { firstname: "Emily", lastname: "Clark", nickname: "EmilyC", email: "emily.clark@example.com", password: "azerty", instrument: "Piano", biography: "Pianist looking for a cool band", style: "#{Faker::Music.genre}", address: "10 avenue de l'opéra 75001 Paris", availability: "Flexible", frequency: "Twice a week", objectives: "Writing, Teaching", projects: "Originals, Covers" },
    { firstname: "Michael", lastname: "Smith", nickname: "MikeS", email: "mike.smith@example.com", password: "azerty", instrument: "Bass", biography: "Bassist looking to join a funk band", style: "#{Faker::Music.genre}", address: "34 rue des arts 75003 Paris", availability: "Weekdays, Afternoons", frequency: "Three times a week", objectives: "Jamming, Gigs", projects: "Improv, Covers" },
    { firstname: "Sarah", lastname: "Johnson", nickname: "SarahJ", email: "sarah.johnson@example.com", password: "azerty", instrument: "Violin", biography: "Violinist with 15 years experience, looking for string quartet", style: "#{Faker::Music.genre}", address: "56 rue de l'université 75007 Paris", availability: "Evenings", frequency: "Once a month", objectives: "Teaching, Learning", projects: "Originals, Covers" },
    { firstname: "David", lastname: "Brown", nickname: "DaveB", email: "david.brown@example.com", password: "azerty", instrument: "Saxophone", biography: "Saxophonist looking for a jazz ensemble", style: "#{Faker::Music.genre}", address: "78 rue de la victoire 75009 Paris", availability: "Mornings", frequency: "Twice a month", objectives: "Just for fun, Recording", projects: "Improv, Originals" },
    { firstname: "Laura", lastname: "Williams", nickname: "LauraW", email: "laura.williams@example.com", password: "azerty", instrument: "Flute", biography: "Flutist looking for chamber music group", style: "#{Faker::Music.genre}", address: "45 rue de paradis 75010 Paris", availability: "Weekdays, Evenings", frequency: "Twice a week", objectives: "Jamming, Writing", projects: "Originals, Covers" },
    { firstname: "James", lastname: "Taylor", nickname: "JamesT", email: "james.taylor@example.com", password: "azerty", instrument: "Trumpet", biography: "Trumpeter with 10 years experience, looking for big band", style: "#{Faker::Music.genre}", address: "67 rue de la pompe 75016 Paris", availability: "Weekends, Afternoons", frequency: "Three times a week", objectives: "Gigs, Teaching", projects: "Improv, Covers" },
    { firstname: "Sophia", lastname: "Martinez", nickname: "SophiaM", email: "sophia.martinez@example.com", password: "azerty", instrument: "Cello", biography: "Cellist looking for string ensemble", style: "#{Faker::Music.genre}", address: "89 rue du bac 75007 Paris", availability: "Flexible", frequency: "Once a week", objectives: "Learning, Writing", projects: "Originals, Improv" },
    { firstname: "Robert", lastname: "Anderson", nickname: "RobA", email: "robert.anderson@example.com", password: "azerty", instrument: "Guitar", biography: "Guitarist looking for rock band", style: "#{Faker::Music.genre}", address: "12 rue de la roquette 75011 Paris", availability: "Weekdays, Evenings", frequency: "Twice a week", objectives: "Jamming, Recording", projects: "Originals, Covers" },
    { firstname: "Anna", lastname: "Thompson", nickname: "AnnaT", email: "anna.thompson@example.com", password: "azerty", instrument: "Clarinet", biography: "Clarinetist looking for wind ensemble", style: "#{Faker::Music.genre}", address: "23 rue des martyrs 75009 Paris", availability: "Mornings", frequency: "Once a month", objectives: "Teaching, Learning", projects: "Originals, Covers" },
    { firstname: "Christopher", lastname: "White", nickname: "ChrisW", email: "christopher.white@example.com", password: "azerty", instrument: "Violin", biography: "Violinist looking for duet partner", style: "#{Faker::Music.genre}", address: "34 avenue de l'opéra 75002 Paris", availability: "Afternoons", frequency: "Twice a month", objectives: "Jamming, Writing", projects: "Improv, Originals" },
    { firstname: "Jessica", lastname: "Harris", nickname: "JessH", email: "jessica.harris@example.com", password: "azerty", instrument: "Drums", biography: "Drummer looking for a metal band", style: "#{Faker::Music.genre}", address: "56 boulevard saint-germain 75005 Paris", availability: "Weekdays, Evenings", frequency: "Three times a week", objectives: "Recording, Gigs", projects: "Originals, Covers" },
    { firstname: "Daniel", lastname: "Martin", nickname: "DanM", email: "daniel.martin@example.com", password: "azerty", instrument: "Guitar", biography: "Guitarist looking for a blues band", style: "#{Faker::Music.genre}", address: "78 rue du cherche-midi 75006 Paris", availability: "Weekends, Mornings", frequency: "Once a week", objectives: "Just for fun, Recording", projects: "Improv, Originals" },
    { firstname: "Patricia", lastname: "Lee", nickname: "PatL", email: "patricia.lee@example.com", password: "azerty", instrument: "Piano", biography: "Pianist looking for jazz trio", style: "#{Faker::Music.genre}", address: "90 rue de grenelle 75007 Paris", availability: "Flexible", frequency: "Twice a week", objectives: "Jamming, Writing", projects: "Originals, Covers" }
  ]

# array de mes photos

# each with index
users.each do |user|
    user = User.new(user)
    user.save!
    file = URI.open(user[:photo])
    user.photo.attach(io: file, filename: "#{user.nickname}-avatar.png", content_type: "image/png")
    user.save!
    user
  end


# users = 30.times.map do
#   user = User.new(
#     firstname: Faker::Name.first_name,
#     lastname: Faker::Name.last_name,
#     nickname: Faker::Internet.username,
#     email: Faker::Internet.email,
#     password: "azerty",
#     instrument: Faker::Music.instrument,
#     biography: Faker::Lorem.paragraph(sentence_count: 3),
#     style: Faker::Music.genre,
#     address: ["53 rue de l'échiquier 75010 Paris", "26 rue de la Félicité 75017 Paris", "54b rue Ordener 75018 Paris"].sample,
#     availability: ["Weekdays", "Weekends", "Flexible", "Weekday Evenings", "Evenings", "Mornings", "Afternoons"].sample(rand(1..2)).join(", "),
#     frequency: ["Everyday", "Once a week", "Twice a week", "Three times a week", "Once a month", "Twice a month"].sample(rand(1..2)).join(", "),
#     objectives: ["Jamming", "Recording", "Gigs", "Writing", "Teaching", "Learning", "Just for fun"].sample(rand(1..5)).join(", "),
#     projects: ["Covers", "Originals", "Improv"].sample(rand(1..3)).join(", ")
#   )
#   file = URI.open(Faker::LoremFlickr.image(search_terms: ['musician']))
#   user.photo.attach(io: file, filename: "#{user.nickname}-avatar.png", content_type: "image/png")
#   user.save!
#   user
# end

user1 = User.new(
  firstname: "Lenny",
  lastname: "Kravitz",
  nickname: "Len",
  email: "admin@band.com",
  password: "azerty",
  instrument: "Guitar",
  biography: "Born in New York, I was exposed to the entertainment industry at a young age and grew up in a musically diverse environment. I released my debut album 'Let Love Rule' in 1989 characterized by a blend of rock, funk, reggae, hard rock, soul, and R&B.",
  style: "Rock",
  address: "16 villa Gaudelet 75011 Paris",
  availability: ["Weekends","Weekday Evenings"].sample,
  frequency: "Varies",
  objectives: ["Jamming", "Recording", "Gigs"].sample,
  projects: ["Originals", "Recording projects"].sample
)
file1 = URI.open("https://cdn-s-www.ledauphine.com/images/7AA4896A-D560-4953-B824-A6AC2C138B40/NW_raw/lenny-kravitz-1519895037.jpg")
user1.photo.attach(io: file1, filename: "#{user1.nickname}-avatar.jpg", content_type: "image/jpg")
user1.save!

users << user1

user2 = User.new(
  firstname: "Patti",
  lastname: "Smith",
  nickname: "Pat",
  email: "admin2@band.com",
  password: "azerty",
  instrument: "Voice",
  biography: "I am an American singer, songwriter, poet, painter, and author. I love to fuse rock and poetry in my work. You might know my song, 'Because the Night', co-written with Bruce Springsteen.",
  style: "Rock",
  address: "15 villa Gaudelet 75011 Paris",
  availability: ["Weekends","Weekday Evenings"].sample,
  frequency: "Varies",
  objectives: ["Jamming", "Recording", "Gigs"].sample,
  projects: ["Originals", "Recording projects"].sample
)
file2 = URI.open("https://cdns-images.dzcdn.net/images/artist/14b440783a197d1eeff45d3ad32bfdf0/500x500.jpg")
user2.photo.attach(io: file2, filename: "#{user2.nickname}-avatar.jpg", content_type: "image/jpg")
user2.save!

users << user2

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
    Message.create!(content: Faker::Lorem.paragraph(sentence_count: 2), invite: invite, user: user,)
  end
end

puts "Creating task..."
bands.each do |band|
  rand(1..5).times do
    user = users.sample
    Task.create!(content: Faker::Lorem.paragraph(sentence_count: 1), band: band, user: user)
  end
end

puts "Creating band_messages..."

bands.each do |band|
  rand(1..5).times do
    user = users.sample
    BandMessage.create!(content: Faker::Lorem.paragraph(sentence_count: 2), band: band, user: user)
  end
end
