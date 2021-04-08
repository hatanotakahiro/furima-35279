FactoryBot.define do
  factory :product do
    title {Faker::Lorem.sentence(max_length: 40)}
    text {Faker::Lorem.sentence(max_length: 1000)}
    image {Faker::Lorem.sentence}



    association :user 

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end