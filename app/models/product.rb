class Product < ApplicationRecord
  belongs_to :product_type
end

# == Schema Information
#
# Table name: products
#
#  id                    :bigint           not null, primary key
#  description           :text
#  name                  :string
#  out_of_stock          :boolean          default(FALSE)
#  price(Price in cents) :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  product_type_id       :bigint
#
# Indexes
#
#  index_products_on_product_type_id_and_out_of_stock  (product_type_id,out_of_stock)
#
# Foreign Keys
#
#  fk_rails_...  (product_type_id => product_types.id) ON DELETE => restrict
#
