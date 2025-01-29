class ProductTypeSerializer
  include JSONAPI::Serializer

  attributes :id, :name
end
