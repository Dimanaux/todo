# frozen_string_literal: true

require 'rails_helper'
require 'support/shoulda_matchers'

describe TodoList do
  context 'with validations' do
    it { is_expected.to validate_presence_of :title }
  end
end
