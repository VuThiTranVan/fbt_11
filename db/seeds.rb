User.create!(
  name: "Admin", email: "admin@gmail.com",
  password: "123", password_confirmation: "123", role: 0,
  address: "Da Nang", telphone: "016 1754 7541",
  remote_avatar_url: "http://wfarm2.dataknet.com/static/resources/icons/set108/b5cdab07.png")

User.create!(
  name: "Van Vu", email: "vanvtt@gmail.com",
  password: "123", password_confirmation: "123", role: 1,
  address: "Da Nang", telphone: "016 1754 0001",
  remote_avatar_url: "https://image.flaticon.com/teams/slug/freepik.jpg")
20.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "123"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password, role: 1,
    address: "Da Nang", telphone: "016 17#{n} 0001",
    avatar: ""
  )
end

# Place
5.times do |n|
  Place.create! name:Faker::Address.country, city: Faker::Address.city, description: Faker::Address.state
end

# Promotion
2.times do |n|
  name = Faker::Food.dish
  Promotion.create!(
    date_start: Time.zone.today, date_end: Time.zone.tomorrow, name: name,
    description: "description #{n}", discus_percent: 10.0)
end

# Travel
name_travel = "Central of Vietnam: Da Nang - Hoi An"
place_form = Place.all.pluck(:id)
place_to = Place.all.pluck(:id)
description =  Faker::Lorem.sentence(25)
note = Faker::Lorem.sentence(10)
promotion_id = Promotion.all.pluck(:id)

12.times do |n|
  Travel.create!(
    name: name_travel + "#{n}",
    id_place_from: place_form[rand(place_form.size)],
    id_place_to: place_form[rand(place_form.size)],
    flg_promotion: 0,
    schedule: Faker::Space.agency,
    description: description,
    note: note,
    tour_duration: "#{n + n/2} days",
    promotion_id: nil
  )
end

2.times do |n|
  Travel.create!(
    name: name_travel + " _ #{n}",
    id_place_from: place_form[rand(place_form.size)],
    id_place_to: place_form[rand(place_form.size)],
    flg_promotion: 1,
    schedule: Faker::Space.agency,
    description: description,
    tour_duration: "#{n + 2} days",
    note: note,
    promotion_id: Promotion.all.pluck(:id)[rand(Promotion.all.size)]
  )
end

#Image
travels_id = Travel.all.pluck(:id)
travels = Travel.all

travels.each { |travel| travel.images.create!(
  travel_id: travel.id,
  remote_picture_url: "https://travel.com.vn/Images/tour/tfd_170106020319_633722.JPG"
)}

2.times do |n|
  content = Faker::Lorem.sentence(5)
  travels.each { |travel| travel.images.create!(
    travel_id: travel.id,
    remote_picture_url: "https://travel.com.vn/Images/tour/tfd_150325_hoi%20an.jpg"
  )}
end

# Tour
2.times do |n|
  content = Faker::Lorem.sentence(5)
  travels.each { |travel| travel.tours.create!(
    date_start: Faker::Date.forward(30),
    date_end: Faker::Date.forward(30),
    price: Faker::Number.decimal(1)
  )}
end

# Rating
users = User.take(10)
users.each { |user| user.ratings.create!(
  travel_id: travels_id[rand(travels_id.size)],
  star_number: rand(1..5)
)}

# Category
Category.create!(name: "Place", description: "Des place")
Category.create!(name: "Food", description: "Des Food")
Category.create!(name: "Experience", description: "Des Experience")

# Comment
categories = Category.all
users_id = User.all.pluck(:id)
2.times do
  categories.each { |category| category.comments.create!(
    travel_id: travels_id[rand(travels_id.size)],
    user_id: users_id[rand(users_id.size)],
    content: Faker::Lorem.sentence(3)
  )}
end

comments = Comment.take(2)
comments.each{ |comment| Comment.create!(
  id_parent: comment.id,
  travel_id: comment.travel_id,
  user_id: users_id[rand(users_id.size)],
  category_id: comment.category_id,
  content: Faker::Lorem.sentence(3)
)}

# Like
2.times do
  comments.each {|comment| comment.likes.create!(
    user_id: users_id[rand(users_id.size)]
  )}
end
