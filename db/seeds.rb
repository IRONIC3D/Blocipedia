require 'faker'

20.times do
  Wiki.create(
    title:    Faker::Lorem.sentence,
    body:     Faker::Lorem.paragraph
  )
end

puts "Seed finished"
puts "#{Wiki.count} wikis created"