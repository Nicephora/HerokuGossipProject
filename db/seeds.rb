require 'faker'

# Purge the city table before create 10 cities to fill it
City.destroy_all
10.times do
  City.create(
    name: Faker::Games::Fallout.unique.location,
    zip_code: Faker::Address.unique.zip
  )
end

# Purge the user table before create 10 users to fill it
User.destroy_all
10.times do
  User.create(
    first_name: Faker::Movies::LordOfTheRings.character,
    last_name: Faker::Movies::StarWars.planet,
    description: Faker::TvShows::BojackHorseman.quote,
    email: Faker::Internet.unique.email,
    age: rand(18..99),
    city: City.all.sample,
    password: Faker::Creature::Dog.name
  )
end

# Purge the gossip table before create 20 gossips to fill it
Gossip.destroy_all
20.times do
  Gossip.create(
    title: Faker::Book.title,
    content: Faker::Movie.quote + ". " + Faker::Movies::StarWars.quote,
    user: User.all.sample
  )
end

# Purge the tag table before create 10 tags to fill it
Tag.destroy_all
10.times do
  Tag.create(title: "#" + Faker::Cannabis.unique.buzzword.gsub(/ /, "_"))
end

# Purge the table linking tags and gossips.
# Link a tag to each gossip then create a random number of links between tags
# and gossips
TagGossipLink.destroy_all
Gossip.all.each do |gossip|
  TagGossipLink.create(gossip: gossip, tag: Tag.all.sample)
end

rand(0..20).times do
  TagGossipLink.create(
    gossip: Gossip.all.sample,
    tag: Tag.all.sample
  )
end

# Purge the tables about the private messages. Then create a random number of
# pm, which one with a random number of unique recipients.
PrivateMessage.destroy_all
RecipientToPmLink.destroy_all
rand(20..40).times do
  pm = PrivateMessage.create(
    sender: User.all.sample,
    content: "\"#{Faker::Games::WorldOfWarcraft.quote}\" dixit #{Faker::Games::WorldOfWarcraft.hero}\n\"#{Faker::Games::Fallout.quote}\" answered #{Faker::Games::Fallout.character}"
  )
  recipients = Array.new

  rand(1..10).times do
    while true
      recipient = User.all.sample
      break unless recipients.include?(recipient)
    end
    recipients << recipient
    RecipientToPmLink.create(
      received_message: pm,
      recipient: recipient
    )
  end
end

Comment.destroy_all
30.times do
  Comment.create(content: Faker::Lorem.paragraph, user: User.all.sample, gossip: Gossip.all.sample)
end
