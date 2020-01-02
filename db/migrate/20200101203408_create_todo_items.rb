class CreateTodoItems < ActiveRecord::Migration[6.0]
  def change
    create_table :todo_items do |t|
      t.string :title, null: false
      t.text :description, null: false, default: ''
      t.references :user, null: false, foreign_key: true
      t.references :todo_list, null: false, foreign_key: true
      t.integer :priority, default: 0
      t.datetime :repeat_from
      t.datetime :repeat_to
      t.integer :repeat_type, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
