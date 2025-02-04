require 'rails_helper'

describe CartItemPolicy do
  let(:cart_item) { create(:cart_item) }

  subject { CartItemPolicy.new(user, cart_item) }

  context "for a guest" do
    let(:user) { nil }

    it { should permit(:show) }
    it { should permit(:index) }
    it { should permit(:create) }
    it { should permit(:update) }
    it { should permit(:destroy) }
  end

  context "for a user" do
    let(:user) { create(:user) }

    it { should permit(:show) }
    it { should permit(:index) }
    it { should permit(:create) }
    it { should permit(:update) }
    it { should permit(:destroy) }
  end

  context "for an admin user" do
    let(:user) { create(:admin_user) }

    it { should permit(:show) }
    it { should permit(:index) }
    it { should permit(:create) }
    it { should permit(:update) }
    it { should permit(:destroy) }
  end
end
