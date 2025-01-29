class AccessoryType < ApplicationRecord
  belongs_to :product_type

  has_many :accessories

  has_many :product_accessory_types
  has_many :products, through: :product_accessory_types

  validates :name, presence: true, uniqueness: true

  accepts_nested_attributes_for :accessories
end

# == Schema Information
#
# Table name: accessory_types
#
#  id              :bigint           not null, primary key
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  product_type_id :bigint
#
# Indexes
#
#  index_accessory_types_on_name             (name) UNIQUE
#  index_accessory_types_on_product_type_id  (product_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_type_id => product_types.id) ON DELETE => restrict
#
