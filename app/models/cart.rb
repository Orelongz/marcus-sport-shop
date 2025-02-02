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
