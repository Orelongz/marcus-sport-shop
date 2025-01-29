class ProductTypeSerializer
  include JSONAPI::Serializer

  attributes(*::ProductTypeSerializerOptions::ALL_ATTRIBUTES)

  has_many :products
end
