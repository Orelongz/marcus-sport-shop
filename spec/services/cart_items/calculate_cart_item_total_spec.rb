require "rails_helper"

RSpec.describe CartItems::CalculateCartItemTotal do
  let(:product) { create(:product, price: 5_000) }
  let(:cart_item) { create(:cart_item, product_id: product.id) }

  subject { described_class.run!(cart_item: cart_item) }

  context "when there are no accessories" do
    it "returns the product price" do
      expect(subject).to eq(5_000)
    end
  end

  context "when there are accessory_cart_items" do
    let(:accessory_1) { create(:accessory, price: 1_000) }
    let(:accessory_2) { create(:accessory, price: 2_000) }
    let!(:accessory_cart_item_1) { create(:accessory_cart_item, accessory_id: accessory_1.id, cart_item_id: cart_item.id) }
    let!(:accessory_cart_item_2) { create(:accessory_cart_item, accessory_id: accessory_2.id, cart_item_id: cart_item.id) }

    it "returns the product price plus the accessory price" do
      expect(subject).to eq(8_000)
    end
  end

  context "when there are complementary accessories" do
    let(:accessory) { create(:accessory, price: 1_000) }
    let(:complementary_accessory) { create(:accessory, price: 2_000) }
    let!(:complementary_price) do
      create(
        :complementary_accessory_price,
        price: 1_000,
        accessory_id: accessory.id,
        complementary_accessory_id: complementary_accessory.id
      )
    end
    let!(:accessory_cart_item_1) { create(:accessory_cart_item, accessory_id: accessory.id, cart_item_id: cart_item.id) }
    let!(:accessory_cart_item_2) { create(:accessory_cart_item, accessory_id: complementary_accessory.id, cart_item_id: cart_item.id) }

    it "returns the product price plus the accessory price plus the complementary accessory price" do
      expect(subject).to eq(7_000)
    end
  end
end
