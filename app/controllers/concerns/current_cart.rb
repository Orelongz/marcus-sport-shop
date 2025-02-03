module CurrentCart
  extend ActiveSupport::Concern

  private

  def set_cart
    @cart = if api_user_signed_in?
      sign_in_user_cart
    else
      guest_user_cart
    end
  end

  def sign_in_user_cart
    current_api_user.cart ||
      Cart.find_by(id: session[:cart_id]) ||
      Cart.create(user_id: current_api_user.id)
  end

  def guest_user_cart
    cart = Cart.find_by(id: session[:cart_id])

    if cart.nil?
      cart = Cart.create

      session[:cart_id] = cart.id
    end

    cart
  end
end
