module CartItems
  class CalculateCartItemTotal < ActiveInteraction::Base
    record :cart_item

    delegate :price, to: :product, prefix: true
    delegate :product, :accessory_cart_items, to: :cart_item

    def execute
      product_price + accessory_cart_items_total
    end

    def accessory_cart_items_total
      accessory_cart_items.reduce(0) do |total, accessory_cart_item|
        current_accessory_price =
          complementrary_prices_hash[accessory_cart_item.accessory_id] ||
          accessory_cart_item.accessory.price

        total + current_accessory_price
      end
    end

    def complementrary_prices_hash
      @complementrary_prices_hash ||= ComplementaryAccessoryPrice
        .where(accessory_id: accessory_ids, complementary_accessory_id: accessory_ids)
        .each_with_object({}) do |complementary_price, acc|
          acc[complementary_price.complementary_accessory_id] = complementary_price.price
        end
    end

    def accessory_ids
      @accessory_ids ||= accessory_cart_items.pluck(:accessory_id)
    end
  end
end
