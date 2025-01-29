require "rails_helper"

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe "GET #index" do
    let!(:products) { create_list(:product, 2) }

    before { get :index }

    it 'returns 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all products' do
      expect(parsed_body["data"].size).to eq(products.size)
      expect(
        parsed_body["data"].map { |product| product["id"].to_i }
      ).to match_array(products.map(&:id))
    end
  end

  describe "GET #show" do
    let(:product) { create(:product) }

    before { get :show, params: { id: product.id } }

    it 'returns 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the product' do
      expect(parsed_body["data"]["id"].to_i).to eq(product.id)
    end

    context "when the product does not exist" do
      let(:product) { OpenStruct.new(id: 0) }

      it 'returns 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST #create" do
    let(:product_type) { create(:product_type) }
    let(:product_params) { attributes_for(:product, product_type_id: product_type.id) }
    let(:params) { { product: product_params } }

    subject { post :create, params: params }

    it_behaves_like "non admin users in admin routes"

    context "an admin user" do
      let(:user) { create(:admin_user) }

      before do
        login_user(user)

        subject
      end

      it 'returns 201' do
        expect(response).to have_http_status(:created)
      end

      it 'creates the product' do
        expect(parsed_body["data"]["attributes"]["name"]).to eq(product_params[:name])
      end
    end
  end

  describe "PUT #update" do
    let(:product) { create(:product) }
    let(:product_params) { attributes_for(:product) }
    let(:params) { {id: product.id, product: product_params } }

    subject { put :update, params: params }

    it_behaves_like "non admin users in admin routes"

    context "an admin user" do
      let(:user) { create(:admin_user) }

      before do
        login_user(user)

        subject
      end

      it 'returns 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'creates the product' do
        expect(parsed_body["data"]["attributes"]["name"]).to eq(product_params[:name])
      end

      context "when the product does not exist" do
        let(:product) { OpenStruct.new(id: 0) }

        it 'returns 404' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    let(:product) { create(:product) }

    subject { delete :destroy, params: { id: product.id } }

    it_behaves_like "non admin users in admin routes"

    context "an admin user" do
      let(:user) { create(:admin_user) }

      before do
        login_user(user)

        subject
      end

      it 'returns 204' do
        expect(response).to have_http_status(:no_content)
      end

      context "when the product does not exist" do
        let(:product) { OpenStruct.new(id: 0) }

        it 'returns 404' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
