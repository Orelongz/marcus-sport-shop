module CartItems
  class CreateCartItem < Base
    class Error < ::ApplicationRaisedError; end

    record :cart

    integer :product_id

    def execute
      validate_complemetary_accessories

      cart_item = cart.cart_items.create(product_id: product_id)

      accessory_id_map = accessory_ids.map { |id| { accessory_id: id } }

      cart_item.accessory_cart_items.upsert_all(accessory_id_map)

      cart_item
    end
  end
end
