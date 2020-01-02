# frozen_string_literal: true

module TodoItems
  # Updates todo items
  class Create < ModelInteractor
    include Interactor

    before :update_repeats!

    def call
      todo_item.update!(context.to_h.slice(PERMITTED_ATTRIBUTES))
    end

    after :fail_on_record_error

    def record
      todo_item
    end

    private

    delegate :todo_item, to: :context

    def update_repeats!
      return if repeats_same?

      repeat = RepeatType.of(todo_item.repeat_type)
      repeat.between(todo_item.repeat_from, todo_item.repeat_to) do |date|
        todo_item.repeats.create(datetime: date, status: :new)
      end
    end

    def repeats_same?
      (todo_item.repeat_from == context.repeat_from &&
          todo_item.repeat_to == context.repeat_to &&
          todo_item.repeat_type == context.repeat_type)
    end
  end
end
