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

ActiveRecord::Schema.define(version: 20140806135015) do

  create_table "app_configs", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", force: true do |t|
    t.string   "firstname"
    t.string   "middlename"
    t.string   "lastname"
    t.string   "healthnumber"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "patient_unique_id"
    t.string   "version_code"
    t.date     "health_expiry_date"
    t.date     "birthdate"
    t.string   "gender"
    t.string   "marital_status"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "province"
    t.string   "postal_code"
    t.string   "home_phone"
    t.string   "mobile"
    t.boolean  "isactive"
  end

  create_table "physician_visits", force: true do |t|
    t.integer  "physician_id"
    t.integer  "visit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "physicians", force: true do |t|
    t.string   "physician_number"
    t.string   "firstname"
    t.string   "middlename"
    t.string   "lastname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender"
    t.string   "cpso"
    t.string   "type"
    t.string   "physician_unique_id"
    t.string   "location"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "province"
    t.string   "country"
    t.string   "postal_code"
    t.string   "phone"
    t.string   "fax"
    t.string   "emergency_number"
    t.string   "email"
    t.boolean  "isactive"
  end

  create_table "tests", force: true do |t|
    t.string   "loinc"
    t.string   "test_group"
    t.string   "test_code"
    t.string   "test_name"
    t.string   "specimen_source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "group_index"
    t.string   "index"
  end

  create_table "token_histories", force: true do |t|
    t.integer  "token_id"
    t.datetime "punch_in_time"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment"
  end

  create_table "tokens", force: true do |t|
    t.integer  "no"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.datetime "completed_at"
  end

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "middlename"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "visit_tests", force: true do |t|
    t.integer  "visit_id"
    t.integer  "test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visits", force: true do |t|
    t.integer  "patient_id"
    t.integer  "physician_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "visitdate"
    t.string   "payment_program"
    t.string   "specimen_priority"
    t.float    "amount"
  end

end
