require 'rails_helper'

RSpec.describe AccessoryType, type: :model do
  subject { accessory_type.valid? }

  context 'when name is present' do
    let(:accessory_type) { build(:accessory_type, name: 'accessory type name') }

    it { is_expected.to be_truthy }
  end

  context 'when name is absent' do
    let(:accessory_type) { build(:accessory_type, name: nil) }

    it { is_expected.to be_falsey }

    it "has error" do
      subject

      expect(accessory_type.errors.full_messages).to include("Name can't be blank")
    end
  end
end
