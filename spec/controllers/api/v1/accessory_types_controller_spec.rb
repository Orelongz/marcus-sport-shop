require "rails_helper"

RSpec.describe Api::V1::AccessoryTypesController, type: :controller do
  let(:product_type) { create(:product_type) }

  describe "GET #index" do
    let!(:accessory_types) { create_list(:accessory_type, 2) }

    before { get :index }

    it 'returns 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all accessory_types' do
      expect(parsed_body["data"].size).to eq(accessory_types.size)
      expect(
        parsed_body["data"].map { |accessory_type| accessory_type["id"].to_i }
      ).to match_array(accessory_types.map(&:id))
    end
  end

  describe "GET #show" do
    let(:accessory_type) { create(:accessory_type) }

    before { get :show, params: { id: accessory_type.id } }

    it 'returns 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the accessory_type' do
      expect(parsed_body["data"]["id"].to_i).to eq(accessory_type.id)
    end

    context "when the accessory_type does not exist" do
      let(:accessory_type) { OpenStruct.new(id: 0) }

      it 'returns 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST #create" do
    let(:accessory_type_params) { attributes_for(:accessory_type, product_type_id: product_type.id) }
    let(:params) { { accessory_type: accessory_type_params } }

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

      it 'creates the accessory_type' do
        expect(parsed_body["data"]["attributes"]["name"]).to eq(accessory_type_params[:name])
      end
    end
  end

  describe "PUT #update" do
    let(:accessory_type) { create(:accessory_type) }
    let(:accessory_type_params) { attributes_for(:accessory_type) }
    let(:params) { {id: accessory_type.id, accessory_type: accessory_type_params } }

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

      it 'creates the accessory_type' do
        expect(parsed_body["data"]["attributes"]["name"]).to eq(accessory_type_params[:name])
      end

      context "when the accessory_type does not exist" do
        let(:accessory_type) { OpenStruct.new(id: 0) }

        it 'returns 404' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    let(:accessory_type) { create(:accessory_type) }

    subject { delete :destroy, params: { id: accessory_type.id } }

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

      context "when the accessory_type does not exist" do
        let(:accessory_type) { OpenStruct.new(id: 0) }

        it 'returns 404' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
