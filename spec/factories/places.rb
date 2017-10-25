FactoryGirl.define do
  factory :place do
    name {Faker::Address.country}
    city {Faker::Address.city}
    description {Faker::Address.state}
  end
end
