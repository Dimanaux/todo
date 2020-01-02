# frozen_string_literal: true

# Manages todo items and repeats in database
module TodoItems
  PERMITTED_ATTRIBUTES = %i[
    title description uesr user_id todo_list todo_list_id
    priority repeat_from repeat_to repeat status
  ].freeze
end
