FactoryBot.define do
  factory :complementary_accessory_constraint do
    accessory { association :accessory }
    complementary_accessory { association :accessory }
  end
end
