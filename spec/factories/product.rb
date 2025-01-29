FactoryBot.define do
  factory :product do
    out_of_stock { false }
    description { Faker::Lorem.sentence }
    sequence(:name) { |n| "Product #{n}" }
    price { Faker::Number.number(digits: 6) }
    product_type { association :product_type }
  end
end
