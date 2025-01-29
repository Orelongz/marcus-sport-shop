module Api
  module V1
    class ProductsController < BaseController
      skip_before_action :authenticate_api_user!, only: %i[index show]
      before_action :product, only: %i[show update destroy]

      def index
        # TODO: Paginate the results
        products = authorize(Product.includes(:url_media_files).in_stock)

        render(
          json: ProductSerializer.new(
            products,
            ProductSerializerOptions.index
          ).serializable_hash,
          status: :ok
        )
      end

      def show
        render(
          json: ProductSerializer.new(
            @product,
            ProductSerializerOptions.show
          ).serializable_hash,
          status: :ok
        )
      end

      def create
        product = authorize Product.create!(product_params)

        render(
          json: ProductSerializer.new(product).serializable_hash,
          status: :created
        )
      end

      def update
        @product.update!(product_params)

        render(
          json: ProductSerializer.new(@product).serializable_hash,
          status: :ok
        )
      end

      def destroy
        @product.destroy!

        head :no_content
      end

      private

      def product
        @product ||= authorize(Product.find(params[:id]))
      end

      def product_params
        params
          .require(:product)
          .permit(:name, :out_of_stock, :description, :price, :product_type_id)
      end
    end
  end
end
