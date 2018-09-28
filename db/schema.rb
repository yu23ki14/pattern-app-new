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

ActiveRecord::Schema.define(version: 2018_09_27_142604) do

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

  create_table "events", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "language_id"
    t.string "event_code"
    t.string "event_name"
    t.jsonb "other_details"
    t.datetime "limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_events_on_language_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "exchart_labels", force: :cascade do |t|
    t.bigint "language_id"
    t.text "label_ja"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "label_en"
    t.index ["language_id"], name: "index_exchart_labels_on_language_id"
  end

  create_table "excharts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "language_id"
    t.jsonb "data1"
    t.jsonb "data2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "event_id"
    t.index ["event_id"], name: "index_excharts_on_event_id"
    t.index ["language_id"], name: "index_excharts_on_language_id"
    t.index ["user_id"], name: "index_excharts_on_user_id"
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
    t.string "lg_name_ja"
    t.string "lg_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lg_name_en"
  end

  create_table "learning_styles", force: :cascade do |t|
    t.bigint "user_id"
    t.jsonb "result"
    t.boolean "finished", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_learning_styles_on_user_id"
  end

  create_table "patterns", force: :cascade do |t|
    t.bigint "language_id"
    t.string "cat_code"
    t.string "cat_code_24"
    t.integer "pattern_no"
    t.string "pattern_name_ja"
    t.string "summary_ja"
    t.text "context_ja"
    t.string "b_problem_ja"
    t.text "problem_ja"
    t.string "b_solution_ja"
    t.text "solution_ja"
    t.text "consequence_ja"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pattern_name_en"
    t.string "summary_en"
    t.text "context_en"
    t.string "b_problem_en"
    t.text "problem_en"
    t.string "b_solution_en"
    t.text "solution_en"
    t.text "consequence_en"
    t.integer "axis_no"
    t.integer "learning_style_identifier"
    t.index ["language_id"], name: "index_patterns_on_language_id"
  end

  create_table "phase1s", force: :cascade do |t|
    t.string "choices_ja"
    t.string "response_ja"
    t.string "nextquestion_ja"
    t.integer "context_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "choices_en"
    t.string "response_en"
    t.string "nextquestion_en"
  end

  create_table "phase2s", force: :cascade do |t|
    t.string "choices_ja"
    t.string "response_ja"
    t.string "nextquestion_ja"
    t.bigint "phase1_id"
    t.integer "context_id"
    t.string "phase"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "choices_en"
    t.string "response_en"
    t.string "nextquestion_en"
    t.index ["phase1_id"], name: "index_phase2s_on_phase1_id"
  end

  create_table "phase3s", force: :cascade do |t|
    t.string "choices_ja"
    t.string "response_ja"
    t.string "nextquestion_ja"
    t.bigint "phase2_id"
    t.integer "context_id"
    t.string "phase"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "choices_en"
    t.string "response_en"
    t.string "nextquestion_en"
    t.index ["phase2_id"], name: "index_phase3s_on_phase2_id"
  end

  create_table "phase4s", force: :cascade do |t|
    t.string "choices_ja"
    t.string "response_ja"
    t.string "nextquestion_ja"
    t.bigint "phase3_id"
    t.integer "context_id"
    t.string "phase"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "choices_en"
    t.string "response_en"
    t.string "nextquestion_en"
    t.index ["phase3_id"], name: "index_phase4s_on_phase3_id"
  end

  create_table "practice_comments", force: :cascade do |t|
    t.bigint "practice_id"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practice_id"], name: "index_practice_comments_on_practice_id"
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
    t.integer "rate"
    t.text "action"
    t.index ["language_id"], name: "index_practices_on_language_id"
    t.index ["user_id"], name: "index_practices_on_user_id"
  end

  create_table "project_members", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_members_on_project_id"
    t.index ["user_id"], name: "index_project_members_on_user_id"
  end

  create_table "project_practice_comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "project_practice_id"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_practice_id"], name: "index_project_practice_comments_on_project_practice_id"
    t.index ["user_id"], name: "index_project_practice_comments_on_user_id"
  end

  create_table "project_practices", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "language_id", null: false
    t.integer "pattern_no", null: false
    t.integer "did", default: 0
    t.string "comment"
    t.boolean "done"
    t.integer "limit", null: false
    t.integer "priority"
    t.datetime "lastdate"
    t.datetime "enddate"
    t.integer "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "action"
    t.index ["language_id"], name: "index_project_practices_on_language_id"
    t.index ["project_id"], name: "index_project_practices_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "project_name"
    t.string "project_summary"
    t.string "project_id"
    t.string "project_color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "monday_remind", default: false
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
    t.string "locale", default: "ja", null: false
    t.boolean "monday_remind", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "excharts", "events"
  add_foreign_key "project_members", "projects"
  add_foreign_key "project_members", "users"
end
