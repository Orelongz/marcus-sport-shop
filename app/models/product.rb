class Product < ApplicationRecord
  include CanUseCombinedMediaConcern

  belongs_to :product_type

  has_many :product_accessory_types, dependent: :delete_all
  has_many :accessory_types, through: :product_accessory_types
  has_many :accessories, through: :accessory_types

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  scope :in_stock, -> { where(out_of_stock: false) }
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
