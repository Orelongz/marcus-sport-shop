class AccessoryTypeSerializer
  include JSONAPI::Serializer

  attributes(*::AccessoryTypeSerializerOptions::ALL_ATTRIBUTES)

  has_many :products
  has_many :accessories

  belongs_to :product_type
end
