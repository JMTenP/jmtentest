FactoryBot.define do
  factory :account do
    association :user
    uuid { Faker::Number.number(digits: 10) }
    role { rand(0..2) }
    referral_id { Faker::Number.number(digits: 8) }
    referred_by { Faker::Name.name }
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    gender { %w[male female].sample }
    birthdate { Faker::Date.birthday(min_age: 18, max_age: 65) }
    country { Faker::Address.country }
    language { Faker::Nation.language }
    status { %w[active inactive suspended].sample }
  end
end
