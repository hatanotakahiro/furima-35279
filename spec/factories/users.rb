FactoryBot.define do
  factory :user do
    
    nickname {Faker::Name.name}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6) + "1a"
    password {password}
    password_confirmation {password}
    # 以下、一意性制約がないのでFakerを使用する必要がない
    last_name {"山田"}
    first_name {"太郎"}
    last_name_kana {"ヤマダ"}
    first_name_kana {"タロウ"}
    birth_date {"1992-03-07"}
  end
end