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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110717163131) do

  create_table "patients", :force => true do |t|
    t.string   "firstname"
    t.string   "middlename"
    t.string   "lastname"
    t.string   "health_insurance_number"
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

  create_table "physicians", :force => true do |t|
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

  create_table "visits", :force => true do |t|
    t.integer  "patient_id"
    t.integer  "physician_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
