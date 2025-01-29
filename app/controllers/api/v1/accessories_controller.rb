module Api
  module V1
    class AccessoriesController < BaseController
      skip_before_action :authenticate_api_user!, only: %i[index show]
      before_action :accessory, only: %i[show update destroy]

      def index
        accessories = authorize(Accessory.includes(:url_media_files).in_stock)

        if params[:accessory_type_id].present?
          accessories = accessories.where(accessory_type_id: params[:accessory_type_id])
        end

        render(
          json: AccessorySerializer.new(
            accessories,
            AccessorySerializerOptions.index
          ).serializable_hash,
          status: :ok
        )
      end

      def show
        render(
          json: AccessorySerializer.new(
            @accessory,
            AccessorySerializerOptions.show
          ).serializable_hash,
          status: :ok
        )
      end

      def create
        accessory = authorize Accessory.create!(accessory_params)

        render(
          json: AccessorySerializer.new(accessory).serializable_hash,
          status: :created
        )
      end

      def update
        @accessory.update!(accessory_params)

        render(
          json: AccessorySerializer.new(@accessory).serializable_hash,
          status: :ok
        )
      end

      def destroy
        @accessory.destroy!

        head :no_content
      end

      private

      def accessory
        @accessory ||= authorize(Accessory.find(params[:id]))
      end

      def accessory_params
        params
          .require(:accessory)
          .permit(:name, :out_of_stock, :description, :price, :accessory_type_id)
      end
    end
  end
end
