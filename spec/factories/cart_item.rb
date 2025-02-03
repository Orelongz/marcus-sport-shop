FactoryBot.define do
  factory :cart_item do
    cart { association :cart }
    product { association :product }
  end
end
