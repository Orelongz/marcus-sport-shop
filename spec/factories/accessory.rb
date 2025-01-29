FactoryBot.define do
  factory :accessory do
    out_of_stock { false }
    sequence(:name) { |n| "Accessory #{n}" }
    description { Faker::Lorem.sentence }
    price { Faker::Number.number(digits: 6) }
    accessory_type { association :accessory_type }
  end
end
