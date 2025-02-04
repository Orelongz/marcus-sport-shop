require 'rails_helper'

describe AccessoryPolicy do
  let(:accessory) { create(:accessory) }

  subject { AccessoryPolicy.new(user, accessory) }

  it_behaves_like "permissible for guests"
end
