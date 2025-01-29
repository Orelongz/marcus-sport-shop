RSpec.shared_examples "non admin users in admin routes" do
  context "unauthenticated users" do
    it 'returns 401' do
      subject

      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "a customer" do
    let(:user) { create(:user) }

    before do
      login_user(user)

      subject
    end

    it 'returns status 403' do
      expect(response).to have_http_status(:forbidden)
    end
  end
end
