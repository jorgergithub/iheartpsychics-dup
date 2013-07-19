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

ActiveRecord::Schema.define(version: 20130719020140) do

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
    t.string   "encrypted_pin"
    t.integer  "minutes"
    t.integer  "favorite_psychic_id"
  end

  create_table "psychics", force: true do |t|
    t.integer  "user_id"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
