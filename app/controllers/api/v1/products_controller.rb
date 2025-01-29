module Api
  module V1
    class ProductsController < BaseController
      before_action :product, only: %i[show update destroy]

      def index
        # TODO: Paginate the results
        render(
          json: ProductSerializer.new(Product.all).serialize,
          status: :ok
        )
      end

      def show
        render(
          json: ProductSerializer.new(@product).serialize,
          status: :ok
        )
      end

      def create
        product = Product.create!(product_params)

        render(
          json: ProductSerializer.new(product).serialize,
          status: :created
        )
      end

      def update
        @product.update!(product_params)

        render(
          json: ProductSerializer.new(@product).serialize,
          status: :ok
        )
      end

      def destroy
        @product.destroy!

        head status: 204
      end

      private

      def product
        @product ||= Product.find(params[:id])
      end

      def product_params
        params
          .require(:product)
          .permit(:name)
      end
    end
  end
end
