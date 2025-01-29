class ProductSerializer
  include JSONAPI::Serializer

  set_key_transform :camel_lower

  attributes(*::ProductSerializerOptions::ALL_ATTRIBUTES)

  attribute :image do |object|
    object.media_urls.first
  end

  attribute :product_type_name do |object|
    object.product_type.name
  end

  belongs_to :product_type
end
