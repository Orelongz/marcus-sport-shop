module Api
  module V1
    class AccessoryTypesController < ::Api::BaseController
      skip_before_action :authenticate_api_user!, only: %i[index show]
      before_action :accessory_type, only: %i[show update destroy]

      def index
        accessory_types = authorize(AccessoryType.all)

        if params[:product_type_id].present?
          accessory_types = accessory_types.where(product_type_id: params[:product_type_id])
        end

        render(
          json: AccessoryTypeSerializer.new(
            accessory_types,
            AccessoryTypeSerializerOptions.index
          ).serializable_hash,
          status: :ok
        )
      end

      def show
        render(
          json: AccessoryTypeSerializer.new(
            @accessory_type,
            AccessoryTypeSerializerOptions.show
          ).serializable_hash,
          status: :ok
        )
      end

      def create
        accessory_type = authorize AccessoryType.create!(accessory_type_params)

        render(
          json: AccessoryTypeSerializer.new(
            accessory_type,
            AccessoryTypeSerializerOptions.create
          ).serializable_hash,
          status: :created
        )
      end

      def update
        @accessory_type.update!(accessory_type_params)

        render(
          json: AccessoryTypeSerializer.new(
            @accessory_type,
            AccessoryTypeSerializerOptions.create
          ).serializable_hash,
          status: :ok
        )
      end

      def destroy
        @accessory_type.destroy!

        head :no_content
      end

      private

      def accessory_type
        @accessory_type ||= authorize(AccessoryType.find(params[:id]))
      end

      def accessory_type_params
        params
          .require(:accessory_type)
          .permit(:name, :product_type_id)
      end
    end
  end
end
