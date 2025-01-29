class ProductSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :price, :media_urls
end
