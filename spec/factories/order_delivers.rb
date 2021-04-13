FactoryBot.define do
  factory :order_deliver do
    token {"tok_abcdefghijk00000000000000000"}
    postal_code {Faker::Number.leading_zero_number(digits: 3).to_s + "-" + Faker::Number.leading_zero_number(digits: 4).to_s}
    area_id {Faker::Number.between(from: 1, to: 47)}
    city { '東京都' }
    number { '1-1' }
    building { '東京ハイツ' }
    phone {Faker::Number.leading_zero_number(digits: 11)}
  end
end
