# frozen_string_literal: true

require 'support/factory_bot'

shared_context 'when authenticated' do
  let!(:current_user_attributes) { attributes_for(:user) }
  let!(:current_user) { Users::Create.call(current_user_attributes).user }
  let!(:current_user_jwt) { Users::Authenticate.call(current_user_attributes).jwt }
  let(:current_user_token) { current_user_jwt }
  let(:auth_headers) { { 'Authorization' => current_user_jwt } }

  before do
    request.headers.merge!(auth_headers)
  end
end
