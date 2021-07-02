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

ActiveRecord::Schema.define(version: 2021_06_03_105222) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "city"
    t.string "complement"
    t.string "country"
    t.string "neighborhood"
    t.integer "number"
    t.string "state"
    t.string "street"
    t.string "zip_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "fantasy_name"
    t.string "company_name"
    t.string "document_number"
    t.string "email"
    t.string "phone_number"
    t.string "responsible"
    t.string "telephone_number"
    t.string "observation"
    t.boolean "is_active", default: true
    t.bigint "address_id", null: false
    t.bigint "enterprise_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_id"], name: "index_clients_on_address_id"
    t.index ["enterprise_id"], name: "index_clients_on_enterprise_id"
  end

  create_table "ctes", force: :cascade do |t|
    t.integer "cte_number", null: false
    t.float "value", null: false
    t.bigint "enterprise_id"
    t.bigint "truckload_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enterprise_id"], name: "index_ctes_on_enterprise_id"
    t.index ["truckload_id"], name: "index_ctes_on_truckload_id"
    t.index ["user_id"], name: "index_ctes_on_user_id"
  end

  create_table "drivers", force: :cascade do |t|
    t.string "cnh_issuing_body"
    t.string "cnh_number"
    t.string "cnh_record"
    t.string "cnh_type"
    t.date "cnh_expires_at"
    t.boolean "is_employee", default: false
    t.boolean "is_blocked", default: false
    t.bigint "enterprise_id"
    t.bigint "person_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enterprise_id"], name: "index_drivers_on_enterprise_id"
    t.index ["person_id"], name: "index_drivers_on_person_id"
  end

  create_table "enterprises", force: :cascade do |t|
    t.string "logo"
    t.string "primary_color", null: false
    t.string "secondary_color", null: false
    t.string "document_number", null: false
    t.string "company_name", null: false
    t.string "fantasy_name", null: false
    t.string "email", null: false
    t.boolean "is_active", default: true, null: false
    t.date "opening_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["document_number"], name: "index_enterprises_on_document_number", unique: true
  end

  create_table "truckloads", force: :cascade do |t|
    t.integer "dt_number", null: false
    t.float "value_driver", null: false
    t.boolean "is_agent"
    t.bigint "enterprise_id"
    t.bigint "client_id"
    t.bigint "user_id"
    t.bigint "driver_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_truckloads_on_client_id"
    t.index ["driver_id"], name: "index_truckloads_on_driver_id"
    t.index ["enterprise_id"], name: "index_truckloads_on_enterprise_id"
    t.index ["user_id"], name: "index_truckloads_on_user_id"
  end

  create_table "user_people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "nickname"
    t.string "document_number"
    t.string "phone_number"
    t.string "telephone_number"
    t.string "rg"
    t.string "rg_issuing_body"
    t.datetime "birth_date"
    t.bigint "address_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_id"], name: "index_user_people_on_address_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "enterprise_id"
    t.string "kind_cd"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enterprise_id"], name: "index_user_roles_on_enterprise_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_active", default: false
    t.bigint "enterprise_id"
    t.bigint "person_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["enterprise_id"], name: "index_users_on_enterprise_id"
    t.index ["person_id"], name: "index_users_on_person_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "clients", "addresses"
  add_foreign_key "clients", "enterprises"
  add_foreign_key "ctes", "enterprises"
  add_foreign_key "ctes", "truckloads"
  add_foreign_key "ctes", "users"
  add_foreign_key "drivers", "enterprises"
  add_foreign_key "drivers", "user_people", column: "person_id"
  add_foreign_key "truckloads", "clients"
  add_foreign_key "truckloads", "drivers"
  add_foreign_key "truckloads", "enterprises"
  add_foreign_key "truckloads", "users"
  add_foreign_key "user_people", "addresses"
  add_foreign_key "user_roles", "enterprises"
  add_foreign_key "user_roles", "users"
  add_foreign_key "users", "enterprises"
  add_foreign_key "users", "user_people", column: "person_id"
end
