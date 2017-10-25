FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {"123"}
    password_confirmation {"123"}
    address {Faker::Address.city}
    telphone {"012 1451 4512"}
    avatar {""}
  end
end
