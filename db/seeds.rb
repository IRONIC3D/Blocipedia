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

admin = User.new(
   first_name:  'Iyad',
   last_name:   'Horani',
   email:       'i3d@ironic3d.com',
   password:    'helloworld',
   role:        'admin'
 )
admin.save
 
 # Create a moderator
 moderator = User.new(
   first_name:  'Moderator',
   last_name:   'User',
   email:       'moderator@example.com', 
   password:    'helloworld',
   role:        'moderator'
 )
 moderator.save
 
 # Create a member
 member = User.new(
   first_name:  'Regular',
   last_name:   'User',
   email:       'member@example.com',
   password:    'helloworld',
 )
 member.save

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"