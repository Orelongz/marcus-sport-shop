require 'rails_helper'

RSpec.describe ProductType, type: :model do
  subject { product_type.valid? }

  context 'when name is present' do
    let(:product_type) { build(:product_type, name: 'accessory type name') }

    it { is_expected.to be_truthy }
  end

  context 'when name is absent' do
    let(:product_type) { build(:product_type, name: nil) }

    it { is_expected.to be_falsey }

    it "has error" do
      subject

      expect(product_type.errors.full_messages).to include("Name can't be blank")
    end
  end
end
