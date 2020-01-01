# frozen_string_literal: true

module TodoLists
  # Creates todo list
  class Create < ModelInteractor
    include Interactor

    def call
      context.todo_list = TodoList.create(context.to_h.slice(:title, :description, :user, :user_id))
    end

    after :fail_on_record_error

    def record
      context.todo_list
    end
  end
end
