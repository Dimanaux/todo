# frozen_string_literal: true

# Todo item, bullet, thing
class TodoItem < ApplicationRecord
  validates :title, presence: true
  validates_with TodoItems::RepeatIntervalValidator

  belongs_to :user
  belongs_to :todo_list

  has_many :repeats, dependent: :destroy

  before_create :set_datetime_interval

  enum repeat_type: {
    once: 0, daily: 1, weekly: 2,
    monthly: 3, annually: 4
  }, _prefix: :repeat

  enum priority: {
    low: -5, medium: 0, high: 5
  }, _prefix: :priority

  enum status: {
    new: 0, done: 1, failed: 2
  }, _prefix: :status

  private

  def set_datetime_interval
    self.repeat_from = Time.current
    self.repeat_to = repeat_from + 1.hour
  end
end
