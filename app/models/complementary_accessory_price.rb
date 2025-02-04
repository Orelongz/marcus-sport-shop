class ComplementaryAccessoryPrice < ApplicationRecord
  belongs_to :accessory
  belongs_to :complementary_accessory, class_name: "Accessory"

  validates_uniqueness_of :complementary_accessory_id
end

# == Schema Information
#
# Table name: complementary_accessory_prices
#
#  id                                                                          :bigint           not null, primary key
#  price(Price of the complemenatry accessory when combined with an accessory) :bigint
#  created_at                                                                  :datetime         not null
#  updated_at                                                                  :datetime         not null
#  accessory_id                                                                :bigint
#  complementary_accessory_id                                                  :bigint
#
# Indexes
#
#  idx_on_complementary_accessory_id_8e686d937a  (complementary_accessory_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (accessory_id => accessories.id) ON DELETE => cascade
#
