# frozen_string_literal: true

require 'rails_helper'

describe Users::Authenticate do
  subject(:context) { described_class.call(user_attributes) }

  let(:user_attributes) { attributes_for(:user) }

  before { User.create!(user_attributes) }

  describe '.call' do
    context 'when given valid credentials' do
      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'provides the jwt' do
        expect(context.jwt).to be_present
      end
    end

    context 'when given invalid credentials' do
      before do
        another_password = user_attributes[:password] + 'mistype'
        user_attributes.merge!(password: another_password,
                               password_confirmation: another_password)
      end

      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'provides an error' do
        expect(context.error).to be_present
      end
    end
  end
end
