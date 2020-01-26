# frozen_string_literal: true

require_relative '../todo_items'

module TodoItems
  # Creates todo items
  class Create < ModelInteractor
    include Interactor

    def call
      self.todo_item = TodoItem.create(context.to_h.slice(*PERMITTED_PARAMS))
    end

    after :create_repeats!
    after :fail_on_record_error

    def record
      todo_item
    end

    private

    delegate :todo_item, :todo_item=, to: :context

    def create_repeats!
      repeat = RepeatType.of(todo_item.repeat_type)
      repeat.between(todo_item.repeat_from, todo_item.repeat_to) do |date|
        todo_item.repeats.create(datetime: date, status: :new)
      end
    end
  end
end
