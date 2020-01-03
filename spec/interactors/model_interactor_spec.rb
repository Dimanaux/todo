# frozen_string_literal: true

require 'rails_helper'

describe ModelInteractor do
  describe '.record' do
    it 'not implemented' do
      expect { described_class.new.record }.to raise_error(NotImplementedError)
    end
  end
end
