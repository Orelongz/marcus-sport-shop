class CartSerializer
  include JSONAPI::Serializer

  attributes(*::CartSerializerOptions::ALL_ATTRIBUTES)

  belongs_to :user, optional: true

  has_many :cart_items
  has_many :accessory_cart_items
end
