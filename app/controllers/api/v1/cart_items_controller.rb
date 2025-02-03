module Api
  module V1
    class CartItemsController < ::Api::BaseController
      include CurrentCart

      skip_before_action :authenticate_api_user!

      before_action :set_cart
      before_action :set_cart_item, only: %i[show update destroy]

      def index
        authorize CartItem
        cart_items = @cart.cart_items

        render(
          json: CartItemSerializer.new(
            cart_items,
            CartItemSerializerOptions.index
          ).serializable_hash,
          status: :ok
        )
      end

      def show
        render(
          json: CartItemSerializer.new(
            @cart_item,
            CartItemSerializerOptions.show
          ).serializable_hash,
          status: :ok
        )
      end

      def create
        authorize CartItem

        cart_item = ::CartItems::CreateCartItem.run!(
          cart: @cart,
          product_id: cart_item_params[:product_id],
          accessory_ids: cart_item_params[:accessory_ids]
        )

        render(
          json: CartItemSerializer.new(
            cart_item,
            CartItemSerializerOptions.create
          ).serializable_hash,
          status: :created
        )
      end

      def update
        cart_item = ::CartItems::UpdateCartItem.run!(
          cart_item: @cart_item,
          accessory_ids: cart_item_params[:accessory_ids]
        )

        render(
          json: CartItemSerializer.new(
            cart_item,
            CartItemSerializerOptions.create
          ).serializable_hash,
          status: :ok
        )
      end

      def destroy
        @cart_item.destroy!

        head :no_content
      end

      private

      def set_cart_item
        authorize CartItem
        @cart_item = authorize(@cart.cart_items.find(params[:id]))
      end

      def cart_item_params
        params
          .require(:cart_item)
          .permit(:product_id, accessory_ids: [])
      end
    end
  end
end
