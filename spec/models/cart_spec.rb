require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe '#total' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product, price: 5_000) }
    let(:accessory) { create(:accessory, price: 1_000) }
    let(:cart_item) { create(:cart_item, product: product, cart: cart) }

    before do
      create(:accessory_cart_item, accessory_id: accessory.id, cart_item_id: cart_item.id)
    end

    it 'returns the total amount of the cart' do
      expect(cart.total).to eq(6_000)
    end
  end
end
