FactoryBot.define do
  factory :book_tour do
    number_person {Faker::Number.number(1)}
    note {Faker::Lorem.sentence(5)}
    price {Faker::Number.between(100, 1100)}
    total_price {Faker::Number.between(100, 1100)}
  end
end
