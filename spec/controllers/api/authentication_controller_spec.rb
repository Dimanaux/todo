# frozen_string_literal: true

require 'rails_helper'
require 'support/factory_bot'

describe Api::AuthenticationController do
  let(:user_attributes) { attributes_for(:user) }
  let(:credentials) { user_attributes.slice(:email, :password) }
  let(:invalid_credentials) { credentials.merge(password: 'oops!') }

  before { User.create!(user_attributes) }

  context 'with valid credentials' do
    describe '#create' do
      it 'succeeds' do
        post :create, body: credentials.to_json, as: :json
        expect(response).to have_http_status(:ok)
      end

      it 'gives json web token' do
        post :create, body: credentials.to_json, as: :json
        expect(response_body).to include('jwt')
      end
    end
  end

  context 'with invalid credentials' do
    describe '#create' do
      it 'responds with status "unprocessable entity"' do
        post :create, body: invalid_credentials.to_json, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'provides an error message' do
        post :create, body: invalid_credentials.to_json, as: :json
        expect(response_body).to include('error')
      end
    end
  end
end
