# frozen_string_literal: true

require 'rails_helper'

describe Users::Create do
  subject(:context) { described_class.call(user_attributes) }

  let(:user_attributes) { attributes_for(:user) }
  let(:user) { User.new(user_attributes) }

  describe '.call' do
    context 'when given valid credentials' do
      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'provides the same user' do
        expect(context.user.email).to eq(user.email)
      end

      it 'provides the persisted user instance' do
        expect(context.user).to be_persisted
      end

      it 'creates default todo list for new user' do
        expect(context.user.todo_lists.count).to be(1)
      end
    end

    context 'when given an existing email' do
      before { user.save! }

      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'provides an error' do
        expect(context.error).to be_present
      end
    end
  end
end
