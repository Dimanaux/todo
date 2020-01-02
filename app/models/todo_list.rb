# frozen_string_literal: true

# Set of todo items
class TodoList < ApplicationRecord
  validates :title, presence: true

  belongs_to :user

  has_many :todo_items, dependent: :destroy

  def as_json(options = {})
    super(options.merge(only: %i[id title description]))
  end
end
