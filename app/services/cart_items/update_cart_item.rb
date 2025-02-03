module CartItems
  class UpdateCartItem < Base
    class Error < ::ApplicationRaisedError; end

    record :cart_item

    def execute
      validate_complemetary_accessories

      delete_stale_accessories

      add_new_accessories

      cart_item
    end

    private

    def delete_stale_accessories
      stale_accessory_ids = current_accessory_ids - accessory_ids

      AccessoryCartItem.where(accessory_id: stale_accessory_ids).delete_all
    end

    def add_new_accessories
      new_accessory_ids = accessory_ids - current_accessory_ids

      new_accessory_ids_map = new_accessory_ids.map { |id| { accessory_id: id } }

      cart_item.accessory_cart_items.upsert_all(new_accessory_ids_map)
    end

    def current_accessory_ids
      @current_accessory_ids ||= cart_item.accessory_cart_items.pluck(:accessory_id)
    end
  end
end
