FactoryBot.define do
  factory :accessory_cart_item do
    cart_item { association :cart_item }
    accessory { association :accessory }
  end
end
