FactoryBot.define do
  factory :accessory_type do
    sequence(:name) { |n| "Accessory Type #{n}" }
    product_type { association :product_type }
  end
end
