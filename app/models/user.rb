# frozen_string_literal: true

# User's account
class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_many :todo_lists, dependent: :destroy
end
