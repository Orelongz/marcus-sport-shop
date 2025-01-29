require "rails_helper"

RSpec.describe Api::V1::AccessoriesController, type: :controller do
  describe "GET #index" do
    let!(:accessory) { create_list(:accessory, 2) }

    before { get :index }

    it 'returns 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all accessory' do
      expect(parsed_body["data"].size).to eq(accessory.size)
      expect(
        parsed_body["data"].map { |accessory| accessory["id"].to_i }
      ).to match_array(accessory.map(&:id))
    end
  end

  describe "GET #show" do
    let(:accessory) { create(:accessory) }

    before { get :show, params: { id: accessory.id } }

    it 'returns 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the accessory' do
      expect(parsed_body["data"]["id"].to_i).to eq(accessory.id)
    end

    context "when the accessory does not exist" do
      let(:accessory) { OpenStruct.new(id: 0) }

      it 'returns 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST #create" do
    let(:accessory_type) { create(:accessory_type) }
    let(:accessory_params) { attributes_for(:accessory, accessory_type_id: accessory_type.id) }
    let(:params) { { accessory: accessory_params } }

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

      it 'creates the accessory' do
        expect(parsed_body["data"]["attributes"]["name"]).to eq(accessory_params[:name])
      end
    end
  end

  describe "PUT #update" do
    let(:accessory) { create(:accessory) }
    let(:accessory_params) { attributes_for(:accessory) }
    let(:params) { {id: accessory.id, accessory: accessory_params } }

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

      it 'creates the accessory' do
        expect(parsed_body["data"]["attributes"]["name"]).to eq(accessory_params[:name])
      end

      context "when the accessory does not exist" do
        let(:accessory) { OpenStruct.new(id: 0) }

        it 'returns 404' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    let(:accessory) { create(:accessory) }

    subject { delete :destroy, params: { id: accessory.id } }

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

      context "when the accessory does not exist" do
        let(:accessory) { OpenStruct.new(id: 0) }

        it 'returns 404' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
