# frozen_string_literal: true

require_relative 'todo_items'

module TodoItems
  # Updates todo items
  class Update < ModelInteractor
    include Interactor

    before :update_repeats!

    def call
      todo_item.update(context.to_h.slice(*PERMITTED_PARAMS))
    end

    after :fail_on_record_error

    def record
      todo_item
    end

    private

    delegate :todo_item, to: :context

    def update_repeats!
      return unless need_to_update_repeats?

      repeat = RepeatType.of(todo_item.repeat_type)
      repeat.between(todo_item.repeat_from, todo_item.repeat_to) do |date|
        todo_item.repeats.create(datetime: date, status: :new)
      end
    end

    def need_to_update_repeats?
      any_repeat_params? && (repeat_interval_changed? || repeat_type_changed?)
    end

    def any_repeat_params?
      context.repeat_from.nil? && context.repeat_to.nil?
    end

    def repeat_interval_changed?
      todo_item.repeat_from != context.repeat_from ||
        todo_item.repeat_to != context.repeat_to
    end

    def repeat_type_changed?
      context.repeat_type && context.repeat_type != todo_item.repeat_type
    end
  end
end
