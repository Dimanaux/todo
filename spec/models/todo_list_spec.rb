# frozen_string_literal: true

require 'rails_helper'
require 'support/shoulda_matchers'

describe TodoList do
  context 'with validations' do
    it { is_expected.to validate_presence_of :title }
  end

  context 'with associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many :todo_items }
  end
end
