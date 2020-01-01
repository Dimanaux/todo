# frozen_string_literal: true

# Todo lists policy
class TodoListPolicy < ApplicationPolicy
  def index?
    user_present?
  end

  def show?
    owns?
  end

  def create?
    user_present?
  end

  def update?
    owns?
  end

  def destroy?
    owns?
  end

  private

  def owns?
    todo_list.user == user
  end

  def user_present?
    user&.present?
  end

  def todo_list
    record
  end
end
