class ProductTypeSerializerOptions
  ALL_ATTRIBUTES = %i[id name].freeze

  class << self
    def index
      {
        fields: { product_type: ALL_ATTRIBUTES }
      }
    end

    def show
      index
    end

    def create
      index
    end

    def update
      index
    end
  end
end
