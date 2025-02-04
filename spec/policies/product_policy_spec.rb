require 'rails_helper'

describe ProductPolicy do
  let(:product) { create(:product) }

  subject { ProductPolicy.new(user, product) }

  it_behaves_like "permissible for guests"
end
