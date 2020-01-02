# frozen_string_literal: true

# Repeat is a concrete date when todo item should appear again
class Repeat < ApplicationRecord
  belongs_to :todo_item

  enum status: {
    new: 0, done: 1, failed: 2
  }
end
