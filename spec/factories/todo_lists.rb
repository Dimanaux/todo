# frozen_string_literal: true

FactoryBot.define do
  factory :todo_list do
    title { generate(:todo_list_title) }
    description { FFaker::Lorem.phrase }
    association :user, factory: :user
  end
end
