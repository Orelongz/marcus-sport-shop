class ComplementaryAccessoryConstraint < ApplicationRecord
  belongs_to :accessory
  belongs_to :complementary_accessory, class_name: "Accessory"
end

# == Schema Information
#
# Table name: complementary_accessory_constraints
#
#  id                         :bigint           not null, primary key
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  accessory_id               :bigint
#  complementary_accessory_id :bigint
#
# Foreign Keys
#
#  fk_rails_...  (accessory_id => accessories.id) ON DELETE => cascade
#
