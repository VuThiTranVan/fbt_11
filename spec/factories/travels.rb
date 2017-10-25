FactoryGirl.define do
  factory :travel do
    name {"Travel name"}
    flg_promotion {0}
    schedule {Faker::Space.agency}
    description {Faker::Lorem.sentence(5)}
    note {Faker::Lorem.sentence(5)}
    tour_duration {"2 days"}
    price {Faker::Number.decimal(1)}
    promotion_id {nil}
    id_place_from {place_from.id}
    id_place_to {1}
  end
end
