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

ActiveRecord::Schema.define(version: 20190413124139) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "iban"
    t.uuid "user_id"
    t.uuid "bank_id"
    t.jsonb "carte_number"
    t.integer "type"
    t.uuid "category_id"
    t.uuid "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_accounts_on_address_id"
    t.index ["bank_id"], name: "index_accounts_on_bank_id"
    t.index ["category_id"], name: "index_accounts_on_category_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "name"
    t.string "street"
    t.string "zip"
    t.string "location"
    t.string "country_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "banks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "bic"
    t.string "country_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bic"], name: "index_banks_on_bic", unique: true
    t.index ["name", "country_code"], name: "index_banks_on_name_and_country_code", unique: true
  end

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "field_imports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "template_import_id"
    t.uuid "field_id"
    t.jsonb "rule"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field_id"], name: "index_field_imports_on_field_id"
    t.index ["template_import_id", "field_id"], name: "index_field_imports_on_template_import_id_and_field_id", unique: true
    t.index ["template_import_id"], name: "index_field_imports_on_template_import_id"
  end

  create_table "fields", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "attr"
    t.string "model"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attr", "model"], name: "index_fields_on_attr_and_model", unique: true
    t.index ["name"], name: "index_fields_on_name", unique: true
  end

  create_table "template_imports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "bank_id"
    t.integer "type"
    t.jsonb "global_rule"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_id"], name: "index_template_imports_on_bank_id"
  end

  create_table "transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "account_id"
    t.uuid "contreparte_id"
    t.string "reference"
    t.decimal "amount", precision: 10, scale: 2
    t.string "currency"
    t.datetime "value_date"
    t.datetime "execution_date"
    t.string "type"
    t.string "communication"
    t.jsonb "raw"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["contreparte_id"], name: "index_transactions_on_contreparte_id"
    t.index ["user_id", "reference"], name: "index_transactions_on_user_id_and_reference", unique: true
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "addresses"
  add_foreign_key "accounts", "banks"
  add_foreign_key "accounts", "categories"
  add_foreign_key "accounts", "users"
  add_foreign_key "addresses", "users"
  add_foreign_key "field_imports", "fields"
  add_foreign_key "field_imports", "template_imports"
  add_foreign_key "template_imports", "banks"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "transactions", "accounts", column: "contreparte_id"
  add_foreign_key "transactions", "users"
end
