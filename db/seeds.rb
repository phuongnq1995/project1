User.create!(name:  "Example User",
             email: "new@gmail.org",
             password:              "foobar",
             password_confirmation: "foobar",
             role: 1)

19.times do |n|
  name  = Faker::Name.name
  email = "new-#{n+1}@gmail.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

Category.create!(name:  "Loai1",
             discription: "new@gmail.org",)

9.times do |n|
  name  = Faker::Name.name
  discription = "new-#{n+1}@gmail.org"
  Category.create!(name:  name,
               discription: discription)
end

categorys = Category.order(:created_at).take(6)
5.times do
  content = Faker::Name.name
  categorys.each { |category| category.words.create!(content: content) }
end
