require 'rails_helper'

describe ProductTypePolicy do
  let(:product_type) { create(:product_type) }

  subject { ProductTypePolicy.new(user, product_type) }

  it_behaves_like "permissible for guests"
end
