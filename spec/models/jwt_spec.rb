# frozen_string_literal: true

require 'rails_helper'

describe Jwt do
  let(:payload) { { 'user_id' => 1 } }
  let(:token) { 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.nPI-kOveZLkKcjV5pukoOK3I2pKYbYcSeLhomZItJCQ' }

  it 'encodes' do
    expect(described_class.encode(payload)).to eq(token)
  end

  it 'decodes' do
    expect(described_class.decode(token)).to eq(payload)
  end
end
