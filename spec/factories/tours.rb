FactoryBot.define do
  factory :tour do
    date_start {Faker::Date.forward(30)}
    date_end {Faker::Date.forward(30)}
  end
end
