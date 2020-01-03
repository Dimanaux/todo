# frozen_string_literal: true

require 'rails_helper'
require 'support/shoulda_matchers'

describe TodoItem do
  context 'with validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :repeat_from }
    it { is_expected.to validate_presence_of :repeat_to }
  end

  context 'with associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :todo_list }
  end
end
