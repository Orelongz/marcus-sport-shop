require 'rails_helper'

RSpec.describe Accessory, type: :model do
  context "validations" do
    subject { accessory.valid? }

    context 'when name and price is present' do
      let(:accessory) { build(:accessory, name: 'accessory type name', price: 1_000) }

      it { is_expected.to be_truthy }
    end

    context 'when name is absent' do
      let(:accessory) { build(:accessory, name: nil) }

      it { is_expected.to be_falsey }

      it "has errors" do
        subject

        expect(accessory.errors.full_messages).to include("Name can't be blank")
      end
    end

    context 'when price is absent or less than or equal to zero' do
      let(:accessory) { build(:accessory, price: 0) }

      it { is_expected.to be_falsey }

      it "has errors" do
        subject

        expect(accessory.errors.full_messages).to include("Price must be greater than 0")
      end
    end
  end

  context ".in_stock" do
    let!(:in_stock_accessory) { create(:accessory, out_of_stock: false) }
    let!(:out_of_stock_accessory) { create(:accessory, out_of_stock: true) }

    it "returns accessories that are in stock" do
      expect(Accessory.in_stock).to eq([in_stock_accessory])
    end
  end
end
