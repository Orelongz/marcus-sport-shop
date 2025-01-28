class ProductType < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end

# == Schema Information
#
# Table name: product_types
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_product_types_on_name  (name) UNIQUE
#
