FactoryBot.define do
  factory :complementary_accessory_price do
    price { 10_000 }
    accessory { association :accessory }
    complementary_accessory { association :accessory }
  end
end
