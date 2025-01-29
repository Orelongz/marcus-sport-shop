require 'rails_helper'

describe Api::User::SessionsController, type: :request do
  let(:user) { create(:user) }

  describe 'Sign In' do
    let(:email) { user.email }
    let(:password) { user.password }

    before do
      post '/api/auth/sign_in', params: { email: email, password: password }
    end

    it 'returns a token' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    context 'When password is missing' do
      let(:password) { nil }

      it 'returns 401' do
        expect(response.status).to eq(401)
      end
    end
  end
end
