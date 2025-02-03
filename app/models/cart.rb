class Cart < ApplicationRecord
  belongs_to :user, optional: true

  has_many :cart_items, dependent: :delete_all
  has_many :accessory_cart_items, through: :cart_items, dependent: :delete_all

  def total
    cart_items
      .includes(accessory_cart_items: :accessory)
      .sum(&:total)
  end
end

# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_carts_on_user_id  (user_id)
#
