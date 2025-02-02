class CartItemSerializer
  include JSONAPI::Serializer

  attributes(*::CartItemSerializerOptions::ALL_ATTRIBUTES)

  belongs_to :cart

  has_many :accessory_cart_items
end
