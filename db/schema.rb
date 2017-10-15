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

ActiveRecord::Schema.define(version: 20171015153553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "cat_name"
    t.string "cat_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id_id", null: false
    t.bigint "lg_code_id", null: false
    t.bigint "pattern_no_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "fav", default: true
    t.index ["lg_code_id"], name: "index_favorites_on_lg_code_id"
    t.index ["pattern_no_id"], name: "index_favorites_on_pattern_no_id"
    t.index ["user_id_id"], name: "index_favorites_on_user_id_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "lg_name"
    t.string "lg_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "uid"
  end

  create_table "patterns", force: :cascade do |t|
    t.string "lg_code"
    t.string "cat_code"
    t.integer "pattern_no"
    t.string "pattern_name"
    t.string "summary"
    t.text "context"
    t.string "b_problem"
    t.text "problem"
    t.string "b_solution"
    t.text "solution"
    t.text "consequence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "name"
    t.integer "favicon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
