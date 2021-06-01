require "faker"

Article.destroy_all

30.times do 
  article = Article.create!(
    title: Faker::Book.title,
    content: Faker::Lorem.sentence,
  )  
  puts "Create Article"
end