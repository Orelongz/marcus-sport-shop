require "rails_helper"

RSpec.describe Api::V1::ProductTypesController, type: :controller do
  let!(:product_types) { create_list(:product_type, 2) }

  describe "GET #index" do
    before { get :index }

    it 'returns 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all product_types' do
      expect(parsed_body["data"].size).to eq(product_types.size)
      expect(
        parsed_body["data"].map { |product_type| product_type["id"].to_i }
      ).to match_array(product_types.map(&:id))
    end
  end

  describe "GET #show" do
    let(:product_type) { create(:product_type) }

    before { get :show, params: { id: product_type.id } }

    it 'returns 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the product_type' do
      expect(parsed_body["data"]["id"].to_i).to eq(product_type.id)
    end

    context "when the product_type does not exist" do
      let(:product_type) { OpenStruct.new(id: 0)  }

      it 'returns 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST #create" do
    let(:product_type_params) { attributes_for(:product_type) }
    let(:params) { { product_type: product_type_params } }

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

      it 'creates the product_type' do
        expect(parsed_body["data"]["attributes"]["name"]).to eq(product_type_params[:name])
      end
    end
  end

  describe "PUT #update" do
    let(:product_type) { create(:product_type) }
    let(:product_type_params) { attributes_for(:product_type) }
    let(:params) { {id: product_type.id, product_type: product_type_params } }

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

      it 'creates the product_type' do
        expect(parsed_body["data"]["attributes"]["name"]).to eq(product_type_params[:name])
      end

      context "when the product_type does not exist" do
        let(:product_type) { OpenStruct.new(id: 0)  }
  
        it 'returns 404' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    let(:product_type) { create(:product_type) }

    subject { delete :destroy, params: { id: product_type.id } }

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

      context "when the product_type does not exist" do
        let(:product_type) { OpenStruct.new(id: 0)  }
  
        it 'returns 404' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
