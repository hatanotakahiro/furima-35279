FactoryBot.define do
  factory :product do
    title {Faker::Lorem.characters(number: 20)}
    text {Faker::Lorem.characters(number: 100)}
    category_id {Faker::Number.between(from: 1, to: 10)}
    status_id {Faker::Number.between(from: 1, to: 6)}
    ship_pay_id {Faker::Number.between(from: 1, to: 2)}
    area_id {Faker::Number.between(from: 1, to: 47)}
    delivery_day_id {Faker::Number.between(from: 1, to: 3)}
    price {Faker::Number.between(from: 300, to: 9999999)}

    association :user

    after(:build) do |product|
      product.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end