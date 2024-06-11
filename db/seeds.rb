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
    { firstname: "Devon", lastname: "Bonner", nickname: "DevonD", email: "devon.bonner@example.com", password: "azerty", instrument: "Guitar", biography: "I play guitar and I sing since ten years. I'm looking for a new band to write songs", style: "Pop", address: "53 rue de l'échiquier 75010 Paris", availability: "Weekdays, Evenings", frequency: "Once a week, Twice a week", objectives: "Jamming, Recording", projects: "Covers, Originals" },
    { firstname: "John", lastname: "Doe", nickname: "JohnD", email: "john.doe@example.com", password: "azerty", instrument: "Drums", biography: "Drumming for 5 years. Love to play funk and jazz. Looking for a band !", style: "Jazz", address: "21 rue de la paix 75002 Paris", availability: "Weekends, Mornings", frequency: "Once a week", objectives: "Recording, Gigs", projects: "Improv, Originals" },
    { firstname: "Emily", lastname: "Clark", nickname: "EmilyC", email: "emily.clark@example.com", password: "azerty", instrument: "Piano", biography: "Self-taught pianist, looking for a cool band", style: "Rock", address: "10 avenue de l'opéra 75001 Paris", availability: "Flexible", frequency: "Twice a week", objectives: "Writing, Teaching", projects: "Originals, Covers" },
    { firstname: "Michael", lastname: "Smith", nickname: "MikeS", email: "mike.smith@example.com", password: "azerty", instrument: "Bass", biography: "Bassist looking to join a funk band", style: "Funk", address: "34 rue des arts 75003 Paris", availability: "Weekdays, Afternoons", frequency: "Three times a week", objectives: "Jamming, Gigs", projects: "Improv, Covers" },
    { firstname: "Sarah", lastname: "Johnson", nickname: "SarahJ", email: "sarah.johnson@example.com", password: "azerty", instrument: "Violin", biography: "Violinist with 15 years experience, looking for string quartet", style: "Pop", address: "56 rue de l'université 75007 Paris", availability: "Evenings", frequency: "Once a month", objectives: "Teaching, Learning", projects: "Originals, Covers" },
    { firstname: "David", lastname: "Brown", nickname: "DaveB", email: "david.brown@example.com", password: "azerty", instrument: "Saxophone", biography: "Saxophonist looking for a jazz ensemble", style: "Jazz", address: "78 rue de la victoire 75009 Paris", availability: "Mornings", frequency: "Twice a month", objectives: "Just for fun, Recording", projects: "Improv, Originals" },
    { firstname: "Laura", lastname: "Williams", nickname: "LauraW", email: "laura.williams@example.com", password: "azerty", instrument: "Sing", biography: "Singer looking for a pop-indie group", style: "Pop", address: "45 rue de paradis 75010 Paris", availability: "Weekdays, Evenings", frequency: "Twice a week", objectives: "Jamming, Writing", projects: "Originals, Covers" },
    { firstname: "James", lastname: "Taylor", nickname: "JamesT", email: "james.taylor@example.com", password: "azerty", instrument: "Trumpet", biography: "Trumpeter with 10 years experience, looking for big band", style: "Latin", address: "67 rue de la pompe 75016 Paris", availability: "Weekends, Afternoons", frequency: "Three times a week", objectives: "Gigs, Teaching", projects: "Improv, Covers" },
    { firstname: "Sophia", lastname: "Martinez", nickname: "SophiaM", email: "sophia.martinez@example.com", password: "azerty", instrument: "Bass", biography: "Self-taught bassist looking for an electro collectiv. Love to play on stage !", style: "Electro", address: "89 rue du bac 75007 Paris", availability: "Flexible", frequency: "Once a week", objectives: "Learning, Writing", projects: "Originals, Improv" },
    { firstname: "Robert", lastname: "Anderson", nickname: "RobA", email: "robert.anderson@example.com", password: "azerty", instrument: "Guitar", biography: "Guitarist. I didn't play music since a few years, but I'd like to play in a rock band ", style: "Rock", address: "12 rue de la roquette 75011 Paris", availability: "Weekdays, Evenings", frequency: "Twice a week", objectives: "Jamming, Recording", projects: "Originals, Covers" },
    { firstname: "Anna", lastname: "Thompson", nickname: "AnnaT", email: "anna.thompson@example.com", password: "azerty", instrument: "DJ", biography: "DJ for 5 years, I'd like to play with other musicians", style: "Electro", address: "23 rue des martyrs 75009 Paris", availability: "Mornings", frequency: "Once a month", objectives: "Teaching, Learning", projects: "Originals, Covers" },
    { firstname: "Christopher", lastname: "White", nickname: "ChrisW", email: "christopher.white@example.com", password: "azerty", instrument: "Violin", biography: "Violinist looking for duet partner", style: "Classic", address: "34 avenue de l'opéra 75002 Paris", availability: "Afternoons", frequency: "Twice a month", objectives: "Jamming, Writing", projects: "Improv, Originals" },
    { firstname: "Jessica", lastname: "Harris", nickname: "JessH", email: "jessica.harris@example.com", password: "azerty", instrument: "Sing", biography: "Fun singer looking for a band", style: "Pop", address: "56 boulevard saint-germain 75005 Paris", availability: "Weekdays, Evenings", frequency: "Three times a week", objectives: "Recording, Gigs", projects: "Originals, Covers" },
    { firstname: "Daniel", lastname: "Martin", nickname: "DanM", email: "daniel.martin@example.com", password: "azerty", instrument: "Guitar", biography: "Guitarist looking for a blues band", style: "Blues", address: "78 rue du cherche-midi 75006 Paris", availability: "Weekends, Mornings", frequency: "Once a week", objectives: "Just for fun, Recording", projects: "Improv, Originals" },
    { firstname: "Patricia", lastname: "Lee", nickname: "PatL", email: "patricia.lee@example.com", password: "azerty", instrument: "Piano", biography: "Pianist looking for a trio", style: "Latin", address: "90 rue de grenelle 75007 Paris", availability: "Flexible", frequency: "Twice a week", objectives: "Jamming, Writing", projects: "Originals, Covers" }
  ]

