class AccessoryCartItem < ApplicationRecord
  belongs_to :cart_item
  belongs_to :accessory
end

# == Schema Information
#
# Table name: accessory_cart_items
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  accessory_id :bigint
#  cart_item_id :bigint
#
# Indexes
#
#  index_accessory_cart_items_on_cart_item_id_and_accessory_id  (cart_item_id,accessory_id)
#
