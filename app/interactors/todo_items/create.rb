# frozen_string_literal: true

module TodoItems
  # Creates todo items
  class Create < ModelInteractor
    include Interactor

    def call
      @todo_list = TodoItem.create(context.to_h.slice(PERMITTED_ATTRIBUTES))
      context.todo_list = @todo_list
    end

    after :create_repeats!
    after :fail_on_record_error

    def record
      @todo_list
    end

    private

    def create_repeats!
      repeat = RepeatType.of(@todo_list.repeat)
      repeat.between(@todo_list.repeat_from, @todo_list.repeat_to) do |date|
        @todo_list.repeats.create(datetime: date, status: :new)
      end
    end
  end
end
