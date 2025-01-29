class ProductSerializerOptions
  ALL_ATTRIBUTES = %i[id name price media_urls description out_of_stock].freeze

  class << self
    def index
      {
        fields: { product: %i[id name price image] }
      }
    end

    def show
      {
        fields: {
          product: ProductSerializerOptions::ALL_ATTRIBUTES
        }
      }
    end

    def create
      index
    end

    def update
      index
    end
  end
end
