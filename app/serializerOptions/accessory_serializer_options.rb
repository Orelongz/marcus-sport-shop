class AccessorySerializerOptions
  INDEX_ATTRIBUTES = %i[id name price image out_of_stock].freeze
  ALL_ATTRIBUTES = %i[id name price media_urls description out_of_stock accessory_type_id].freeze

  class << self
    def index
      {
        fields: {
          accessory: INDEX_ATTRIBUTES
        }
      }
    end

    def show
      {
        include: %i[complementary_accessory_prices complementary_accessory_constraints],
        fields: {
          accessory: ALL_ATTRIBUTES,
          complementary_accessory_price: ComplementaryAccessoryPriceSerializerOptions::ALL_ATTRIBUTES,
          complementary_accessory_constraint: ComplementaryAccessoryConstraintSerializerOptions::ALL_ATTRIBUTES
        }
      }
    end

    def create
      index
    end

    def update
      index
    end
  end
end
