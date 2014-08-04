require 'faker'

5.times do
  user = User.create(
    first_name:     Faker::Name.first_name,
    last_name:      Faker::Name.last_name,
    email:          Faker::Internet.email,
    password:       Faker::Lorem.characters(10)
  )
end
users = User.all

20.times do
  Wiki.create(
    user:     users.sample,
    title:    Faker::Lorem.sentence,
    body:     Faker::Lorem.paragraph
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"