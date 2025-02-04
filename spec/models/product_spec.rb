require 'rails_helper'

RSpec.describe Product, type: :model do
  context "validations" do
    subject { product.valid? }

    context 'when name and price is present' do
      let(:product) { build(:product, name: 'product type name', price: 1_000) }

      it { is_expected.to be_truthy }
    end

    context 'when name is absent' do
      let(:product) { build(:product, name: nil) }

      it { is_expected.to be_falsey }

      it "has errors" do
        subject

        expect(product.errors.full_messages).to include("Name can't be blank")
      end
    end

    context 'when price is absent or less than or equal to zero' do
      let(:product) { build(:product, price: 0) }

      it { is_expected.to be_falsey }

      it "has errors" do
        subject

        expect(product.errors.full_messages).to include("Price must be greater than 0")
      end
    end
  end

  context ".in_stock" do
    let!(:in_stock_product) { create(:product, out_of_stock: false) }
    let!(:out_of_stock_product) { create(:product, out_of_stock: true) }

    it "returns accessories that are in stock" do
      expect(Product.in_stock).to eq([in_stock_product])
    end
  end
end
