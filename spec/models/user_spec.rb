# frozen_string_literal: true

require 'rails_helper'
require 'support/shoulda_matchers'

describe User do
  context 'with validations' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_uniqueness_of :email }
  end

  context 'with associations' do
    it { is_expected.to have_many :todo_items }
    it { is_expected.to have_many :todo_lists }
  end
end
