# frozen_string_literal: true

require 'simplecov'

SimpleCov.start 'rails' do
  add_filter '/.bundle'
  add_group 'Interactors', 'app/interactors'
end
