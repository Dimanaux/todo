# frozen_string_literal: true

# Set of todo items
class TodoList < ApplicationRecord
  validates :title, presence: true

  belongs_to :user
end
