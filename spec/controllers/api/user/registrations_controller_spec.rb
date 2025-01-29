require 'rails_helper'

describe Api::User::RegistrationsController, type: :request do
  before do
    post "/api/auth", params: { email: user.email, password: user.password }
  end

  context 'When creating a new user' do
    let(:user) { build(:user) }

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns a token' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns the user email' do
      expect(parsed_body["data"]["attributes"]["email"]).to eq(user.email)
    end
  end

  context 'When an email already exists' do
    let(:user) { create(:user) }

    it 'returns status 422' do
      expect(response.status).to eq(422)
    end

    it 'returns the error' do
      expect(parsed_body["message"]).to eq("Validation Failed")
      expect(parsed_body["errors"]).to be_present
    end
  end
end
