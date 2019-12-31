class AddDescriptionToTodoLists < ActiveRecord::Migration[6.0]
  def change
    add_column :todo_lists, :description, :text, null: false, default: ''
  end
end
