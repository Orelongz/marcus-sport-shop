class AccessoryCartItemSerializer
  include JSONAPI::Serializer

  attributes(*::AccessoryCartItemSerializerOptions::ALL_ATTRIBUTES)

  belongs_to :cart_item
end
