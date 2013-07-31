# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130731131656) do

  create_table "admins", force: true do |t|
    t.integer "user_id"
  end

  create_table "cards", force: true do |t|
    t.integer  "client_id"
    t.string   "last4"
    t.string   "type"
    t.integer  "exp_month"
    t.integer  "exp_year"
    t.string   "country"
    t.string   "address_city"
    t.string   "stripe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_calls", force: true do |t|
    t.integer  "client_id"
    t.string   "sid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "processed"
    t.string   "parent_call_sid"
    t.string   "date_created"
    t.string   "date_updated"
    t.string   "account_sid"
    t.string   "to"
    t.string   "from"
    t.string   "phone_number_sid"
    t.string   "status"
    t.string   "start_time"
    t.string   "end_time"
    t.string   "original_duration"
    t.string   "price"
    t.string   "price_unit"
    t.string   "direction"
    t.string   "answered_by"
    t.string   "caller_name"
    t.string   "uri"
    t.integer  "duration"
    t.integer  "psychic_id"
  end

  create_table "client_phones", force: true do |t|
    t.integer  "client_id"
    t.string   "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "desc"
  end

  add_index "client_phones", ["number"], name: "index_client_phones_on_number", unique: true, using: :btree

  create_table "clients", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "minutes"
    t.string   "stripe_client_id"
    t.string   "pin"
  end

  create_table "clients_psychics", id: false, force: true do |t|
    t.integer "client_id"
    t.integer "psychic_id"
  end

  add_index "clients_psychics", ["client_id", "psychic_id"], name: "index_clients_psychics_on_client_id_and_psychic_id", using: :btree

  create_table "credits", force: true do |t|
    t.integer  "client_id"
    t.integer  "minutes"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "target_id"
    t.string   "target_type"
  end

  create_table "customer_service_representatives", force: true do |t|
    t.integer  "user_id"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "available"
  end

  create_table "order_items", force: true do |t|
    t.integer  "order_id"
    t.integer  "package_id"
    t.string   "description"
    t.integer  "qty"
    t.decimal  "unit_price",  precision: 8, scale: 2
    t.decimal  "total_price", precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "client_id"
    t.decimal  "total",      precision: 8, scale: 2
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packages", force: true do |t|
    t.string   "name"
    t.integer  "minutes"
    t.decimal  "price",      precision: 8, scale: 2
    t.boolean  "active",                             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "phone"
  end

  create_table "psychics", force: true do |t|
    t.integer  "user_id"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "extension"
  end

  add_index "psychics", ["extension"], name: "index_psychics_on_extension", unique: true, using: :btree

  create_table "transactions", force: true do |t|
    t.integer  "order_id"
    t.string   "operation"
    t.string   "transaction_id"
    t.boolean  "success"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
    t.decimal  "amount",         precision: 8, scale: 2
    t.string   "card"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "role"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
