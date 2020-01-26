class CreateRepeats < ActiveRecord::Migration[6.0]
  def change
    create_table :repeats do |t|
      t.datetime :datetime
      t.references :todo_item, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
