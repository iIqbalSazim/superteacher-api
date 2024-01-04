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

ActiveRecord::Schema[7.1].define(version: 2024_01_04_052546) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classroom_global_messages", force: :cascade do |t|
    t.bigint "classroom_id", null: false
    t.bigint "user_id", null: false
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_classroom_global_messages_on_classroom_id"
    t.index ["user_id"], name: "index_classroom_global_messages_on_user_id"
  end

  create_table "classroom_students", force: :cascade do |t|
    t.bigint "classroom_id", null: false
    t.bigint "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_classroom_students_on_classroom_id"
    t.index ["student_id"], name: "index_classroom_students_on_student_id"
  end

  create_table "classrooms", force: :cascade do |t|
    t.bigint "teacher_id", null: false
    t.string "title"
    t.string "subject"
    t.time "class_time"
    t.string "days", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_classrooms_on_teacher_id"
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.string "scopes"
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri"
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "registration_codes", force: :cascade do |t|
    t.string "code"
    t.boolean "is_used"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_registration_codes_on_code"
  end

  create_table "student_profiles", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.json "education"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_student_profiles_on_student_id"
  end

  create_table "teacher_profiles", force: :cascade do |t|
    t.bigint "teacher_id", null: false
    t.string "highest_education_level"
    t.string "major_subject"
    t.text "subjects_to_teach", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_teacher_profiles_on_teacher_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.string "phone_number"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "classroom_global_messages", "classrooms", on_delete: :cascade
  add_foreign_key "classroom_global_messages", "users", on_delete: :cascade
  add_foreign_key "classroom_students", "classrooms", on_delete: :cascade
  add_foreign_key "classroom_students", "users", column: "student_id", on_delete: :cascade
  add_foreign_key "classrooms", "users", column: "teacher_id", on_delete: :cascade
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "student_profiles", "users", column: "student_id", on_delete: :cascade
  add_foreign_key "teacher_profiles", "users", column: "teacher_id", on_delete: :cascade
end
