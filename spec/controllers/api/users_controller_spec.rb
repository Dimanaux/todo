# frozen_string_literal: true

require 'rails_helper'
require 'support/factory_bot'
require 'support/shared_contexts/when_authenticated'

describe Api::UsersController do
  let(:user_attributes) { attributes_for(:user) }

  describe '#create' do
    context 'with valid credentials' do
      it 'creates a user' do
        expect { post :create, body: user_attributes.to_json, as: :json }
          .to change(User, :count).by(1)
      end

      it 'gives created user info' do
        post :create, body: user_attributes.to_json, as: :json
        expect(response_body).to include('id', 'email')
      end
    end

    context 'when email already taken' do
      before { User.create(user_attributes) }

      it 'responds with status "unprocessable entity"' do
        post :create, body: user_attributes.to_json, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'provides an error' do
        post :create, body: user_attributes.to_json, as: :json
        expect(response_body).to include('error')
      end
    end
  end

  describe '#show' do
    context 'when authenticated' do
      include_context 'when authenticated'

      it 'responds with 200 OK status' do
        get :show
        expect(response).to have_http_status(:ok)
      end

      it 'responds with current user' do
        get :show
        expect(response_body).to eq(current_user.as_json)
      end
    end

    context 'with invalid jwt' do
      it 'responds with status "unauthorized"' do
        get :show
        expect(response).to have_http_status(:unauthorized)
      end

      it 'provides an error' do
        get :show
        expect(response_body).to include('error')
      end
    end
  end

  describe '#destroy' do
    include_context 'when authenticated'

    it 'deletes user\' account' do
      expect { delete :destroy }
        .to change(User, :count).by(-1)
    end
  end
end
