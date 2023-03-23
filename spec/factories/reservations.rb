FactoryBot.define do
  factory :reservation do
    association :guest
    sequence(:reservation_code) { |n| "RES#{n}" }
    start_date { Faker::Date.forward(days: 10) }
    end_date { Faker::Date.forward(days: 15) }
    nights { 5 }
    guests { Faker::Number.between(from: 1, to: 10) }
    adults { Faker::Number.between(from: 1, to: 5) }
    children { Faker::Number.between(from: 0, to: 5) }
    infants { Faker::Number.between(from: 0, to: 2) }
    status { %w[accepted cancelled pending].sample }
    currency { Faker::Currency.code }
    payout_price { Faker::Commerce.price(range: 100.00..1000.00, as_string: true) }
    security_price { Faker::Commerce.price(range: 50.00..300.00, as_string: true) }
    total_price { Faker::Commerce.price(range: 150.00..1300.00, as_string: true) }
  end
end