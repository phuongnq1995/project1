User.create!(name:  "Admin",
             email: "admin@gmail.com",
             password:              "123456",
             password_confirmation: "123456",
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
  discription = Faker::Lorem.sentence(5)
  Category.create!(name:  name,
               discription: discription)
end

# Following relationships
users = User.all
user  = users.first
following = users[2..15]
followers = users[3..13]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
