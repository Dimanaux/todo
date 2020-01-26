# frozen_string_literal: true

# User's account
class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_many :todo_lists, dependent: :destroy
  has_many :todo_items, through: :todo_lists

  def as_json(options = {})
    super(options.merge(only: %I[id email]))
  end
end
