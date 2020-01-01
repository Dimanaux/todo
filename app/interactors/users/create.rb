# frozen_string_literal: true

module Users
  # Creates user
  class Create < ModelInteractor
    include Interactor

    def call
      context.user = User.create(
        email: context.email,
        password: context.password,
        password_confirmation: context.password
      )
    end

    def record
      context.user
    end

    after :create_default_todo_list
    after :fail_on_record_error

    private

    def create_default_todo_list
      TodoLists::Create.call(
        title: 'Default',
        description: 'The default todo list.',
        user: context.user
      )
    end
  end
end
