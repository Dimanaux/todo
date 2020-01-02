# frozen_string_literal: true

# Todo items endpoint
class TodoItemsController < ApplicationController
  expose :todo_item
  expose :todo_list, id: :todo_list_id
  before_action :authorize_todo_item, only: %i[show update destroy]

  # GET /api/todo_lists/1/todo_items
  def index
    authorize todo_list, :show?
    items = todo_list.todo_items
    render json: items
  end

  # GET /api/todo_items/1
  def show
    render json: todo_item
  end

  # POST /api/todo_lists/1/todo_items
  def create
    authorize todo_list, :update?

    result = TodoItems::Create.call(todo_item_params.merge(todo_list: todo_list, user: current_user))

    if result.success?
      render json: result.todo_item, status: :created
    else
      render json: result.error, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/todo_items/1
  def update
    result = TodoItems::Update.call(
      todo_item_params.merge(todo_list: todo_list, user: current_user, old_item: todo_item)
    )
    if result.success?
      render json: result.todo_item
    else
      render json: result.error, status: :unprocessable_entity
    end
  end

  # DELETE /api/todo_items/1
  def destroy
    todo_item.destroy
  end

  private

  def authorize_todo_item
    authorize todo_item
  end

  def todo_item_params
    params.require(:todo_item).permit(:title, :description, :priority, :repeat_from, :repeat_to, :repeat_type, :status)
  end
end
