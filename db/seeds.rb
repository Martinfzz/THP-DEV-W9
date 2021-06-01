require "faker"

Article.destroy_all
User.destroy_all

1.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "aa@yopmail.com",
    password: "azerty",
  )
  puts "Create User"
end

30.times do 
  article = Article.create!(
    title: Faker::Book.title,
    content: Faker::Lorem.sentence,
    user: User.first,
  )  
  puts "Create Article"
end