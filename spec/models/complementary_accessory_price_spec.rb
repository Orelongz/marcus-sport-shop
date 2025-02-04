require 'rails_helper'

RSpec.describe ComplementaryAccessoryPrice, type: :model do
  context "validations" do
    subject { build(:complementary_accessory_price) }

    it { should validate_uniqueness_of(:complementary_accessory_id) }
  end
end
