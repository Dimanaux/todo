# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_02_095229) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "repeats", force: :cascade do |t|
    t.datetime "datetime"
    t.bigint "todo_item_id", null: false
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["todo_item_id"], name: "index_repeats_on_todo_item_id"
  end

  create_table "todo_items", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", default: "", null: false
    t.bigint "user_id", null: false
    t.bigint "todo_list_id", null: false
    t.integer "priority", default: 0
    t.datetime "repeat_from"
    t.datetime "repeat_to"
    t.integer "repeat_type", default: 0
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["todo_list_id"], name: "index_todo_items_on_todo_list_id"
    t.index ["user_id"], name: "index_todo_items_on_user_id"
  end

  create_table "todo_lists", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description", default: "", null: false
    t.index ["user_id"], name: "index_todo_lists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "repeats", "todo_items"
  add_foreign_key "todo_items", "todo_lists"
  add_foreign_key "todo_items", "users"
  add_foreign_key "todo_lists", "users"
end
