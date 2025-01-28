class ProductAccessoryType < ApplicationRecord
  belongs_to :product
  belongs_to :accessory_type

  validates :product_id, uniqueness: { scope: :accessory_type_id }
end

# == Schema Information
#
# Table name: product_accessory_types
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  accessory_type_id :bigint
#  product_id        :bigint
#
# Indexes
#
#  idx_on_product_id_accessory_type_id_eb43373e4e  (product_id,accessory_type_id) UNIQUE
#
