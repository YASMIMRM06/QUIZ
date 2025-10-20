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

ActiveRecord::Schema[7.1].define(version: 2025_10_20_142553) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "question_options", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "title", null: false
    t.boolean "is_correct", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.index ["question_id"], name: "index_question_options_on_question_id"
  end

  create_table "questionnaires", force: :cascade do |t|
    t.string "code", null: false
    t.string "title", null: false
    t.string "description"
    t.integer "duration_minutes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.bigint "user_id", null: false
    t.index ["code"], name: "index_questionnaires_on_code", unique: true
    t.index ["user_id"], name: "index_questionnaires_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "questionnaire_id", null: false
    t.string "enunciation", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.index ["questionnaire_id"], name: "index_questions_on_questionnaire_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
  end

  create_table "user_answer_histories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "questionnaire_id", null: false
    t.bigint "question_id", null: false
    t.bigint "selected_option_id", null: false
    t.boolean "is_correct"
    t.datetime "answered_at", precision: nil, null: false
    t.text "question_snapshot"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.index ["question_id"], name: "index_user_answer_histories_on_question_id"
    t.index ["questionnaire_id"], name: "index_user_answer_histories_on_questionnaire_id"
    t.index ["selected_option_id"], name: "index_user_answer_histories_on_selected_option_id"
    t.index ["user_id"], name: "index_user_answer_histories_on_user_id"
  end

  create_table "user_results", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "questionnaire_id", null: false
    t.integer "correct_answers", null: false
    t.integer "total_questions", null: false
    t.decimal "score", null: false
    t.datetime "submitted_at", precision: nil, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.index ["questionnaire_id"], name: "index_user_results_on_questionnaire_id"
    t.index ["user_id"], name: "index_user_results_on_user_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "suap_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "encrypted_password", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "question_options", "questions"
  add_foreign_key "questionnaires", "users"
  add_foreign_key "questions", "questionnaires"
  add_foreign_key "user_answer_histories", "question_options", column: "selected_option_id"
  add_foreign_key "user_answer_histories", "questionnaires"
  add_foreign_key "user_answer_histories", "questions"
  add_foreign_key "user_answer_histories", "users"
  add_foreign_key "user_results", "questionnaires"
  add_foreign_key "user_results", "users"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
