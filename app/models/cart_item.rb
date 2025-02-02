class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  has_many :accessory_cart_items, dependent: :delete_all

  def total
    ::CartItems::CalculateCartItemTotal.run!(cart_item: self)
  end
end

# == Schema Information
#
# Table name: cart_items
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cart_id    :bigint
#  product_id :bigint
#
# Indexes
#
#  index_cart_items_on_cart_id_and_product_id  (cart_id,product_id)
#
