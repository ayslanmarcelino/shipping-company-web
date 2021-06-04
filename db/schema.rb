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

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

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

  create_table "enterprises", force: :cascade do |t|
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_truckloads_on_client_id"
    t.index ["enterprise_id"], name: "index_truckloads_on_enterprise_id"
    t.index ["user_id"], name: "index_truckloads_on_user_id"
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
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "nickname"
    t.string "document_number", null: false
    t.boolean "is_active", default: false
    t.bigint "address_id"
    t.bigint "enterprise_id"
    t.index ["address_id"], name: "index_users_on_address_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["enterprise_id"], name: "index_users_on_enterprise_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "clients", "addresses"
  add_foreign_key "clients", "enterprises"
  add_foreign_key "ctes", "enterprises"
  add_foreign_key "ctes", "truckloads"
  add_foreign_key "ctes", "users"
  add_foreign_key "truckloads", "clients"
  add_foreign_key "truckloads", "enterprises"
  add_foreign_key "truckloads", "users"
  add_foreign_key "user_roles", "enterprises"
  add_foreign_key "user_roles", "users"
  add_foreign_key "users", "addresses"
  add_foreign_key "users", "enterprises"
end
