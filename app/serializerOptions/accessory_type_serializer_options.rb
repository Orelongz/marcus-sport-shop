class AccessoryTypeSerializerOptions
  ALL_ATTRIBUTES = %i[id name product_type_id].freeze

  class << self
    def index
      {
        include: [
          :accessories,
          :"accessories.complementary_accessory_prices",
          :"accessories.complementary_accessory_constraints"
        ],
        fields: {
          accessory_type: ALL_ATTRIBUTES,
          accessory: AccessorySerializerOptions::ALL_ATTRIBUTES,
          complementary_accessory_price: ComplementaryAccessoryPriceSerializerOptions::ALL_ATTRIBUTES,
          complementary_accessory_constraint: ComplementaryAccessoryConstraintSerializerOptions::ALL_ATTRIBUTES
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
