class ComplementaryAccessoryPriceSerializer
  include JSONAPI::Serializer

  attributes(*::ComplementaryAccessoryPriceSerializerOptions::ALL_ATTRIBUTES)

  belongs_to :accessory
  belongs_to :complementary_accessory, serializer: AccessorySerializer
end
