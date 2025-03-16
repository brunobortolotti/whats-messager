# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2025_03_16_183209) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "thread_id", null: false
    t.uuid "sender_user_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "thread_user_messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "thread_id", null: false
    t.uuid "message_id", null: false
    t.uuid "recipient_user_id", null: false
    t.datetime "sent_at"
    t.datetime "delivered_at"
    t.datetime "read_at"
  end

  create_table "thread_users", id: false, force: :cascade do |t|
    t.uuid "thread_id", null: false
    t.uuid "user_id", null: false
    t.integer "unread_count", default: 0, null: false
  end

  create_table "threads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "label"
    t.string "thread_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "messages", "threads"
  add_foreign_key "messages", "users", column: "sender_user_id"
  add_foreign_key "thread_user_messages", "messages"
  add_foreign_key "thread_user_messages", "threads"
  add_foreign_key "thread_user_messages", "users", column: "recipient_user_id"
  add_foreign_key "thread_users", "threads"
  add_foreign_key "thread_users", "users"
end
