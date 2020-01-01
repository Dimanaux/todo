# frozen_string_literal: true

# Base model that is persisted to database
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
