# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "user_#{n}@example.com"
  end

  sequence :password do |n|
    "qwerty#{n}"
  end

  sequence :todo_list_title do |n|
    "List ##{n}"
  end
end
