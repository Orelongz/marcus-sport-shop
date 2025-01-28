class ComplementaryAccessoryPrice < ApplicationRecord
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
# Foreign Keys
#
#  fk_rails_...  (accessory_id => accessories.id) ON DELETE => cascade
#
