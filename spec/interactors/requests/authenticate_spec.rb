# frozen_string_literal: true

require 'rails_helper'
require 'support/factory_bot'

describe Requests::Authenticate do
  subject(:context) { described_class.call(jwt: jwt) }

  let(:user_attributes) { attributes_for(:user) }
  let(:jwt) { Jwt.encode(user_attributes.slice(:id, :email)) }

  before { User.create!(user_attributes) }

  describe '.call' do
    context 'when given valid token' do
      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'provides the user' do
        expect(context.user).to be_present
      end

      it "'s user is the same" do
        expect(context.user.email).to eq(user_attributes[:email])
      end
    end

    context 'when given invalid jwt' do
      before { jwt << 'oops!' }

      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'provides an error' do
        expect(context.error).to be_present
      end
    end
  end
end
