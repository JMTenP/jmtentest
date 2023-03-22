FactoryBot.define do
  factory :employee do
    association :account
    association :user
  end
end
