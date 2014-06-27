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

ActiveRecord::Schema.define(version: 20140627063557) do

# Could not dump table "patients" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "physicians" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "token_histories", force: true do |t|
    t.integer  "token_id"
    t.datetime "punch_in_time"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tokens", force: true do |t|
    t.integer  "no"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visits", force: true do |t|
    t.integer  "patient_id"
    t.integer  "physician_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
