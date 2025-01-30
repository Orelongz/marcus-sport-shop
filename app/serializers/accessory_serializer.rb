class AccessorySerializer
  include JSONAPI::Serializer

  attributes(*::AccessorySerializerOptions::ALL_ATTRIBUTES)

  attribute :image do |object|
    object.media_urls.first
  end


  belongs_to :accessory_type

  has_many :products

  has_many :complementary_accessory_prices
  has_many :complementary_accessory_constraints
end
