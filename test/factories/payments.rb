# spec/factories/payments.rb

FactoryBot.define do
  factory :payment do
    uuid { Faker::Number.number(digits: 10) }
    amount { Faker::Number.decimal(l_digits: 2) }
    currency { Faker::Currency.code }
    description { Faker::Lorem.sentence }
    operation_date { Faker::Time.backward(days: 14) }
    status { %w[pending completed failed].sample }
    kind { %w[credit debit].sample }
  end
end
