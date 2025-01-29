module Api
  module V1
    class ProductTypesController < BaseController
      skip_before_action :authenticate_api_user!, only: %i[index show]
      before_action :product_type, only: %i[show update destroy]

      def index
        # TODO: Paginate the results
        product_types = authorize(ProductType.all)

        render(
          json: ProductTypeSerializer.new(product_types).serializable_hash,
          status: :ok
        )
      end

      def show
        render(
          json: ProductTypeSerializer.new(@product_type).serializable_hash,
          status: :ok
        )
      end

      def create
        product_type = authorize ProductType.create!(product_type_params)

        render(
          json: ProductTypeSerializer.new(product_type).serializable_hash,
          status: :created
        )
      end

      def update
        @product_type.update!(product_type_params)

        render(
          json: ProductTypeSerializer.new(@product_type).serializable_hash,
          status: :ok
        )
      end

      def destroy
        @product_type.destroy!

        head :no_content
      end

      private

      def product_type
        @product_type ||= authorize(ProductType.find(params[:id]))
      end

      def product_type_params
        params
          .require(:product_type)
          .permit(:name)
      end
    end
  end
end
