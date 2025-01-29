class ComplementaryAccessoryConstraintSerializer
  include JSONAPI::Serializer

  attributes(*::ComplementaryAccessoryConstraintSerializerOptions::ALL_ATTRIBUTES)

  belongs_to :accessory
  belongs_to :complementary_accessory, serializer: AccessorySerializer
end
