# frozen_string_literal: true

require 'rails_helper'

describe Jwt do
  let(:payload) { { 'user_id' => 1 } }
  let(:token) { described_class.encode(payload) }

  it 'encodes and decodes' do
    expect(described_class.decode(token)).to eq(payload)
  end
end
