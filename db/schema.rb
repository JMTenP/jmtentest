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

ActiveRecord::Schema[7.0].define(version: 2023_03_13_163429) do
  create_table "accounts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "uuid"
    t.integer "role"
    t.string "referral_id"
    t.string "referred_by"
    t.string "name"
    t.string "surname"
    t.string "gender"
    t.date "birthdate"
    t.string "country"
    t.string "language"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "employees", force: :cascade do |t|
    t.integer "account_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_employees_on_account_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.integer "user_id"
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_type", "resource_id"], name: "index_notes_on_resource_type_and_resource_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
    t.index ["uuid"], name: "index_notes_on_uuid"
  end

  create_table "payments", force: :cascade do |t|
    t.string "uuid"
    t.float "amount"
    t.string "currency"
    t.string "description"
    t.datetime "operation_date", precision: nil
    t.string "status"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "accounts", "users"
end
