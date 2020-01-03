# frozen_string_literal: true

module Api
  # Manage todo lists
  class TodoListsController < ApplicationController
    before_action :authorize_todo_list
    expose :todo_list

    # GET /api/todo_lists
    def index
      todo_lists = current_user.todo_lists
      authorize todo_lists
      render json: todo_lists
    end

    # GET /api/todo_lists/1
    def show
      render json: todo_list
    end

    # POST /api/todo_lists
    def create
      result = TodoLists::Create.call(todo_list_params.merge(user: current_user))

      if result.success?
        render json: result.todo_list, status: :created
      else
        render json: result.to_h.slice(:error), status: :unprocessable_entity
      end
    end

    # PATCH/PUT /todo_lists/1
    def update
      if todo_list.update(todo_list_params)
        render json: todo_list
      else
        render json: todo_list.errors, status: :unprocessable_entity
      end
    end

    # DELETE /todo_lists/1
    def destroy
      todo_list.destroy
    end

    private

    def authorize_todo_list
      authorize todo_list
    end

    def todo_list_params
      params.permit(:title, :description)
    end
  end
end
