require "rails_helper"

RSpec.describe CartItems::CreateCartItem do
  let(:cart) { create(:cart) }
  let(:product) { create(:product) }
  let(:accessories) { create_list(:accessory, 3) }

  subject do
    described_class.run!(
      cart: cart,
      product_id: product.id,
      accessory_ids: accessories.pluck(:id)
    )
  end

  context "when the accessory ids are valid" do
    it "creates a cart item" do
      expect { subject }.to change { CartItem.count }.by(1)
    end

    it "creates accessory cart items" do
      expect { subject }.to change { AccessoryCartItem.count }.by(3)
    end
  end

  context "when the accessory ids are invalid" do
    let!(:constraint) do
      create(
        :complementary_accessory_constraint,
        accessory: accessories.first,
        complementary_accessory: accessories.second
      )
    end

    it "raises an error" do
      expect { subject }.to raise_error(CartItems::CreateCartItem::Error)
    end
  end
end
