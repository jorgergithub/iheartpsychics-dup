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

ActiveRecord::Schema.define(version: 20130822234741) do

  create_table "admins", force: true do |t|
    t.integer "user_id"
  end

  create_table "answers", force: true do |t|
    t.integer  "call_survey_id"
    t.integer  "question_id"
    t.integer  "option_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "call_surveys", force: true do |t|
    t.integer  "call_id"
    t.integer  "survey_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "calls", force: true do |t|
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

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

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

  create_table "faqs", force: true do |t|
    t.text     "question"
    t.text     "answer"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "horoscopes", force: true do |t|
    t.date     "date"
    t.text     "aries"
    t.text     "taurus"
    t.text     "gemini"
    t.text     "cancer"
    t.text     "leo"
    t.text     "virgo"
    t.text     "libra"
    t.text     "scorpio"
    t.text     "sagittarius"
    t.text     "capricorn"
    t.text     "aquarius"
    t.text     "pisces"
    t.text     "lovescope"
    t.string   "friendship_compatibility_from"
    t.string   "love_compatibility_from"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "friendship_compatibility_to"
    t.string   "love_compatibility_to"
  end

  create_table "newsletters", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.date     "deliver_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "delivered_at"
  end

  create_table "options", force: true do |t|
    t.integer  "question_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "psychic_applications", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "cellular_number"
    t.string   "ssn"
    t.date     "date_of_birth"
    t.string   "emergency_contact"
    t.string   "emergency_contact_number"
    t.boolean  "us_citizen"
    t.boolean  "has_experience"
    t.text     "experience"
    t.string   "gift"
    t.text     "explain_gift"
    t.integer  "age_discovered"
    t.text     "reading_style"
    t.text     "why_work"
    t.text     "friends_describe"
    t.text     "strongest_weakest_attributes"
    t.text     "how_to_deal_challenging_client"
    t.text     "specialties"
    t.text     "tools"
    t.text     "professional_goals"
    t.string   "how_did_you_hear"
    t.text     "other"
    t.datetime "approved_at"
    t.integer  "psychic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "resume"
    t.datetime "declined_at"
    t.string   "phone"
  end

  create_table "psychics", force: true do |t|
    t.integer  "user_id"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "extension"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "cellular_number"
    t.string   "ssn"
    t.date     "date_of_birth"
    t.string   "emergency_contact"
    t.string   "emergency_contact_number"
    t.boolean  "us_citizen"
    t.boolean  "has_experience"
    t.text     "experience"
    t.string   "gift"
    t.text     "explain_gift"
    t.integer  "age_discovered"
    t.text     "reading_style"
    t.text     "why_work"
    t.text     "friends_describe"
    t.text     "strongest_weakest_attributes"
    t.text     "how_to_deal_challenging_client"
    t.text     "tools"
    t.text     "specialties"
    t.text     "professional_goals"
    t.string   "how_did_you_hear"
    t.text     "other"
    t.string   "resume"
    t.boolean  "featured"
    t.boolean  "ability_clairvoyance"
    t.boolean  "ability_clairaudient"
    t.boolean  "ability_clairsentient"
    t.boolean  "ability_empathy"
    t.boolean  "ability_medium"
    t.boolean  "ability_channeler"
    t.boolean  "ability_dream_analysis"
    t.boolean  "tools_tarot"
    t.boolean  "tools_oracle_cards"
    t.boolean  "tools_runes"
    t.boolean  "tools_crystals"
    t.boolean  "tools_pendulum"
    t.boolean  "tools_numerology"
    t.boolean  "tools_astrology"
    t.boolean  "specialties_love_and_relationships"
    t.boolean  "specialties_career_and_work"
    t.boolean  "specialties_money_and_finance"
    t.boolean  "specialties_lost_objects"
    t.boolean  "specialties_dream_interpretation"
    t.boolean  "specialties_pet_and_animals"
    t.boolean  "specialties_past_lives"
    t.boolean  "specialties_deceased"
    t.boolean  "style_compassionate"
    t.boolean  "style_inspirational"
    t.boolean  "style_straightforward"
    t.text     "about"
    t.decimal  "price",                              precision: 8, scale: 2
  end

  add_index "psychics", ["extension"], name: "index_psychics_on_extension", unique: true, using: :btree

  create_table "questions", force: true do |t|
    t.integer  "survey_id"
    t.string   "type"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.integer  "psychic_id"
    t.integer  "client_id"
    t.integer  "rating"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", force: true do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
