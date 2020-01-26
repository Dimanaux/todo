# frozen_string_literal: true

FactoryBot.define do
  factory :todo_item do
    title { generate(:todo_item_title) }
    description { FFaker::Lorem.phrase }
    status { 'new' }
    priority { 'medium' }
    repeat_from { FFaker::Time.between(1.day.ago, 1.minute.from_now) }
    repeat_to { FFaker::Time.between(1.hour.from_now, 1.week.from_now) }
    repeat_type { 'daily' }
    association :user
    association :todo_list
  end
end
