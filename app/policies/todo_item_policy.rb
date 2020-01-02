# frozen_string_literal: true

# Policy for todo items
class TodoItemPolicy < ApplicationPolicy
  def show?
    owns?
  end

  def update?
    owns?
  end

  def destroy?
    owns?
  end

  private

  def todo_item
    record
  end

  def owns?
    todo_list.user == user
  end

  def user_present?
    user&.present?
  end
end
