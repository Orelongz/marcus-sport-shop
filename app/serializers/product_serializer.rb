class ProductSerializer
  include JSONAPI::Serializer

  attributes(*::ProductSerializerOptions::ALL_ATTRIBUTES)

  attribute :image do |object|
    object.media_urls.first
  end

  attribute :product_type_name do |object|
    object.product_type.name
  end

  belongs_to :product_type

  has_many :accessory_types
end
