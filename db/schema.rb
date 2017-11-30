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

ActiveRecord::Schema.define(version: 20171130123304) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "cat_name"
    t.string "cat_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "language_id", null: false
    t.integer "pattern_no", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_favorites_on_language_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "lg_name"
    t.string "lg_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patterns", force: :cascade do |t|
    t.bigint "language_id"
    t.string "cat_code"
    t.string "cat_code_24"
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
    t.index ["language_id"], name: "index_patterns_on_language_id"
  end

  create_table "phase1s", force: :cascade do |t|
    t.string "choices"
    t.string "response"
    t.string "nextquestion"
    t.integer "context_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "phase2s", force: :cascade do |t|
    t.string "choices"
    t.string "response"
    t.string "nextquestion"
    t.bigint "phase1_id"
    t.integer "context_id"
    t.string "phase"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phase1_id"], name: "index_phase2s_on_phase1_id"
  end

  create_table "phase3s", force: :cascade do |t|
    t.string "choices"
    t.string "response"
    t.string "nextquestion"
    t.bigint "phase2_id"
    t.integer "context_id"
    t.string "phase"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phase2_id"], name: "index_phase3s_on_phase2_id"
  end

  create_table "phase4s", force: :cascade do |t|
    t.string "choices"
    t.string "response"
    t.string "nextquestion"
    t.bigint "phase3_id"
    t.integer "context_id"
    t.string "phase"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phase3_id"], name: "index_phase4s_on_phase3_id"
  end

  create_table "practices", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "language_id", null: false
    t.integer "pattern_no", null: false
    t.integer "did", default: 0
    t.string "comment"
    t.boolean "done"
    t.integer "limit", null: false
    t.integer "priority"
    t.datetime "lastdate"
    t.datetime "enddate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_practices_on_language_id"
    t.index ["user_id"], name: "index_practices_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "project_name"
    t.string "project_summary"
    t.string "project_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "recommends", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "phase_1"
    t.integer "phase_2"
    t.integer "phase_3"
    t.integer "phase_4"
    t.integer "cat_code"
    t.boolean "drop", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_recommends_on_user_id"
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
