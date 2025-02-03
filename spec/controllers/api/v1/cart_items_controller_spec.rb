require "rails_helper"

RSpec.describe Api::V1::CartItemsController, type: :controller do
  let(:user) { create(:user) }

  describe "GET #index" do
    context "when the user has items in their cart" do
      let!(:cart_items) { create_list(:cart_item, 3) }
      let!(:user_cart_items) { create_list(:cart_item, 3, cart: cart) }

      context "when the user is signed in" do
        let(:cart) { create(:cart, user: user) }

        before do
          login_user(user)
          get :index
        end

        it 'returns 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns the items in their cart' do
          expect(parsed_body["data"].size).to eq(user_cart_items.size)
          expect(
            parsed_body["data"].map { |product_type| product_type["id"].to_i }
          ).to match_array(user_cart_items.map(&:id))
        end
      end

      context "when the user is a guest user" do
        let(:cart) { create(:cart) }

        before do
          session[:cart_id] = cart.id
          get :index
        end

        it 'returns 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns the items in their cart' do
          expect(parsed_body["data"].size).to eq(user_cart_items.size)
          expect(
            parsed_body["data"].map { |product_type| product_type["id"].to_i }
          ).to match_array(user_cart_items.map(&:id))
        end
      end
    end
  end

  describe "GET #show" do
    let(:cart_item) { create(:cart_item, cart: cart) }

    context "when the user is signed in" do
      let(:cart) { create(:cart, user: user) }

      before do
        login_user(user)
        get :show, params: { id: cart_item.id }
      end

      it 'returns 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the cart_item' do
        expect(parsed_body["data"]["id"].to_i).to eq(cart_item.id)
      end

      context "when the cart_item does not exist" do
        let(:cart_item) { OpenStruct.new(id: 0) }

        it 'returns 404' do
          expect(response).to have_http_status(:not_found)
        end
      end

      context "when the cart_item is not owned by the user" do
        let(:cart_item) { create(:cart_item) }

        it 'returns 404' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context "when the user is a guest user" do
      let(:cart) { create(:cart) }

      before do
        session[:cart_id] = cart.id
        get :show, params: { id: cart_item.id }
      end

      it 'returns 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the cart_item' do
        expect(parsed_body["data"]["id"].to_i).to eq(cart_item.id)
      end

      context "when the cart_item does not exist" do
        let(:cart_item) { OpenStruct.new(id: 0) }

        it 'returns 404' do
          expect(response).to have_http_status(:not_found)
        end
      end

      context "when the cart_item is not owned by the user" do
        let(:cart_item) { create(:cart_item) }

        it 'returns 404' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

  describe "POST #create" do
    let(:product) { create(:product) }
    let(:params) { { cart_item: { product_id: product.id } } }

    subject { post :create, params: params }

    context "when the user is signed in" do
      before { login_user(user) }

      it 'returns 201' do
        subject

        expect(response).to have_http_status(:created)
      end

      it 'creates the cart_item' do
        expect { subject }.to change(CartItem, :count).by(1)

        expect(parsed_body["data"]["type"]).to eq("cart_item")
      end
    end

    context "when the user is a guest user" do
      it 'returns 201' do
        subject

        expect(response).to have_http_status(:created)
      end

      it 'creates the cart_item' do
        expect { subject }.to change(CartItem, :count).by(1)

        expect(parsed_body["data"]["type"]).to eq("cart_item")
      end
    end

    context "when error is raised by CartItems::CreateCartItem" do
      before do
        allow(CartItems::CreateCartItem)
          .to receive(:run!)
          .and_raise(CartItems::CreateCartItem::Error.new("error"))

        subject
      end

      it 'returns 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'displays the error in the response' do
        expect(parsed_body["message"]).to eq("error")
      end
    end
  end

  describe "PUT #update" do
    let(:product) { create(:product) }
    let(:cart_item) { create(:cart_item, cart: cart) }
    let(:accessories) { create_list(:accessory, 2) }

    let(:params) { { id: cart_item.id, cart_item: { accessory_ids: accessories.pluck(:id) } } }

    subject { put :update, params: params }

    context "when the user is signed in" do
      let(:cart) { create(:cart, user: user) }

      before { login_user(user) }

      it 'returns 200' do
        subject

        expect(response).to have_http_status(:ok)
      end

      it 'returns the cart_item' do
        subject

        expect(parsed_body["data"]["id"].to_i).to eq(cart_item.id)
      end

      context "when the cart_item does not exist" do
        let(:cart_item) { OpenStruct.new(id: 0) }

        it 'returns 404' do
          subject

          expect(response).to have_http_status(:not_found)
        end
      end

      context "when the cart_item is not owned by the user" do
        let(:cart_item) { create(:cart_item) }

        it 'returns 404' do
          subject

          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context "when the user is a guest" do
      let(:cart) { create(:cart) }

      before { session[:cart_id] = cart.id }

      it 'returns 200' do
        subject

        expect(response).to have_http_status(:ok)
      end

      it 'returns the cart_item' do
        subject

        expect(parsed_body["data"]["id"].to_i).to eq(cart_item.id)
      end

      context "when the cart_item does not exist" do
        let(:cart_item) { OpenStruct.new(id: 0) }

        it 'returns 404' do
          subject

          expect(response).to have_http_status(:not_found)
        end
      end

      context "when the cart_item is not owned by the user" do
        let(:cart_item) { create(:cart_item) }

        it 'returns 404' do
          subject

          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    let(:cart_item) { create(:cart_item, cart: cart) }

    context "when the user is signed in" do
      let(:cart) { create(:cart, user: user) }

      before do
        login_user(user)
        delete :destroy, params: { id: cart_item.id }
      end

      it 'returns 204' do
        expect(response).to have_http_status(:no_content)
      end

      context "when the cart_item does not exist" do
        let(:cart_item) { OpenStruct.new(id: 0) }

        it 'returns 404' do
          expect(response).to have_http_status(:not_found)
        end
      end

      context "when the cart_item is not owned by the user" do
        let(:cart_item) { create(:cart_item) }

        it 'returns 404' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context "when the user is a guest user" do
      let(:cart) { create(:cart) }

      before do
        session[:cart_id] = cart.id
        delete :destroy, params: { id: cart_item.id }
      end

      it 'returns 204' do
        expect(response).to have_http_status(:no_content)
      end

      context "when the cart_item does not exist" do
        let(:cart_item) { OpenStruct.new(id: 0) }

        it 'returns 404' do
          expect(response).to have_http_status(:not_found)
        end
      end

      context "when the cart_item is not owned by the user" do
        let(:cart_item) { create(:cart_item) }

        it 'returns 404' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
