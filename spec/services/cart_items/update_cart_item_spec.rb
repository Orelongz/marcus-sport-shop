require "rails_helper"

RSpec.describe CartItems::UpdateCartItem do
  let(:cart_item) { create(:cart_item) }
  let(:accessories) { create_list(:accessory, 3) }
  let(:existing_accessory_cart_items) { create_list(:accessory_cart_item, 3, cart_item: cart_item) }
  let(:existing_accessories) { existing_accessory_cart_items.map(&:accessory) }

  # Choose 2 existing accessories and 2 new accessories
  let(:update_accessory_ids) { existing_accessories.take(2).concat(accessories.take(2)).pluck(:id) }

  subject do
    described_class.run!(
      cart_item: cart_item,
      accessory_ids: update_accessory_ids
    )
  end

  it "updates the cart item's accessories" do
    subject

    expect(cart_item.accessory_cart_items.pluck(:accessory_id)).to match_array(update_accessory_ids)

    expect(cart_item.accessory_cart_items.count).to eq(4)
  end

  context "when the accessory ids are invalid" do
    let!(:constraint) do
      create(
        :complementary_accessory_constraint,
        accessory: existing_accessories.first,
        complementary_accessory: accessories.first
      )
    end

    it "raises an error" do
      expect { subject }.to raise_error(CartItems::UpdateCartItem::Error)
    end
  end
end
