class CartItemSerializerOptions
  ALL_ATTRIBUTES = %i[id cart_id total product].freeze

  class << self
    def index
      {
        include: %i[accessory_cart_items],
        fields: {
          cart_item: %i[id total product],
          product: ProductSerializerOptions::ALL_ATTRIBUTES,
          accessory_cart_items: AccessoryCartItemSerializerOptions::ALL_ATTRIBUTES
        }
      }
    end

    def show
      index
    end

    def create
      index
    end

    def update
      index
    end
  end
end
