require "rails_helper"

RSpec.describe Api::V1::ProductTypesController, type: :controller do
  let!(:product_types) { create_list(:product_type, 2) }

  describe "GET #index" do
    subject { get :index }

    it 'returns all product_types' do
      subject

      expect(response).to have_http_status(:ok)
      expect(parsed_body.size).to eq(product_types.size)
      expect(parsed_body.map { |produc_type| produc_type["id"] }).to match_array(product_types.map(&:id))
    end
  end
end
