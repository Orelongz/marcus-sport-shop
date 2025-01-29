class Accessory < ApplicationRecord
  belongs_to :accessory_type

  has_many :products, through: :accessory_type

  has_many :complementary_accessory_prices, dependent: :delete_all
  has_many :complementary_accessory_constraints, dependent: :delete_all

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  scope :in_stock, -> { where(out_of_stock: false) }
end

# == Schema Information
#
# Table name: accessories
#
#  id                    :bigint           not null, primary key
#  description           :text
#  name                  :string
#  out_of_stock          :boolean          default(FALSE)
#  price(Price in cents) :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  accessory_type_id     :bigint
#
# Indexes
#
#  index_accessories_on_accessory_type_id_and_out_of_stock  (accessory_type_id,out_of_stock)
#
# Foreign Keys
#
#  fk_rails_...  (accessory_type_id => accessory_types.id) ON DELETE => restrict
#