photos = [
  "https://images.unsplash.com/photo-1621784166258-c6fdfff31879?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ,
  "https://images.unsplash.com/photo-1681572128413-31f0d60f8709?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ,
  "https://images.unsplash.com/photo-1541528728921-3dd702496228?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ,
  "https://images.unsplash.com/photo-1495434500438-f708c7fff5c9?q=80&w=2884&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ,
  "https://images.unsplash.com/photo-1676326037845-b03c0ccb8c13?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ,
  "https://images.unsplash.com/photo-1659576293737-7ce7d2d64c44?q=80&w=2835&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ,
  "https://images.unsplash.com/photo-1535732850099-99177944f4c5?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ,
  "https://images.unsplash.com/photo-1501492765677-f07c5f3d87db?q=80&w=2952&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ,
  "https://images.unsplash.com/photo-1528489496900-d841974f5290?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ,
  "https://images.unsplash.com/photo-1517305542662-2dd61accb41d?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ,
  "https://images.unsplash.com/photo-1682289385881-a3c13fc3f1b4?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ,
  "https://images.unsplash.com/photo-1484972759836-b93f9ef2b293?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ,
  "https://images.unsplash.com/photo-1501837303764-ada599fdac6c?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ,
  "https://images.unsplash.com/photo-1495651779359-881fde1808a6?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ,
  "https://images.unsplash.com/photo-1679357518373-f8b4ccc99534?q=80&w=2864&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
]

users.each_with_index do |user, index|
    user = User.new(user)
    file = URI.open(photos[index])
    user.photo.attach(io: file, filename: "#{user.firstname}-avatar.png", content_type: "image/png")
    user.save!
  end

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

user2 = User.new(
  firstname: "Patti",
  lastname: "Smith",
  nickname: "Pat",
  email: "admin2@band.com",
  password: "azerty",
  instrument: "Sing",
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


puts "Created #{User.count} users"

photos_band = [
  "https://images.unsplash.com/photo-1632054553195-bfd7034fee25?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1478800907959-cd1621fbd465?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1526478806334-5fd488fcaabc?q=80&w=2716&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1499364615650-ec38552f4f34?q=80&w=2804&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1614247912229-26a7e2114c0a?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1506091403742-e3aa39518db5?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1565103420311-8cbbc3cd87b8?q=80&w=2938&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1566808907623-51b8fc382454?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1512407507877-d618bd91d4fb?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
]

puts "Creating bands..."
bands = []
users = User.all

10.times do |index|
  user = users.sample
  band = Band.create!(
    name: Faker::Music.band,
    user: user
  )
  file = URI.open(photos_band[index])
  band.photo.attach(io: file, filename: band.name, content_type: "image/png")
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
    Message.create!(content: Faker::Music::Prince.lyric, invite: invite, user: user,)
  end
end

puts "Creating task..."
bands.each do |band|
  rand(1..5).times do
    user = users.sample
    Task.create!(content: ["Book studio for saturday", "Buy guitar strings", "Share sheets music", "Work on a new setlist", "Recruit another guitarist", "Call festival for sound check"].sample, band: band, user: user)
  end
end

puts "Creating band_messages..."
bands.each do |band|
  rand(1..5).times do
    user = users.sample
    BandMessage.create!(content: Faker::Music::Prince.lyric, band: band, user: user)
  end
end
