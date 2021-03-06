# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_05_08_033837) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: :cascade do |t|
    t.integer "from_user"
    t.integer "to_user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "db_servers", force: :cascade do |t|
    t.integer "server_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "server_name"
  end

  create_table "db_tables", force: :cascade do |t|
    t.integer "db_server_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "db_users", force: :cascade do |t|
    t.integer "db_server_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "query"
  end

  create_table "messages", force: :cascade do |t|
    t.string "message"
    t.integer "chat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "email"
  end

  create_table "server_tasks", force: :cascade do |t|
    t.string "name"
    t.string "user"
    t.integer "pid"
    t.float "cpu"
    t.float "mem"
    t.datetime "time"
    t.integer "status"
    t.integer "server_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "servers", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
