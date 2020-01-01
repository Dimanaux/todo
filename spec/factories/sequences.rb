# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "user_#{n}@example.com"
  end

  sequence :password do |n|
    "qwerty#{n}"
  end
end
